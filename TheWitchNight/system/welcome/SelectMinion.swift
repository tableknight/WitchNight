//
//  RoleSelectPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/5.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelectMinion:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        //        if !_lastSelectedComponent.contains(touchPoint!) {
        //            _lastSelectedComponent.selected = false
        //        }
        
        for u in _listBox.children {
            if u .contains(touchPoint!) {
                let rc = u as! RoleComponent
                _lastSelectedComponent.selected = false
                _lastSelectedComponent = rc
                _lastSelectedComponent.selected = true
                return
            }
        }
        
        if _prevButton.contains(touchPoint!) {
            (parent as! CreationFlow).showImages()
        }
        if _nextButton.contains(touchPoint!) {
            if !hasSelected() {
                return
            }
            (parent as! CreationFlow).showItems()
        }
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        _label.text = "选择随从"
        _closeButton.text = "返回"
        _prevButton.text = "上一步"
        _nextButton.text = "下一步"
        
        addChild(_listBox)
        let cat = BlackCat()
        cat.create(level: 1)
        let dog = DarkCrow()
        dog.create(level: 1)
        _chars = [cat, dog]
        createCharList()
    }
    
    private func createCharList() {
        let startX = -cellSize * 5
        let startY = cellSize * 2.25
        let width = cellSize * 5.5
        let height = cellSize * 1.75
        if _chars.count > 0 {
            for i in 0..._chars.count - 1 {
                let y = i % 1
                let x = i / 1
                
                let cc = RoleComponent()
                cc.unit = _chars[i]
                cc.position.x = startX + width * x.toFloat()
                cc.position.y = startY - height * y.toFloat()
                cc.zPosition = self.zPosition + 2
                _listBox.addChild(cc)
            }
        }
    }
    
    private func hasSelected() -> Bool {
        for n in _listBox.children {
            let c = n as! RoleComponent
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
    var _chars = Array<Creature>()
    var _lastSelectedComponent = RoleComponent()
}

