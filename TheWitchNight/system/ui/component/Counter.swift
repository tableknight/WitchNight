//
//  Counter.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Counter: SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tp = touches.first?.location(in: self)
        if _reduceButton.contains(tp!) {
            if _count < 2 {
                return
            }
            count = _count - 1
            return
        }
        
        if _increaseButton.contains(tp!) {
            if _count >= _max || _count > 99 {
                return
            }
            count = _count + 1
            return
        }
        
        if _confirmButton.contains(tp!) {
            confirmAction()
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func create(max:Int) {
        _max = max
        let rect = CGRect(x: 0, y: 0, width: cellSize * 4, height: cellSize * 0.75)
        _bg = SKShapeNode(rect: rect)
        _bg.fillColor = UIColor.black
        _bg.lineWidth = 0
        addChild(_bg)
        
        _reduceButton.width = cellSize * 0.75
        _reduceButton.position.x = cellSize * 0.375
        _reduceButton.position.y = cellSize * 0.375
        _reduceButton.text = "-"
        _reduceButton._label.fontSize = 24
        addChild(_reduceButton)
        
        _increaseButton.width = cellSize * 0.75
        _increaseButton.position.x = cellSize * 2.375
        _increaseButton.position.y = cellSize * 0.375
        _increaseButton.text = "+"
        _increaseButton._label.fontSize = 24
        _increaseButton._label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.bottom
        addChild(_increaseButton)
        
        let _clbg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize * 0.75, height: cellSize * 0.75), cornerRadius: 2)
        _clbg.position.x = cellSize
        addChild(_clbg)
        _countLabel.text = "1"
        _countLabel.position.x = cellSize * 1.35
        _countLabel.position.y = cellSize * 0.25
        _countLabel.fontSize = 20
//        _countLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        addChild(_countLabel)
        
        
        _confirmButton.position.x = cellSize * 4
        _confirmButton.position.y = cellSize * 0.375
        _confirmButton.text = "确定"
        addChild(_confirmButton)
        
    }
    
    private var _count:Int = 1
    private var _max:Int = 0
    private var _reduceButton = Button()
    private var _increaseButton = Button()
    private var _confirmButton = Button()
    private var _countLabel = Label()
    private var _bg = SKShapeNode()
    var confirmAction = {}
    var confirmText:String {
        set {
            _confirmButton.text = newValue
        }
        get {
            return ""
        }
    }
    var count:Int {
        set {
            _count = newValue
            _countLabel.text = "\(newValue)"
        }
        get {
            return _count
        }
    }
}
