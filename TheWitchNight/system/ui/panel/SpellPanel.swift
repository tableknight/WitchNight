//
//  File.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/12.
//  Copyright © 2018年 Chen. All rights reserved.
//  let spellPanel = SpellPanel()
//  spellPanel.create(role:Creature)
//  stage.addChild(spellPanel)
//

import SpriteKit

class SpellPanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        _curInfoPanel.removeFromParent()
//        if _curInfoPanel.contains(touchPoint!) && contains(_curInfoPanel) {
//            return
//        }
        if _nextButton.contains(touchPoint!) {
            let size = Data.instance._char._spells.count / _pageSize
            if size > _curPage - 1 {
                _spellsBox.removeAllChildren()
                _curPage += 1
                showSelectableSpells()
            }
            return
        }
        if _prevButton.contains(touchPoint!) {
            if _curPage > 1 {
                _spellsBox.removeAllChildren()
                _curPage -= 1
                showSelectableSpells()
            }
            return
        }
        if _closeButton.contains(touchPoint!) {
            close()
            return
        }
        if _lastSelectedSC.contains(touchPoint!) && _spellsBox.contains(_lastSelectedSC) {
            _lastSelectedRoleSC.selected = false
            if _lastSelectedSC.selected {
                if _role._spellsInuse.count < _role._spellCount {
                    let index = Data.instance._char._spells.index(of: _lastSelectedSC._spell)
                    if nil != index {
                        if instrumentMonatNotes() {
                            let spells = getSpellWhichFromMonatNotes()
                            if spells.count < 2 {
                                _role._spellsInuse.append(_lastSelectedSC._spell)
                                pageReload()
                                return
                            }
                        }
                        Data.instance._char._spells.remove(at: index!)
                        _role._spellsInuse.append(_lastSelectedSC._spell)
                        pageReload()
                    }
                }
            } else {
                _lastSelectedSC.selected = true
                showInfo(sc: _lastSelectedSC)
            }
            return
        }
        if _lastSelectedRoleSC.contains(touchPoint!) && _roleSpells.contains(_lastSelectedRoleSC) {
            _lastSelectedSC.selected = false
            if _lastSelectedRoleSC.selected {
                let index = _role._spellsInuse.index(of: _lastSelectedRoleSC._spell)
                if nil != index {
                    _role._spellsInuse.remove(at: index!)
                    if !Data.instance._char.hasSpell(spell: _lastSelectedRoleSC._spell) {
                        Data.instance._char._spells.append(_lastSelectedRoleSC._spell)
                    }
                    pageReload()
                }
            } else {
                _lastSelectedRoleSC.selected = true
                showInfo(sc: _lastSelectedRoleSC)
            }
            return
        }
        _lastSelectedRoleSC.selected = false
        _lastSelectedSC.selected = false
        for sc in _roleSpellComponents {
            if sc.contains(touchPoint!) {
                sc.selected = true
                _lastSelectedRoleSC = sc
                showInfo(sc:sc)
                break
                //                    _descLabel.text = "[\(sc._spell._name)] \(sc._spell._description)"
            }
        }
        for sc in _curPageSpells {
            if sc.contains(touchPoint!) {
                sc.selected = true
                _lastSelectedSC = sc
                showInfo(sc:sc)
                break
                //                    _descLabel.text = "[\(sc._spell._name)] \(sc._spell._description)"
            }
        }
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        zPosition = UIStage.PANEL_LAYER
//        self.size = CGSize(width: cellSize, height: cellSize)
        let roleBox = SKShapeNode(rect: CGRect(origin: CGPoint(x: -cellSize * 6.5, y: cellSize), size: CGSize(width: cellSize * 13.25, height: cellSize * 2)), cornerRadius: 4 )
        roleBox.fillColor = UIColor.black
        roleBox.zPosition = self.zPosition + 2
        addChild(roleBox)
        
        let spellBox = SKShapeNode(rect: CGRect(origin: CGPoint(x: -cellSize * 6.5, y: -cellSize * 3), size: CGSize(width: cellSize * 13.25, height: cellSize * 3.75)), cornerRadius: 4 )
        spellBox.fillColor = UIColor.black
        spellBox.zPosition = self.zPosition + 2
        addChild(spellBox)
