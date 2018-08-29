//
//  DealingPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class DealingPanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if !_lastSelectedItemComponent.contains(touchPoint!) {
            _lastSelectedItemComponent.selected = false
            _lastSelectedItemComponent = SellingItemComponent()
        }
        _curArmorInfoPanel.removeFromParent()
        
        if !_counter.contains(touchPoint!) {
            _counter.removeFromParent()
        }
        
        if _closeButton.contains(touchPoint!) {
            Data.instance.stage.removePanelDefault(p: self)
            return
        }
        
        for sic in _sellingBox.children {
            if sic.contains(touchPoint!) {
                let pc = sic as! SellingItemComponent
                if !pc.selected {
                    pc.selected = true
                    _lastSelectedItemComponent.selected = false
                    _lastSelectedItemComponent = pc
                } else {
                    let char = Data.instance._char!
                    if pc.prop is SpellBook {
                        var t = TheWitchsTear()
                        for p in char._props {
                            if p is TheWitchsTear {
                                t = p as! TheWitchsTear
                                break
                            }
                        }
                        if t._count >= pc.prop._sellingPrice {
                            t._count -= pc.prop._sellingPrice
                            let l = Loot()
                            let spell = l.getSpellBook(role: char)
                            let book = SpellBook()
                            book.spell = spell
                            //                                book._price = book._quality * 2
                            char.addProp(p: book)
                            filterSellableItems()
                            createSelfItemPanel()
                        } else {
                            showMsg(text: "魔女之泪不足！")
                        }
                        return
                    }
                    if char._money >= pc.prop._sellingPrice {
                        if pc.prop is Outfit {
                            let outfit = pc.prop as! Outfit
                            char.addMoney(num: -outfit._sellingPrice)
                            setMoney()
//                            char._money -= outfit._sellingPrice
                            if outfit.isRandom {
                                outfit.create(level: Data.instance._char._level)
                                outfit.isRandom = false
                            }
//                            outfit._price = outfit._quality
                            _lastSelectedItemComponent = SellingItemComponent()
                            pc.removeFromParent()
                            Data.instance._char.addProp(p: pc.prop)
                            filterSellableItems()
                            createSelfItemPanel()
                            return
                        } else if pc.prop is Item {
                            let char = Data.instance._char!
                            let c = createCounter(sic: pc, max: 99)
                            let this = self
                            c.confirmAction = {
                                c.removeFromParent()
                                let max = pc.prop._sellingPrice * c.count
//                                this.sell(sic: pc, count: c.count)
                                if max <= char._money {
                                    char.addMoney(num: -max)
                                    this.setMoney()
                                    let item = pc.prop as! Item
                                    item._count = c.count
                                    char.addProp(p: item)
                                    this.filterSellableItems()
                                    this.createSelfItemPanel()
                                } else {
                                    showMsg(text: "金币不足！")
                                }
                            }
                            addChild(c)
                            this._counter = c
                            return
                        }
                        setMoney()
                    } else {
                        showMsg(text: "金币不足！")
                    }
                }
                if pc.prop is Outfit {
                    showArmorProperties(armor: pc)
                } else {
                    showItemProperties(armor: pc)
                }
            }
        }
        
        for sic in _itemsBox.children {
            if sic.contains(touchPoint!) {
                let pc = sic as! SellingItemComponent
                let char = Data.instance._char!
                if sic == _lastSelectedItemComponent {
                    if pc.prop is SpellBook {
                        char.removeProp(p: pc.prop)
                        var t = TheWitchsTear()
                        t._count = 0
                        var hasTear = false
                        for p in char._props {
                            if p is TheWitchsTear {
                                t = p as! TheWitchsTear
                                hasTear = true
                                break
                            }
                        }
                        t._count += pc.prop._price
                        if !hasTear {
                            char.addProp(p: t)
                        }
                        filterSellableItems()
                        createSelfItemPanel()
                        return
                    }
                    if pc.prop is Item {
                        let item = pc.prop as! Item
                        if item._count > 1 {
                            let c = createCounter(sic:pc,  max:pc.prop._count)
                            let this = self
                            c.confirmAction = {
                                c.removeFromParent()
                                this.sell(sic: pc, count: c.count)
                            }
                            addChild(c)
                            this._counter = c
                            return
                        }
                        sell(sic: pc, count: 1)
                    } else {
                        
                        let outfit = pc.prop as! Outfit
                        char.removeProp(p: pc.prop)
                        pc.removeFromParent()
                        char.addMoney(num: outfit._price)
                        setMoney()
                        filterSellableItems()
                        createSelfItemPanel()
                    }
                    return
                }
                if pc.prop is Outfit {
                    showArmorProperties(armor: pc)
                } else {
                    showItemProperties(armor: pc)
                }
                if !pc.selected {
                    pc.selected = true
                    _lastSelectedItemComponent.selected = false
                    _lastSelectedItemComponent = pc
                }
            }
        }
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createCounter(sic:SellingItemComponent, max:Int) -> Counter {
        let c = Counter()
        c.create(max:max)
        if sic.position.x > cellSize * 4 {
            c.position.x = sic.position.x - cellSize * 4.5
        } else {
            c.position.x = sic.position.x - cellSize * 0.5
        }
        c.position.y = sic.position.y - cellSize * 1.25 - 3
        c.zPosition = self.zPosition + 6
        
        return c
    }
    
    override func create() {
        createCloseButton()
//        _closeButton.position.x += cellSize * 0.5
        
        addChild(_itemsBox)
        addChild(_sellingBox)
        
        _label.text = "购买/出售：再次选择已选中的物品。"
        
//        createSellingItems()
//        createSellingItems()
        createSellingItemPanel(list: _sellingItems)
        
        _moneyLabel.position.x = cellSize * 0.5
        _moneyLabel.position.y = -_closeButton.position.y
        _moneyLabel.align = "left"
        _moneyLabel.text = "\(Data.instance._char._money)G"
        _moneyLabel.zPosition = self.zPosition + 5
        addChild(_moneyLabel)
        
        filterSellableItems()
        if _totalItems.count > _pageSize {
            createPageButtons()
        }
        createSelfItemPanel()
        _lastSelectedItemComponent.selected = false
    }
    
    private func filterSellableItems() {
        _totalItems = []
        for p in Data.instance._char._props {
            if p._price > 0 && p._count > 0 {
                _totalItems.append(p)
            }
        }
    }
    
    private var _bg2 = SKShapeNode()
    override func createPanelbackground() {
        let b = CGRect(x: -cellSize * 6, y: -cellSize * 3, width: cellSize * 5.5, height: cellSize * 6)
        let bg = SKShapeNode(rect: b, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.zPosition = self.zPosition + 2
        addChild(bg)
        _bg = bg
        
        let b2 = CGRect(x: cellSize * 0.5, y: -cellSize * 3, width: cellSize * 5.5, height: cellSize * 6)
        _bg2 = SKShapeNode(rect: b2, cornerRadius: 4)
        _bg2.fillColor = UIColor.black
        _bg2.zPosition = self.zPosition + 2
        addChild(_bg2)
    }
    
    func sell(sic:SellingItemComponent, count:Int) {
        let c = Data.instance._char!
        let cp = Data.instance._char._props
        let index = cp.index(of: sic.prop)
        if nil != index {
            if cp[index!] is Item {
                let item = cp[index!] as! Item
                item._count -= count
                c._money += item._price * count
                _moneyLabel.text = "\(c._money)G"
            }
        } else {
            debug("item not found!")
        }
        filterSellableItems()
        createSelfItemPanel()
    }
    
    private func setMoney() {
        _moneyLabel.text = "\(Data.instance._char._money)G"
    }
    
    func createSellingItems() {
        let char = Data.instance._char!
        let level = char._level
        
        let bow = Bow()
        bow.create(level: level)
        _sellingItems.append(bow)
        
        let sword = Sword()
        sword.create(level: level)
        _sellingItems.append(sword)
        
        let wand = Wand()
        wand.create(level: level)
        _sellingItems.append(wand)
        
        let dagger = Dagger()
        dagger.create(level: level)
        _sellingItems.append(dagger)
        
        let fist = Fist()
        fist.create(level: level)
        _sellingItems.append(fist)
        
        let instrument = Instrument()
        instrument.create(level: level)
        _sellingItems.append(instrument)
        
    }
    
//    func createPrice(outfit:Outfit) -> Int {
//        let total = outfit._quality * outfit._level.toInt() * 4
//        return seed(min: (total.toFloat() * 0.5).toInt(), max: total)
//    }
    
    func createSellingItemPanel(list:Array<Prop>) {
        _sellingBox.removeAllChildren()
        let startX = -cellSize * 5 + 9
        let startY = cellSize * 2 - 3
        for i in 0...list.count - 1 {
            let x = i / 4
            let y = i % 4
            let sic = SellingItemComponent()
            sic.prop = list[i]
            sic.zPosition = self.zPosition + 5
            sic.position.x = startX + x.toFloat() * cellSize * 2.25
            sic.position.y = startY - y.toFloat() * cellSize * 1.25
//            if list[i] is Outfit {
//                let outfit = list[i] as! Outfit
//                if !outfit.isRandom {
//                    list[i]._price = outfit._sellingPrice
//                }
//            }
            sic.price = list[i]._sellingPrice
            _sellingBox.addChild(sic)
        }
    }
    
    func createSelfItemPanel() {
        _itemsBox.removeAllChildren()
        let startX = cellSize * 1.5 + 9
        let startY = cellSize * 2 - 3
//        _curPageItems = Array<PropComponent>()
        if _totalItems.count > 0 {
            
            let end = getPageEnd() - 1
            let s = (_curPage - 1) * _pageSize
            if s > end {
                debug("展示装备数组下标开始大于结束")
                return
            }
            for i in s...end {
                let base = i - (_curPage - 1) * _pageSize
                let x = base % 3
                let y = base / 3
                let ac = SellingItemComponent()
                ac.prop = _totalItems[i]
                ac.position.x = startX + x.toFloat() * cellSize * 1.5
                ac.position.y = startY - y.toFloat() * cellSize * 1.25
                ac.zPosition = self.zPosition + 5
                _itemsBox.addChild(ac)
//                _curPageItems.append(ac)
            }
            
        }
    }
    
    private func showArmorProperties(armor:PropComponent) {
        let outfit = armor.prop as! Outfit
        if !armor.prop.hasInitialized && !outfit.isRandom {
            return
        }
        let ai = ArmorInfo()
        ai.create(armor: outfit)
        //        ai.position.y = armor.position.y + cellSize * 0.5
        if armor.position.x >= cellSize * 4 {
            ai.position.x = armor.position.x - ai._panelWidth - 25
        } else {
            ai.position.x = armor.position.x + cellSize * 0.5 + 5
        }
        if armor.position.y <= 0 {
            ai.position.y = ai._bgHeight - cellSize * 4 - armor.position.y
        } else {
            ai.position.y = ai._bgHeight - cellSize * 4 + armor.position.y
        }
        addChild(ai)
        _curArmorInfoPanel = ai
    }
    
    private func showItemProperties(armor:PropComponent) {
        //        if !armor._outfit.hasInitialized {
        //            return
        //        }
        let ai = ItemInfo()
        ai.create(item: armor.prop as! Item)
        //        ai.position.y = armor.position.y + cellSize * 0.5
        if armor.position.x >= cellSize * 4 {
            ai.position.x = armor.position.x - cellSize * 3.5 - 5
        } else {
            ai.position.x = armor.position.x + cellSize * 0.5 + 5
        }
        if armor.position.y <= 0 {
            ai.position.y = ai._bgHeight - cellSize * 4 - armor.position.y
        } else {
            ai.position.y = ai._bgHeight - cellSize * 4 + armor.position.y
        }
        addChild(ai)
        _curArmorInfoPanel = ai
    }
    
    private func getPageEnd() -> Int {
        let pages = _totalItems.count / _pageSize
        if pages >= _curPage {
            return _curPage * _pageSize
        }
        return _totalItems.count
    }
    
    func createRandomArmor() {
        let rp = 25
        let am = Amulet()
        am.isRandom = true
        am._sellingPrice = rp
        let a = EarRing()
        a.isRandom = true
        a._sellingPrice = rp
        let s = Shield()
        s.isRandom = true
        s._sellingPrice = rp
        let r = Ring()
        r.isRandom = true
        r._sellingPrice = rp
        let mm = MagicMark()
        mm.isRandom = true
        mm._sellingPrice = rp * 4
        let ss = SoulStone()
        ss.isRandom = true
        ss._sellingPrice = rp
        _sellingItems = [am, a, s , r, mm, ss]
    }
    
    func createRandomWeapon() {
        let price = 25
        let b = Bow()
        b.isRandom = true
        b._sellingPrice = price
//        b._price *= price
        let s = Sword()
        s.isRandom = true
        s._sellingPrice = price
//        s._price *= price
        let w = Wand()
        w._sellingPrice = price
        w.isRandom = true
//        w._price *= price
        let d = Dagger()
        d._sellingPrice = price
        d.isRandom = true
//        d._price *= price
        let bl = Blunt()
        bl._sellingPrice = price
        bl.isRandom = true
//        bl._price *= price
        let f = Fist()
        f._sellingPrice = price
        f.isRandom = true
//        f._price *= price
        let i = Instrument()
        i.isRandom = true
        i._sellingPrice = price * 4
//        i._price = 100
        _sellingItems = [b,s,w,d,bl,f,i]
    }
    
    func createMagicItems() {
        let factor = 4
        let t = TownScroll()
//        t._price *= factor
        t._count = 99
        let s = SealScroll()
//        s._price *= factor
        s._count = 99
        let p = Potion()
//        p._price *= factor
        p._count = 99
        let l = LittlePotion()
//        l._price *= factor
        l._count = 99
        _sellingItems = [t,s,p,l]
    }
    
    func createRandomBook() {
        let book = SpellBook()
        book._name = "魔法书???"
        book._quality = Quality.NORMAL
        book._description = "未知的法术书。"
        book._sellingPrice = 25
        _sellingItems = [book]
    }
    
    private var _curArmorInfoPanel = SKSpriteNode()
    internal var _sellingItems = Array<Prop>()
    private var _itemsBox = SKSpriteNode()
    private var _sellingBox = SKSpriteNode()
    internal var _lastSelectedItemComponent = SellingItemComponent()
    private var _totalItems = Array<Prop>()
    private var _moneyLabel = Label()
    
    private var _counter = Counter()
    
    private var _pageSize = 12
    private var _curPage = 1
}

class SellingItemComponent:PropComponent {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _priceLabel.position.x = cellSize * 0.75
        _priceLabel.position.y = -cellSize * 0.5
        _priceLabel.align = "left"
        addChild(_priceLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _priceLabel = Label()
    private var _price:Int = 0
    var price:Int {
        set {
            if prop is SpellBook {
                _priceLabel.text = "\(newValue)泪"
            } else {
                _priceLabel.text = "\(newValue)G"
            }
            _price = newValue
        }
        get {
            return _price
        }
    }
}


