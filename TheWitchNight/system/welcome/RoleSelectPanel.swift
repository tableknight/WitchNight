//
//  RoleSelectPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/5.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class RoleSelectPanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
//        if !_lastSelectedComponent.contains(touchPoint!) {
//            _lastSelectedComponent.selected = false
//        }
        
        for u in _listBox.children {
            if u .contains(touchPoint!) {
                let rc = u as! RoleComponent
                
                if _lastSelectedComponent == rc {
                    removeFromParent()
                    loadStage(char: rc.unit as! Character)
                    return
                }
                _lastSelectedComponent.selected = false
                _lastSelectedComponent = rc
                _lastSelectedComponent.selected = true
            }
        }
        
        if _prevButton.contains(touchPoint!) {
            
        }
        if _nextButton.contains(touchPoint!) {
            
        }
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        _label.text = "选择角色：再次点击已选中的角色"
        _closeButton.text = "返回"
        _prevButton.text = "创建角色"
        _nextButton.text = "删除角色"
        
        addChild(_listBox)
        
        createCharList()
    }
    
    private func createCharList() {
        let startX = -cellSize * 5
        let startY = cellSize * 2.25
        let width = cellSize * 5.5
        let height = cellSize * 1.75
        if _chars.count > 0 {
            for i in 0..._chars.count - 1 {
                let y = i % 3
                let x = i / 3
                
                let cc = RoleComponent()
                cc.unit = _chars[i]
                cc.position.x = startX + width * x.toFloat()
                cc.position.y = startY - height * y.toFloat()
                cc.zPosition = self.zPosition + 2
                _listBox.addChild(cc)
            }
        }
    }
    private func loadStage(char:Character) {
        Data.instance._char = char
        let bUnit = BUnit()
        bUnit.setUnit(unit: char)
        bUnit.createForStage()
        let stage = UIStage()
        stage.setChar(bUnit)
        Data.instance.scene.addChild(stage)
        stage.showSceneMask()
        stage.maskFadeOut {
            
        }
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
class RoleComponent:MinionsHouseComponent {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