//        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: -cellSize * 0.5, y: -cellSize * 0.5), size: self.size), cornerRadius: 4 )
//        bg.fillColor = UIColor.black
//        addChild(bg)
        isUserInteractionEnabled = true
        
    }
    override func createPanelbackground() {
        
    }
//    private var _spellBox
    var _role:Creature!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.position.x = cellSize * 0.5
    }
    
    func instrumentMonatNotes() -> Bool {
        if Data.instance._char._weapon is TheMonatNotes {
            let mn = Data.instance._char._weapon as! TheMonatNotes
            if mn._spellAppended {
                return true
            }
        }
        return false
    }
    func getSpellWhichFromMonatNotes() -> Array<Spell> {
        var spells = Array<Spell>()
        let _char = Data.instance._char!
        let mn = _char._weapon as! TheMonatNotes
        for s in Data.instance._char._spells {
            if s == mn._spell {
                spells.append(s)
            }
        }
        for s in _char._spellsInuse {
            if s == mn._spell {
                spells.append(s)
            }
        }
        
        for u in _char._minions {
            for s in u._spellsInuse {
                if s == mn._spell {
                    spells.append(s)
                }
            }
        }
        
        for u in _char._storedMinions {
            for s in u._spellsInuse {
                if s == mn._spell {
                    spells.append(s)
                }
            }
        }
        
        return spells
    }
    
    func create(role:Creature) {
        _role = role
//        let siu = role._spellsInuse
//        let roleBoxStartX = -cellSize * 6
//        let startY = cellSize * 2
//        let sc = SpellComponent()
//        sc.position.x = roleBoxStartX
//        sc.position.y = startY
//        addChild(sc)
        _closeButton = Button()
        _closeButton.zPosition = self.zPosition + 2
        _closeButton.text = "关闭"
        _closeButton.position.y = Data.instance.screenHeight * 0.5 - cellSize * 0.5 + 5
        _closeButton.position.x = cellSize * 5.75
        addChild(_closeButton)
        showRoleSpells()
        if Data.instance._char._spells.count > _pageSize {
            createPageButton()
        }
        showSelectableSpells()
        
//        let _desc = SKSpriteNode()
//        _desc.position.y = -Data.instance.screenHeight * 0.5 + cellSize * 0.5 - 5
//        _descLabel = Label()
//        _descLabel.align = "left"
//        _descLabel.fontSize = 14
////        _descLabel.text = "描述"
//        _descLabel.position.x = -cellSize * 6.75
//        _descLabel.position.y = -cellSize * 0.15
//        _desc.addChild(_descLabel)
//
//        let bg = SKShapeNode(rect: CGRect(x: -cellSize * 7, y: -cellSize * 0.375, width: cellSize * 13.5, height: cellSize * 0.75), cornerRadius: 2)
//        bg.fillColor = UIColor.black
//        _desc.addChild(bg)
        
        
//        _descLabel.text = "关闭"
        
        
        
//        addChild(_desc)
        addChild(_spellsBox)
        addChild(_roleSpells)
        
        let avatar = SKSpriteNode()
        avatar.texture = role._img.getCell(1, 0)
        avatar.size = CGSize(width: cellSize * 0.75, height: cellSize * 0.75)
        avatar.zPosition = self.zPosition + 2
        avatar.position.x = -cellSize * 6.125
        avatar.position.y = Data.instance.screenHeight * 0.5 - cellSize * 0.5 + 5
        let abg = SKShapeNode(rect: CGRect(x: avatar.position.x - cellSize * 0.375, y: avatar.position.y - cellSize * 0.375, width: cellSize * 0.75, height: cellSize * 0.75), cornerRadius: 2)
        abg.fillColor = UIColor.black
        
        let lv = Label()
        lv.zPosition = self.zPosition + 2
        lv.align = "left"
        lv.position.x = avatar.position.x + cellSize * 0.5
        lv.position.y = avatar.position.y - cellSize * 0.35
        lv.fontSize = 16
        lv.text = "Lv.\(role._level.toInt()) [\(role._name)] 技能栏: \(role._spellCount)"
        lv.fontColor = QualityColor.getColor(role._quality)
        addChild(lv)
//        avatar.addChild(abg)
        addChild(abg)
        addChild(avatar)
    }
    private var _descLabel:Label!
    private var _roleSpellComponents = Array<SpellComponent>()
    private func showRoleSpells() {
        let siu = _role._spellsInuse
        let startX = -cellSize * 5.5
        let startY = cellSize * 2
        _roleSpellComponents = Array<SpellComponent>()
        if siu.count > 0 {
            for i in 0...siu.count - 1 {
                let x = i % 10
                let sc = SpellComponent()
                sc.setSpell(s: siu[i])
                sc.position.y = startY
                sc.position.x = startX + cellSize * 1.25 * x.toFloat()
                sc.zPosition = self.zPosition + 3
                _roleSpells.addChild(sc)
                _roleSpellComponents.append(sc)
            }
            
        }
    }
    private var _curPageSpells = Array<SpellComponent>()
    private var _spellsBox = SKSpriteNode()
    private var _roleSpells = SKSpriteNode()
    private var _lastSelectedSC = SpellComponent()
    private var _lastSelectedRoleSC = SpellComponent()
    private func showSelectableSpells() {
        let spells = Data.instance._char._spells
        let startX = -cellSize * 5.5
        let startY:CGFloat = -cellSize * 0.25
        _curPageSpells = Array<SpellComponent>()
        if spells.count > 0 {
            
            let end = getPageEnd()
            
            for i in (_curPage - 1) * _pageSize...end - 1 {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 10
                let x = base % 10
                let sc = SpellComponent()
                sc.setSpell(s: spells[i])
                sc.position.y = startY - cellSize * 1.5 * y.toFloat()
                sc.position.x = startX + cellSize * 1.25 * x.toFloat()
                sc.zPosition = self.zPosition + 3
                _spellsBox.addChild(sc)
                _curPageSpells.append(sc)
            }
            
        }
    }
    private func getPageEnd() -> Int {
        let pages = Data.instance._char._spells.count / _pageSize
        if pages >= _curPage {
            return _curPage * _pageSize
        }
        return Data.instance._char._spells.count
    }
    private func createPageButton() {
        _nextButton = Button()
        _nextButton.text = "下一页"
        _nextButton.position.y = -_closeButton.position.y
        _nextButton.position.x = _closeButton.position.x
        _nextButton.zPosition = self.zPosition + 2
        addChild(_nextButton)
        
        _prevButton = Button()
        _prevButton.text = "上一页"
        _prevButton.position.y = -_closeButton.position.y
        _prevButton.position.x = _nextButton.position.x - cellSize * 2.25
        _prevButton.zPosition = self.zPosition + 2
        addChild(_prevButton)
    }
    private func pageReload() {
        _spellsBox.removeAllChildren()
        _lastSelectedRoleSC = SpellComponent()
        _lastSelectedSC = SpellComponent()
        showSelectableSpells()
        _roleSpells.removeAllChildren()
        showRoleSpells()
    }
    private func close() {
        Data.instance.stage.closeSpellPanel(panel: self)
    }
    private func showInfo(sc:SpellComponent) {
        let si = SpellInfo()
        si.create(spell: sc._spell)
        si.position.x = sc.position.x + cellSize * 0.5 + 5
        if sc.position.y < 0 {
            si.position.y = sc.position.y + si._bgHeight - cellSize * 0.5
        } else {
            si.position.y = sc.position.y + cellSize * 0.5
        }
        if sc.position.x > cellSize * 4 {
            si.position.x = sc.position.x - si._width
        }
        addChild(si)
        _curInfoPanel = si
    }
    private var _curInfoPanel = SpellInfo()
    private var _pageSize = 20
    private var _curPage = 1
}

class SpellComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = UIStage.PANEL_LAYER
        self.size = CGSize(width: cellSize, height: cellSize)
        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: -cellSize * 0.5, y: -cellSize * 0.5), size: self.size), cornerRadius: 2 )
        bg.fillColor = UIColor.black
        bg.lineWidth = 1
        _bg = bg
        addChild(bg)
    }
    private var _bg:SKShapeNode!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var _spell = Spell()
    func setSpell(s:Spell) {
        _spell = s
        _bg.strokeColor = QualityColor.getColor(s._quality)
    }
    private var _select = false
    var selected:Bool {
        set {
            if newValue {
//                _bg.strokeColor = Data.SELECTED_HIGHLIGH_COLOR
                _bg.lineWidth = 2
            } else {
//                _bg.strokeColor = QualityColor.getColor(_spell._quality)
                _bg.lineWidth = 1
            }
            _select = newValue
        }
        get {
            return _select
        }
    }
}


class SpellInfo:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = UIStage.PANEL_LAYER + 4
        //        self.size = CGSize(width: cellSize, height: cellSize)
        
    }
    
    private var _spell = Spell()
    func create(spell:Spell) {
        _spell = spell
        let startX = cellSize * 0.26
        let startY = -cellSize
        
        let i = SKSpriteNode(texture: Data.instance.inside_c.getCell(10, 0))
        i.position.x = startX
        i.position.y = startY - 12
        i.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(i)
        
        let name = Label()
        name.text = "[\(_spell._name)]"
        name.fontSize = 20
        name.fontName = ""
        name.fontColor = QualityColor.getColor(_spell._quality)
        //        name.zPosition = zPosition + 1
        name.position.x = startX
        name.position.y = startY - cellSize + 12
        name.align = "left"
        addChild(name)
        _bgHeight = cellSize * 1.5
        let des = MultipleLabel()
        var text = _spell._description
        if _spell._cooldown > 0 {
            var cd = _spell._cooldown
            if wandFireMaster() {
                cd -= 1
            }
            text += "，冷却\(cd)回合"
        }
        if _spell._tear > 0 {
            text += "，消耗\(TheWitchsTear.NAME)x\(_spell._tear)"
        }
        des._lineCharNumber = 8
        des.text = text
        des.position.x = startX
        des.position.y = name.position.y - cellSize * 0.5
        addChild(des)
        
        _bgHeight += des._height + 50
        
        _width = cellSize * 3
        
        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: -_bgHeight), size: CGSize(width: cellSize * 3, height: _bgHeight)), cornerRadius: 4 )
        bg.fillColor = UIColor.black
        bg.lineWidth = 2
        //        bg.glowWidth = 3
        bg.strokeColor = UIColor.lightGray
        _bg = bg
        addChild(bg)
        
        let img = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize, height: cellSize), cornerRadius: 2)
        img.position.x = startX
        img.position.y = startY - 12
        img.strokeColor = QualityColor.getColor(_spell._quality)
        //        img.lineWidth = 2
        addChild(img)
        
        
        //        let gap:CGFloat = cellSize * 0.5
        //        for i in 0...armor._attrs.count - 1 {
        //            let label = Label()
        //            label.align = "left"
        //            label.fontSize = 16
        //            label.fontName = ""
        //            label.text = armor._attrs[i].getText()
        //            label.position.x = startX
        //            label.position.y = pptStartY - gap * i.toFloat()
        //            label.fontColor = UIColor.white
        //            addChild(label)
        //        }
    }
    
    func wandFireMaster() -> Bool {
        if _spell.isMagical && _spell.isFire {
            let char = Data.instance._char!
            if char._spells.index(of: _spell) != nil || char._spellsInuse.index(of: _spell) != nil {
                return true
            }
        }
        
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _bg = SKShapeNode()
    var _bgHeight:CGFloat = 0
    var _width:CGFloat = 0
}

