//
//  ArmorPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ItemPanel: SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if !_lastListComponent.contains(touchPoint!) {
            _lastListComponent.selected = false
            _lastListComponent = PropComponent()
        }
        _curArmorInfoPanel.removeFromParent()
        if _nextButton.contains(touchPoint!) {
            let size = _totalItems.count / _pageSize
            if size > _curPage - 1 {
                _itemsBox.removeAllChildren()
                _curPage += 1
//                showSelectableSpells()
                createArmorsList()
            }
        } else if _prevButton.contains(touchPoint!) {
            if _curPage > 1 {
                _itemsBox.removeAllChildren()
                _curPage -= 1
                createArmorsList()
            }
        } else if _closeButton.contains(touchPoint!) {
            Data.instance.stage.removeItemPanel(panel: self)
        } else if _showAllButton.contains(touchPoint!) {
            _curPage = 1
            _totalItems = _char._props
            _totalItemsOrg = _char._props
            _itemsBox.removeAllChildren()
            createArmorsList()
            return
        } else if _discardButton.contains(touchPoint!) {
            if _discardButton.selected {
                let p = _lastListComponent.prop
                let index = _char._props.index(of: p)
                if nil != index {
                    _char._props.remove(at: index!)
                    _totalItems = _char._props
                    _totalItemsOrg = _char._props
                    _itemsBox.removeAllChildren()
                    createArmorsList()
                }
                _discardButton.selected = false
            } else {
                _discardButton.selected = true
            }
//            close()
        } else if _amulet.contains(touchPoint!) {
//            _amulet.selected = true
//            _totalItems = Array<Outfit>()
//            for i in _totalItemsOrg {
//                //                _totalItems
//                if i is Amulet {
//                    _totalItems.append(i)
//                }
//            }
//            showArmorProperties(armor: _amulet)
//            armorClickedEvent()
//            _lastArmorComponent = _amulet
            if _amulet.selected {
                amuletOff(w: _amulet)
                _amulet.selected = false
            } else {
                _totalItems = Array<Outfit>()
                for i in _totalItemsOrg {
                    //                _totalItems
                    if i is Amulet {
                        _totalItems.append(i)
                    }
                }
                armorClickedEvent()
                showArmorProperties(armor: _amulet)
                _lastArmorComponent = _amulet
                _amulet.selected = true
            }
        } else if _char.hasWeapon && _weapon.contains(touchPoint!) {
            if _weapon.selected {
                weaponOff(w: _weapon)
                _weapon.selected = false
            } else {
                _totalItems = Array<Outfit>()
                for i in _totalItemsOrg {
                    //                _totalItems
                    if i is Weapon {
                        _totalItems.append(i)
                    }
                }
                armorClickedEvent()
                showArmorProperties(armor: _weapon)
                _lastArmorComponent = _weapon
                _weapon.selected = true
            }
        } else if _char.hasEarring && _earRing.contains(touchPoint!) {
//            _earRing.selected = true
//            _totalItems = Array<Outfit>()
//            for i in _totalItemsOrg {
//                //                _totalItems
//                if i is EarRing {
//                    _totalItems.append(i)
//                }
//            }
//            armorClickedEvent()
//            _lastArmorComponent = _earRing
//            showArmorProperties(armor: _earRing)
            if _earRing.selected {
                earRingOff(w: _earRing)
                _earRing.selected = false
            } else {
                _totalItems = Array<Outfit>()
                for i in _totalItemsOrg {
                    //                _totalItems
                    if i is EarRing {
                        _totalItems.append(i)
                    }
                }
                armorClickedEvent()
                showArmorProperties(armor: _earRing)
                _lastArmorComponent = _earRing
                _earRing.selected = true
            }
        } else if _char.hasShield && _shield.contains(touchPoint!) {
//            _shield.selected = true
//            _totalItems = Array<Outfit>()
//            for i in _totalItemsOrg {
//                //                _totalItems
//                if i is Shield {
//                    _totalItems.append(i)
//                }
//            }
//            armorClickedEvent()
//            _lastArmorComponent = _shield
//            showArmorProperties(armor: _shield)
            if _shield.selected {
                shieldOff(w: _shield)
                _shield.selected = false
            } else {
                _totalItems = Array<Outfit>()
                for i in _totalItemsOrg {
                    //                _totalItems
                    if i is Shield {
                        _totalItems.append(i)
                    }
                }
                armorClickedEvent()
                showArmorProperties(armor: _shield)
                _lastArmorComponent = _shield
                _shield.selected = true
            }
        } else if _leftRing.contains(touchPoint!) {
//            _leftRing.selected = true
//            _totalItems = Array<Outfit>()
//            for i in _totalItemsOrg {
//                //                _totalItems
//                if i is Ring {
//                    _totalItems.append(i)
//                }
//            }
//            armorClickedEvent()
//            _lastArmorComponent = _leftRing
//            showArmorProperties(armor: _leftRing)
            if _leftRing.selected {
                leftRingOff(w: _leftRing)
                _leftRing.selected = false
            } else {
                _totalItems = Array<Outfit>()
                for i in _totalItemsOrg {
                    //                _totalItems
                    if i is Ring {
                        _totalItems.append(i)
                    }
                }
                armorClickedEvent()
                showArmorProperties(armor: _leftRing)
                _lastArmorComponent = _leftRing
                _leftRing.selected = true
            }
        } else if _rightRing.contains(touchPoint!) {
//            _rightRing.selected = true
//            _totalItems = Array<Outfit>()
//            for i in _totalItemsOrg {
//                //                _totalItems
//                if i is Ring {
//                    _totalItems.append(i)
//                }
//            }
//            armorClickedEvent()
//            _lastArmorComponent = _rightRing
//            showArmorProperties(armor: _rightRing)
            if _rightRing.selected {
                rightRingOff(w: _rightRing)
                _rightRing.selected = false
            } else {
                _totalItems = Array<Outfit>()
                for i in _totalItemsOrg {
                    //                _totalItems
                    if i is Ring {
                        _totalItems.append(i)
                    }
                }
                armorClickedEvent()
                showArmorProperties(armor: _rightRing)
                _lastArmorComponent = _rightRing
                _rightRing.selected = true
            }
        } else if _char.hasMark && _magicMark.contains(touchPoint!) {
//            _magicMark.selected = true
//            _totalItems = Array<Outfit>()
//            for i in _totalItemsOrg {
//                //                _totalItems
//                if i is MagicMark {
//                    _totalItems.append(i)
//                }
//            }
//            armorClickedEvent()
//            _lastArmorComponent = _magicMark
//            showArmorProperties(armor: _magicMark)
            if _magicMark.selected {
                markOff(w: _magicMark)
                _magicMark.selected = false
            } else {
                _totalItems = Array<Outfit>()
                for i in _totalItemsOrg {
                    //                _totalItems
                    if i is MagicMark {
                        _totalItems.append(i)
                    }
                }
                armorClickedEvent()
                showArmorProperties(armor: _magicMark)
                _lastArmorComponent = _magicMark
                _magicMark.selected = true
            }
        } else if _soulStone.contains(touchPoint!) {
//            _soulStone.selected = true
//            _totalItems = Array<Outfit>()
//            for i in _totalItemsOrg {
//                //                _totalItems
//                if i is SoulStone {
//                    _totalItems.append(i)
//                }
//            }
//            armorClickedEvent()
//            _lastArmorComponent = _soulStone
//            showArmorProperties(armor: _soulStone)
            if _soulStone.selected {
                soulStoneOff(w: _soulStone)
                _soulStone.selected = false
            } else {
                _totalItems = Array<Outfit>()
                for i in _totalItemsOrg {
                    //                _totalItems
                    if i is SoulStone {
                        _totalItems.append(i)
                    }
                }
                armorClickedEvent()
                showArmorProperties(armor: _soulStone)
                _lastArmorComponent = _soulStone
                _soulStone.selected = true
            }
        } else {
            var hasItemRemoved = false
            for ac in _curPageItems {
                if ac.contains(touchPoint!) {
                    if _lastListComponent.selected {
                        if _lastListComponent == ac {
                            hasItemRemoved = true
                            if _lastListComponent.prop is Weapon && _char.hasWeapon {
                                weaponOn(w: _lastListComponent)
                            } else if _lastListComponent.prop is Amulet {
                                amuletOn(w: _lastListComponent)
                            } else if _lastListComponent.prop is EarRing && _char.hasEarring {
                                earRingOn(w: _lastListComponent)
                            } else if _lastListComponent.prop is Shield && _char.hasShield {
                                shieldOn(w: _lastListComponent)
                            } else if _lastListComponent.prop is Ring {
                                if !_char._leftRing.hasInitialized || _char._rightRing.hasInitialized {
                                    leftRingOn(w: _lastListComponent)
                                } else {
                                    rightRingOn(w: _lastListComponent)
                                }
                            } else if _lastListComponent.prop is MagicMark && _char.hasMark {
                                markOn(w: _lastListComponent)
                            } else if _lastListComponent.prop is SoulStone {
                                soulStoneOn(w: _lastListComponent)
                            } else if _lastListComponent.prop is Amulet {
                                amuletOn(w: _lastListComponent)
                            } else if _lastListComponent.prop is Item {
                                if _lastListComponent.prop is SpellBook {
                                    let spellBook = _lastListComponent.prop as! SpellBook
                                    if !_char.hasSpell(spell: spellBook.spell) {
                                        _char._spells.append(spellBook.spell)
//                                        if spellBook._count > 1 {
//                                            spellBook._count -= 1
//                                            _lastListComponent.prop = spellBook
//                                        } else {
//                                        }
                                        _lastListComponent.removeFromParent()
                                        _char.removeProp(p: spellBook)
                                        showMsg(text: "你学会了技能[\(spellBook._name)]！")
                                        return
                                    }
                                } else {
                                    let item = _lastListComponent.prop as! Item
                                    if !item.useable {
                                        return
                                    }
                                    if item is Potion {
                                        let clp = CharListPanel()
                                        let ml = [_char] + _char._minions
                                        clp.create(list: ml)
                                        clp._item = item
                                        clp._panel = self
                                        _curArmorInfoPanel.removeFromParent()
                                        addChild(clp)
                                        return
                                    }
                                    item.use(target: Creature())
                                    Data.instance.stage.removeItemPanel(panel: self)
                                    
                                    return
//                                    if item is TownScroll {
//                                    }
                                }
                            }

                        }
                    }
                    _lastArmorComponent.selected = false
                    _lastListComponent.selected = false
                    _discardButton.selected = false
                    ac.selected = true
                    _lastListComponent = ac
                    if !hasItemRemoved {
                        if ac.prop is Outfit {
                            showArmorProperties(armor:ac)
                        } else if ac.prop is Item {
                            showItemProperties(armor:ac)
                        } else if ac.prop is SpellBook {
                            //showItemProperties(armor:ac)
                        }
                    }
                }
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        _height = cellSize * 6
        _startX = cellSize * -10
        _startY = cellSize * 2
        _char = Data.instance._char
//        for p in _char._props {
//            if p._type == Prop.ARMOR || p._type == Prop.WEAPON {
//                _totalItems.append(p as! Outfit)
//                _totalItemsOrg.append(p as! Outfit)
//            }
//        }
        _totalItems = _char._props
        _totalItemsOrg = _char._props
        addChild(_itemsBox)
        addChild(_roleArmorsListBox)
        
        let lb = Label()
//        lb.fontName = ""
        lb.fontSize = 16
        lb.align = "left"
        lb.position.y = cellSize * 3 + 9
        lb.position.x = -cellSize * 6.75
        lb.fontColor = UIColor.white
        lb.text = "卸下\\装备\\使用：再次点击已选中的物品。"
        addChild(lb)
    }
    
    func create() {
        createBackground()
        createArmorsPanel()
        createArmorsList()
        if _totalItems.count > _pageSize {
            createPageButton()
        }
        _closeButton = Data.createCloseButton()
        addChild(_closeButton)
        
//        _discardButton = Button()
        _discardButton.text = "丢弃"
        _discardButton.position.y = -cellSize * 3.5
        _discardButton.position.x = cellSize * 6
        addChild(_discardButton)
        
//        _showAllButton = Button()
        _showAllButton.text = "显示全部"
        _showAllButton.position.y = -cellSize * 3.5
        _showAllButton.position.x = -cellSize * 5.75
        addChild(_showAllButton)
        
        let moneylabel = Label()
        moneylabel.text = "\(Data.instance._char._money)G"
        moneylabel.align = "right"
        moneylabel.position.x = cellSize * 6.75
        moneylabel.position.y = -cellSize * 3 + 3
        addChild(moneylabel)
    }
    
    private func createBackground() {
        let armorBg = SKShapeNode(rect: CGRect(x: -cellSize * 2, y: -cellSize * 3, width: cellSize * 4.5, height: _height), cornerRadius: 4)
        armorBg.position.x = -cellSize * 4.75
        armorBg.fillColor = UIColor.black
        addChild(armorBg)
        
        let listBg = SKShapeNode(rect: CGRect(x: -cellSize * 2, y: -cellSize * 3, width: cellSize * 9, height: _height), cornerRadius: 4)
//        listBg.position.x = -cellSize * 2.5
        listBg.fillColor = UIColor.black
        addChild(listBg)
    }
    
    private func createArmorsPanel() {
        let gap = cellSize * 0.25
        _amulet = PropComponent()
        if _char._amulet.hasInitialized {
            _amulet.armor = _char._amulet
        }
        _amulet.position.x = -cellSize * 4.25 - gap
        _amulet.position.y = _startY
        _roleArmorsListBox.addChild(_amulet)
        if _char.hasEarring {
            _earRing = PropComponent()
            if _char._earRing.hasInitialized {
                _earRing.armor = _char._earRing
            }
            _earRing.position.x = -cellSize * 4.25 - gap
            _earRing.position.y = _startY - cellSize - _yGap
            _roleArmorsListBox.addChild(_earRing)
        }
        if _char.hasWeapon {
            _weapon = PropComponent()
            if _char._weapon.hasInitialized {
                _weapon.armor = _char._weapon
            }
            _weapon.position.x = -cellSize * 5.5 - gap
            _weapon.position.y = _startY - cellSize - _yGap
            _roleArmorsListBox.addChild(_weapon)
        }
        if _char.hasShield {
            _shield = PropComponent()
            if _char._shield.hasInitialized {
                _shield.armor = _char._shield
            }
            _shield.position.x = -cellSize * 3 - gap
            _shield.position.y = _startY - cellSize - _yGap
            _roleArmorsListBox.addChild(_shield)
        }
        _leftRing = PropComponent()
        if _char._leftRing.hasInitialized {
            _leftRing.armor = _char._leftRing
        }
        _leftRing.position.x = -cellSize * 5 - gap
        _leftRing.position.y = _startY - cellSize * 2 - _yGap * 2
        _roleArmorsListBox.addChild(_leftRing)

        _rightRing = PropComponent()
        if _char._rightRing.hasInitialized {
            _rightRing.armor = _char._rightRing
        }
        _rightRing.position.x = -cellSize * 3.5 - gap
        _rightRing.position.y = _startY - cellSize * 2 - _yGap * 2
        _roleArmorsListBox.addChild(_rightRing)
        if _char.hasMark {
            _magicMark = PropComponent()
            if _char._magicMark.hasInitialized {
                _magicMark.armor = _char._magicMark
            }
            _magicMark.position.x = -cellSize * 5.5 - gap
            _magicMark.position.y = _startY - cellSize * 3 - _yGap * 3
            _roleArmorsListBox.addChild(_magicMark)
        }
        
        _soulStone = PropComponent()
        if _char._soulStone.hasInitialized {
            _soulStone.armor = _char._soulStone
        }
        _soulStone.position.x = -cellSize * 3 - gap
        _soulStone.position.y = _startY - cellSize * 3 - _yGap * 3
        _roleArmorsListBox.addChild(_soulStone)
    }
    
    private func createArmorsList() {
        
//        let ac = ArmorComponent()
//        ac.position.x = -cellSize
//        ac.position.y = cellSize * 2
//        addChild(ac)
//
//        let ac1 = ArmorComponent()
//        ac1.position.x = 12
//        ac1.position.y = cellSize * 2
//        addChild(ac1)
        if _totalItems.count > _pageSize {
            _nextButton.isHidden = false
            _prevButton.isHidden = false
        } else {
            _nextButton.isHidden = true
            _prevButton.isHidden = true
        }
        
        let startX = -cellSize * 0.75
        let startY = cellSize * 2
        let width = cellSize + 12.toFloat()
        _curPageItems = Array<PropComponent>()
        if _totalItems.count > 0 {
            
            let end = getPageEnd() - 1
            let s = (_curPage - 1) * _pageSize
            if s > end {
                debug("展示装备数组下标开始大于结束")
                return
            }
            for i in s...end {
//            for i in 0...5 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 6
                let mod = base % 6
//                let sc = SpellComponent()
//                sc.setSpell(s: spells[i])
//                sc.position.y = startY - cellSize * 1.1 * y.toFloat()
//                sc.position.x = startX + cellSize * 1.1 * mod.toFloat()
//                _itemsBox.addChild(sc)
//                _curPageSpells.append(sc)
                let ac = PropComponent()
                ac.prop = _totalItems[i]
                ac.position.x = startX + width * mod.toFloat()
                ac.position.y = startY - width * y.toFloat()
                
                _itemsBox.addChild(ac)
                _curPageItems.append(ac)
            }
            
        }
    }
    
    private func getPageEnd() -> Int {
        let pages = _totalItems.count / _pageSize
        if pages >= _curPage {
            return _curPage * _pageSize
        }
        return _totalItems.count
    }
    
    private func createPageButton() {
        _prevButton = Button()
        _prevButton.text = "上页"
        _prevButton.position.y = Data.instance.screenHeight * 0.5 - cellSize * 0.5 + 5
        _prevButton.position.x = cellSize * 1.7
        addChild(_prevButton)
        
        _nextButton = Button()
        _nextButton.text = "下页"
        _nextButton.position.y = Data.instance.screenHeight * 0.5 - cellSize * 0.5 + 5
        _nextButton.position.x = cellSize * 3.85
        addChild(_nextButton)
    }
    
    private func armorClickedEvent() {
        _lastArmorComponent.selected = false
        
        if (_curPage - 1) * _pageSize > _totalItems.count {
            _curPage = 1
        }
        _itemsBox.removeAllChildren()
        createArmorsList()
    }
    
    private func showArmorProperties(armor:PropComponent) {
        if !armor.prop.hasInitialized {
            return
        }
        let ai = ArmorInfo()
        ai.create(armor: armor.prop as! Outfit)
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
    
    private func weaponOn(w:PropComponent) {
        if w.prop._level > _char._level {
            showMsg(text: "装备等级过高！")
            return
        }
        if _char._weapon.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._weapon
            armorOff(armor: ac)
        }
        _char._weapon = w.prop as! Weapon
        armorOn(armor: w)
        
        refreshBox()
    }
    
    private func weaponOff(w:PropComponent) {
        if _char._weapon.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._weapon
            armorOff(armor: ac)
            _char._weapon = Weapon()
        }
        refreshBox()
    }
    
    private func amuletOn(w:PropComponent) {
        if w.prop._level > _char._level {
            showMsg(text: "装备等级过高！")
            return
        }
        if _char._amulet.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._amulet
            armorOff(armor: ac)
        }
        _char._amulet = w.prop as! Amulet
        armorOn(armor: w)
        
        refreshBox()
    }
    
    private func amuletOff(w:PropComponent) {
        if _char._amulet.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._amulet
            armorOff(armor: ac)
            _char._amulet = Amulet()
        }
        refreshBox()
    }
    
    private func earRingOn(w:PropComponent) {
        if w.prop._level > _char._level {
            showMsg(text: "装备等级过高！")
            return
        }
        if _char._earRing.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._earRing
            armorOff(armor: ac)
        }
        _char._earRing = w.prop as! EarRing
        armorOn(armor: w)
        
        refreshBox()
    }
    
    private func earRingOff(w:PropComponent) {
        if _char._earRing.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._earRing
            armorOff(armor: ac)
            _char._earRing = EarRing()
        }
        refreshBox()
    }
    
    private func shieldOn(w:PropComponent) {
        if w.prop._level > _char._level {
            showMsg(text: "装备等级过高！")
            return
        }
        if _char._shield.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._shield
            armorOff(armor: ac)
        }
        _char._shield = w.prop as! Shield
        armorOn(armor: w)
        
        refreshBox()
    }
    
    private func shieldOff(w:PropComponent) {
        if _char._shield.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._shield
            armorOff(armor: ac)
            _char._shield = Shield()
        }
        refreshBox()
    }
    
    private func leftRingOn(w:PropComponent) {
        if w.prop._level > _char._level {
            showMsg(text: "装备等级过高！")
            return
        }
        if _char._leftRing.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._leftRing
            armorOff(armor: ac)
        }
        _char._leftRing = w.prop as! Ring
        armorOn(armor: w)
        
        refreshBox()
    }
    
    private func leftRingOff(w:PropComponent) {
        if _char._leftRing.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._leftRing
            armorOff(armor: ac)
            _char._leftRing = Ring()
        }
        refreshBox()
    }
    
    private func rightRingOn(w:PropComponent) {
        if w.prop._level > _char._level {
            showMsg(text: "装备等级过高！")
            return
        }
        if _char._rightRing.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._rightRing
            armorOff(armor: ac)
        }
        _char._rightRing = w.prop as! Ring
        armorOn(armor: w)
        
        refreshBox()
    }
    
    private func rightRingOff(w:PropComponent) {
        if _char._rightRing.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._rightRing
            armorOff(armor: ac)
            _char._rightRing = Ring()
        }
        refreshBox()
    }
    
    private func markOn(w:PropComponent) {
        if w.prop._level > _char._level {
            showMsg(text: "装备等级过高！")
            return
        }
        if _char._magicMark.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._magicMark
            armorOff(armor: ac)
        }
        _char._magicMark = w.prop as! MagicMark
        armorOn(armor: w)
        
        refreshBox()
    }
    
    private func markOff(w:PropComponent) {
        if _char._magicMark.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._magicMark
            armorOff(armor: ac)
            _char._magicMark = MagicMark()
        }
        refreshBox()
    }
    
    private func soulStoneOn(w:PropComponent) {
        if w.prop._level > _char._level {
            showMsg(text: "装备等级过高！")
            return
        }
        if _char._soulStone.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._soulStone
            armorOff(armor: ac)
        }
        _char._soulStone = w.prop as! SoulStone
        armorOn(armor: w)
        
        refreshBox()
    }
    
    private func soulStoneOff(w:PropComponent) {
        if _char._soulStone.hasInitialized {
            let ac = PropComponent()
            ac.armor = _char._soulStone
            armorOff(armor: ac)
            _char._soulStone = SoulStone()
        }
        refreshBox()
    }
    
    private func armorOn(armor:PropComponent) {
        
        var i = _totalItems.index(of: armor.prop)!
        _totalItems.remove(at: i)
        i = _totalItemsOrg.index(of: armor.prop)!
        _totalItemsOrg.remove(at: i)
        i = _char._props.index(of: armor.prop)!
        _char._props.remove(at: i)
        
        (armor.prop as! Outfit).on()
    }
    
    private func armorOff(armor:PropComponent) {
        _char._props.append(armor.prop)
        _totalItemsOrg = Array<Outfit>()
        for p in _char._props {
            if p._type == Prop.ARMOR || p._type == Prop.WEAPON {
                _totalItemsOrg.append(p as! Outfit)
            }
        }
        _totalItems.append(armor.prop)
        if armor.prop.hasInitialized {
            (armor.prop as! Outfit).off()
        }
    }
    
    
    private func refreshBox() {
        _curArmorInfoPanel.removeFromParent()
        
        _itemsBox.removeAllChildren()
        createArmorsList()
        
        _roleArmorsListBox.removeAllChildren()
        createArmorsPanel()
    }
    
    func pageReload() {
        _totalItems = _char._props
        _totalItemsOrg = _char._props
        _itemsBox.removeAllChildren()
        createArmorsList()
    }
    
