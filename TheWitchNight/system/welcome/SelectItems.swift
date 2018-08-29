//
//  SelectItems.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelectItems:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        
        for u in _listBox.children {
            if u.contains(touchPoint!) {
                let c = u as! SelectableItemComponent
                let sis = getSelectedItems()
                if sis.count >= 3 {
                    if c.selected {
                        c.selected = false
                    }
                    return
                }
                if c.selected {
                    c.selected = false
                } else {
                    c.selected = true
                }
//                _lastSelectedComponent.selected = false
//                _lastSelectedComponent = rc
//                _lastSelectedComponent.selected = true
                return
            }
        }
        
        if _prevButton.contains(touchPoint!) {
            (parent as! CreationFlow).showMinions()
        }
        if _nextButton.contains(touchPoint!) {
            if getSelectedItems().count < 1 {
                return
            }
            (parent as! CreationFlow).showSpells()
        }
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        _label.text = "选择携带物品(最多可以选择3个)"
        _closeButton.text = "返回"
        //        _closeButton.isHidden = true
        _prevButton.text = "上一步"
//        _prevButton.isHidden = true
        _nextButton.text = "下一步"
        
        addChild(_listBox)
        let twt = TheWitchsTear()
        twt._count = 10
//        twt._description = "出售可获得6个金币"
        let p = Potion()
        p._count = 5
        let ss = SealScroll()
        ss._count = 5
        let ts = TownScroll()
        ts._count = 5
        let sgb = SmallGoldBag()
        sgb._count = 1
        let bic = BagIncreaseContract()
        bic._count = 1
        let sic = StorageIncreaseContract()
        sic._count = 1
        let mic = MinionIncreaseContract()
        mic._count = 1
        _items = [twt,p,ss,ts,sgb,bic,sic,mic]
        createCharList()
    }
    
    private func createCharList() {
        let startX = -cellSize * 5
        let startY = cellSize * 2.75
        let width = cellSize * 5.5
        let height = cellSize * 1.4
        if _items.count > 0 {
            for i in 0..._items.count - 1 {
                let y = i % 4
                let x = i / 4
                
                let cc = SelectableItemComponent()
                //                cc.unit = _chars[i]
                cc.item = _items[i]
                if _items[i] is TheWitchsTear {
                    cc.des = "出售可获得6个金币"
                } else if _items[i] is Potion {
                    cc.des = "恢复50%最大生命值"
                }
                cc.position.x = startX + width * x.toFloat()
                cc.position.y = startY - height * y.toFloat()
                cc.zPosition = self.zPosition + 2
                _listBox.addChild(cc)
            }
        }
    }
    
    func getSelectedItems() -> Array<SelectableItemComponent> {
        var sis = Array<SelectableItemComponent>()
        for u in _listBox.children {
            let c = u as! SelectableItemComponent
            if c._selected {
                sis.append(c)
            }
        }
        return sis
    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _listBox = SKSpriteNode()
    var _items = Array<Item>()
//    var _lastSelectedComponent = SelectableItemComponent()
}

class SelectableItemComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        _char = Data.instance._char!
        //        _bg.removeFromParent()
        let rect = CGRect(x: 0, y: -cellSize * 1.125, width: cellSize * 4.5, height: cellSize)
        _bg = SKShapeNode(rect: rect, cornerRadius: 2)
        addChild(_bg)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var item: Item {
        set {
            let name = Label()
            name.position.x = cellSize * 0.25
            name.position.y = -26
            name.text = "[\(newValue._name)]x\(newValue._count)"
            name.align = "left"
            name.fontSize = 14
            addChild(name)
            let des = Label()
            des.position.x = cellSize * 0.25
            des.position.y = name.position.y - 20
            des.text = newValue._description
            des.align = "left"
            des.fontSize = 14
            addChild(des)
            _des = des
            _item = newValue
        }
        get {
            return _item
        }
    }
    
    var des: String {
        set {
            _des.text = newValue
        }
        get {
            return ""
        }
    }
    
    private var _des = Label()
    
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _bg.lineWidth = Data.SELECTED_STROKE_WIDTH
                _bg.strokeColor = Data.SELECTED_HIGHLIGH_COLOR
            } else {
                _bg.lineWidth = Data.UNSELECTED_STROKE_WIDTH
                _bg.strokeColor = Data.UNSELECTED_STROKE_COLOR
            }
        }
        get {
            return _selected
        }
    }
    internal var _selected = false
    
    private var _item = Item()
    private var _bg = SKShapeNode()
}
