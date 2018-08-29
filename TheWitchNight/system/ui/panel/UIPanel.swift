//
//  Panel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIPanel:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        _char = Data.instance._char!
        zPosition = UIStage.PANEL_LAYER
        //
        //        let s = Data.instance.stage
        createPanelbackground()
        
        createMask()
        
        createLabel()
    }
    internal func createLabel() {
        let t = Label()
        t.align = "left"
        t.fontSize = 16
        //        t.text = "传送：再次点击已选择的层数。"
        t.position.x = -cellSize * 6
        t.position.y = cellSize * 3 + 8
        t.zPosition = self.zPosition + 2
        addChild(t)
        _label = t
    }
    internal func createMask() {
        let _mask = Data.createMask()
        _mask.zPosition = self.zPosition + 1
        addChild(_mask)
    }
    
    internal func createPanelbackground() {
        let b = CGRect(x: -cellSize * 6, y: -cellSize * 3, width: cellSize * 12, height: cellSize * 6)
        let bg = SKShapeNode(rect: b, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.zPosition = self.zPosition + 2
        addChild(bg)
        _bg = bg
    }
    
    func create() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createCloseButton() {
        _closeButton.text = "关闭"
        _closeButton.position.y = cellSize * 3.5
        _closeButton.position.x = cellSize * 5
        _closeButton.zPosition = self.zPosition + 2
        addChild(_closeButton)
    }
    
    func createPageButtons() {
        _nextButton.text = "下一页"
        _nextButton.position.x = _closeButton.position.x
        _nextButton.position.y = -_closeButton.position.y
        _nextButton.zPosition = self.zPosition + 2
        addChild(_nextButton)
        
        _prevButton.text = "上一页"
        _prevButton.position.x = _nextButton.position.x - cellSize * 2.25
        _prevButton.position.y = _nextButton.position.y
        _prevButton.zPosition = self.zPosition + 2
        addChild(_prevButton)
    }
    
    
    
    internal var _bg:SKShapeNode!
    internal var _label:Label!
    internal var _closeButton = Button()
    internal var _prevButton = Button()
    internal var _nextButton = Button()
    internal var _char:Character!
}
