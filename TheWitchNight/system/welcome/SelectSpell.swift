//
//  SelectSpell.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

//
//  SelectItems.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelectSpell:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        
        for u in _listBox.children {
            if u.contains(touchPoint!) {
                let c = u as! SelectableSpellComponent
                
                _lastSelectedComponent.selected = false
                _lastSelectedComponent = c
                _lastSelectedComponent.selected = true
                return
            }
        }
        
        if _prevButton.contains(touchPoint!) {
            (parent as! CreationFlow).showItems()
        }
        if _nextButton.contains(touchPoint!) {
            if !hasSelected() {
                return
            }
            (parent as! CreationFlow).createChar()
        }
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        _label.text = "选择技能"
        _closeButton.text = "返回"
        //        _closeButton.isHidden = true
        _prevButton.text = "上一步"
        //        _prevButton.isHidden = true
        _nextButton.text = "创建"
        
        addChild(_listBox)
        
        _spells = [Heal(), FireBreath(), FeignAttack(), Strong()]
        
        
        createCharList()
    }
    
    private func createCharList() {
        let startX = -cellSize * 5
        let startY = cellSize * 2.75
        let width = cellSize * 5.5
        let height = cellSize * 1.4
        if _spells.count > 0 {
            for i in 0..._spells.count - 1 {
                let y = i % 4
                let x = i / 4
                
                let cc = SelectableSpellComponent()
                cc.spell = _spells[i]
                cc.position.x = startX + width * x.toFloat()
                cc.position.y = startY - height * y.toFloat()
                cc.zPosition = self.zPosition + 2
                _listBox.addChild(cc)
            }
        }
    }
    
    private func hasSelected() -> Bool {
        for n in _listBox.children {
            let c = n as! SelectableSpellComponent
            if c.selected {
                return true
            }
        }
        return false
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _listBox = SKSpriteNode()
    var _spells = Array<Spell>()
    var _lastSelectedComponent = SelectableSpellComponent()
}

class SelectableSpellComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        _char = Data.instance._char!
        //        _bg.removeFromParent()
        let rect = CGRect(x: 0, y: -cellSize * 1.125, width: cellSize * 10, height: cellSize)
        _bg = SKShapeNode(rect: rect, cornerRadius: 2)
        addChild(_bg)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var spell: Spell {
        set {
            let name = Label()
            name.position.x = cellSize * 0.25
            name.position.y = -26
            var type = "主动"
            if newValue is Passive {
                type = "被动"
            }
            name.text = "\(type) [\(newValue._name)]"
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
            _spell = newValue
        }
        get {
            return _spell
        }
    }

    
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
    
    private var _spell = Spell()
    private var _bg = SKShapeNode()
}

