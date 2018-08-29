//
//  Button.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/12.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Button:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        let rect = SKShapeNode(
        zPosition = UIStage.UILAYER
        let bg = SKShapeNode(rect: CGRect(x: -cellSize, y: -cellSize * 0.375, width: cellSize * 2, height: cellSize * 0.75), cornerRadius: 2)
        bg.fillColor = UIColor.black
        //        addChild(bg)
        
        _bg = bg
//        _node.addChild(bg)
        addChild(_bg)
        _label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        _label.fontColor = UIColor.white
        _label.position.y = -cellSize * 0.1
        _label.fontSize = 14
        addChild(_label)
    }
    private var _node = SKSpriteNode()
    var _bg:SKShapeNode!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _label = Label()
    var text:String {
        set {
//            _node.removeFromParent()
//            let label = Label()
//            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
//            label.text = newValue
//            label.fontColor = UIColor.white
//            label.position.y = -cellSize * 0.1
//            label.fontSize = 14
//            _node.addChild(label)
//
//            self.texture = _node.toTexture()
//            self.size = _node.size
//            addChild(_node)
//            _label = label
            _label.text = newValue
        }
        get {
            return ""
        }
    }
    private var _selected = false
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _bg.strokeColor = Data.SELECTED_HIGHLIGH_COLOR
                _bg.lineWidth = 4
            } else {
                _bg.strokeColor = UIColor.white
                _bg.lineWidth = 1
            }
        }
        get {
            return _selected
        }
    }
    
    var width:CGFloat {
        set {
            _bg.removeFromParent()
            _bg = SKShapeNode(rect: CGRect(x: -newValue * 0.5, y: -cellSize * 0.375, width: newValue, height: cellSize * 0.75), cornerRadius: 2)
            addChild(_bg)
        }
        get {
            return 0
        }
    }

}

class RectButton:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        let rect = SKShapeNode(
        zPosition = UIStage.UILAYER
        let bg = SKShapeNode(rect: CGRect(x: -cellSize * 0.5, y: -cellSize * 0.5, width: cellSize, height: cellSize), cornerRadius: 2)
        bg.fillColor = QualityColor.RARE
        //        addChild(bg)
        _node.addChild(bg)
    }
    private var _node = SKSpriteNode()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _label:Label!
    var text:String {
        set {
            let label = Label()
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            label.text = newValue
            label.fontColor = UIColor.white
            label.position.y = -cellSize * 0.1
            label.fontSize = 14
            _node.addChild(label)
            
            self.texture = _node.toTexture()
            self.size = _node.size
            addChild(_node)
            _label = label
        }
        get {
            return ""
        }
    }
    
}