//    private func removeItemFromArray(item:ArmorComponent, array:Array<ArmorComponent>) {
//        let index = array.index(of: item)
//        if nil != index {
//            array.remove(at: index)
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var _height:CGFloat = 0
    private var _startX:CGFloat = 0
    private var _startY:CGFloat = 0
    private var _yGap:CGFloat = 12
    
    private var _weapon = PropComponent()
    private var _amulet = PropComponent()
    private var _leftRing = PropComponent()
    private var _rightRing = PropComponent()
    private var _magicMark = PropComponent()
    private var _shield = PropComponent()
    private var _soulStone = PropComponent()
    private var _earRing = PropComponent()
    private var _char = Character()
    
    private var _lastArmorComponent = PropComponent()
    private var _lastListComponent = PropComponent()
    private var _curArmorInfoPanel = SKSpriteNode()
    
    private var _closeButton = Button()
    private var _nextButton = Button()
    private var _prevButton = Button()
    private var _discardButton = Button()
    private var _showAllButton = Button()
//    private var _
    
    private var _pageSize = 24
    private var _curPage = 1
    
    private var _totalItems = Array<Prop>()
    private var _totalItemsOrg = Array<Prop>()
    private var _curPageItems = Array<PropComponent>()
    private var _itemsBox = SKSpriteNode()
    private var _roleArmorsListBox = SKSpriteNode()
}

class PropComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = UIStage.PANEL_LAYER
        self.size = CGSize(width: cellSize, height: cellSize)
        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: -cellSize * 0.5, y: -cellSize * 0.5), size: self.size), cornerRadius: 2 )
        bg.fillColor = UIColor.black
//        bg.lineWidth = 2
        _bg = bg
        addChild(bg)
    }
    
    var armor:Prop {
        set {
            _outfit = newValue
            _armorImg = SKSpriteNode(texture: newValue._img)
            _bg.strokeColor = QualityColor.getColor(newValue._quality)
            if newValue.hasInitialized {
                _bg.lineWidth = 2
            } else {
                _bg.lineWidth = 1
            }
            addChild(_armorImg)
            _prop = newValue
        }
        get {
            return _outfit
        }
    }
    private var _prop = Prop()
    private var _countLabel = Label()
    var prop:Prop {
        set {
            _prop = newValue
            _armorImg = SKSpriteNode(texture: newValue._img)
            _bg.strokeColor = QualityColor.getColor(newValue._quality)
            addChild(_armorImg)
            
            if newValue is Item && !(newValue is SpellBook) {
                let num = "\((newValue as! Item)._count)"
                _countLabel.removeFromParent()
                let count = Label()
                count.align = "left"
                count.fontSize = 12
                count.position.x = -22
                count.position.y = -cellSize * 0.5 + 2
                count.text = num
                //                    count.fontColor = UIColor.black
                addChild(count)
                _countLabel = count
                var width = (4 + 7 * num.count)
                if num.count < 2 {
                    width = 14
                }
                let shape = SKShapeNode(rect: CGRect(x: Int(-cellSize * 0.5), y: Int(-cellSize * 0.5), width: width, height: 14), cornerRadius: 2)
                //                    shape.fillColor = UIColor.white
                addChild(shape)
            }
        }
        get {
            return _prop
        }
    }
    private var _selected = false
    var selected:Bool {
        set {
            if newValue {
                _bg.strokeColor = Data.SELECTED_HIGHLIGH_COLOR
                _bg.lineWidth = 4
            } else {
                _bg.strokeColor = QualityColor.getColor(_prop._quality)
                _bg.lineWidth = 1
            }
            _selected = newValue
        }
        get {
            return _selected
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _bg:SKShapeNode!
    var _outfit = Prop()
    private var _armorImg = SKSpriteNode()
    
}


