//
//  Dialog.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Dialog: SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Data.instance.stage.removeDialog(dlg: self)
        } else if _nextButton.contains(touchPoint!) {
            _nextAction()
        } else if _confirmButton.contains(touchPoint!) {
            _confirmAction()
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let rect = CGRect(x: -cellSize * 7, y: -cellSize * 3, width: cellSize * 14, height: cellSize * 3)
        _dialog = SKShapeNode(rect: rect, cornerRadius: 4)
        _dialog.fillColor = UIColor.black
        _dialog.alpha = 0.65
        _dialog.zPosition = UIStage.UILAYER
        addChild(_dialog)
        isUserInteractionEnabled = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func create(img:SKTexture) {
        let actor = SKSpriteNode(texture: img)
        actor.size = CGSize(width: -cellSize * 1, height: cellSize * 1)
        actor.position.x = -cellSize * 6.5
        actor.position.y = cellSize * 0.5
        actor.zPosition = _dialog.zPosition + 1
        addChild(actor)
        
        let name = Label()
        name.position.x = actor.position.x + cellSize * 0.5
        name.position.y = 5
        name.zPosition = _dialog.zPosition + 1
        name.align = "left"
        name.text = _name
        name.fontSize = 16
        addChild(name)
        
        _closeButton.position.x = cellSize * 6
        _closeButton.position.y = cellSize * 0.5 - 3
        _closeButton.text = "关闭"
        addChild(_closeButton)
    }
    
    func addConfirmButton() {
        _confirmButton.position.x = cellSize * 6
        _confirmButton.position.y = -cellSize * 2.5
        _confirmButton.text = "确定"
        _confirmButton._bg.removeFromParent()
        addChild(_confirmButton)
    }
    
    func addNextButton() {
        _nextButton.position.x = cellSize * 6
        _nextButton.position.y = -cellSize * 2.5
        _nextButton._bg.removeFromParent()
        _nextButton.text = "继续"
        addChild(_nextButton)
    }
    
    var text:String {
        set {
            _textlabel.removeFromParent()
            
            _textlabel = MultipleLabel()
            _textlabel._fontSize = 20
            _textlabel._lineCharNumber = 30
            _textlabel._lineHeight = 30
            _textlabel.position.x = -cellSize * 6
            _textlabel.position.y = -cellSize
            _textlabel.zPosition = _dialog.zPosition + 1
            _textlabel.text = newValue
            addChild(_textlabel)
            
        }
        get {
            return ""
        }
    }
    
    func remove() {
        Data.instance.stage.removeDialog(dlg: self)
    }
    
    private var _dialog = SKShapeNode()
    var _closeButton = Button()
    var _confirmButton = Button()
    var _nextButton = Button()
    var _textlabel = MultipleLabel()
    var _nextAction = {}
    var _confirmAction = {}
    var _name = ""
}
