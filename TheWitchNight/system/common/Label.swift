//
//  Label.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Label: SKLabelNode {
    override init() {
        super.init()
        setCommon()
    }
    
    private func setCommon() {
        fontName = UIFont.familyNames[37]
        
//        print(UIFont.familyNames)
//        fontName = "Microsoft Yahei"
        fontSize = Data.instance._fontSize
        fontColor = UIColor.white
//        horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
    }
    func align(align:String = "left") {
        horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
    }
    
    var align:String {
        set {
            if newValue == "left" {
                horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            } else if newValue == "right" {
                horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
            } else {
                horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            }
        }
        get {
            return ""
        }
    }
    
    init(_ text:String, _ x:CGFloat, _ y:CGFloat, _ color:UIColor = UIColor.black) {
        super.init()
        setCommon()
        fontColor = color
        self.text = text
        setPos(x, y)
    }
    
    func setPos(_ x:CGFloat, _ y:CGFloat) {
        position = CGPoint(x: x, y: y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MultipleLabel:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var _lineCharNumber = 0
    var _fontSize:CGFloat = 14
    var _lineHeight:CGFloat = 0
    var _height:CGFloat = 0
    private var _text:String = ""
    var text:String {
        set {
            if newValue == "" {
                return
            }
            _text = newValue
            var lines = newValue.count / _lineCharNumber
            if newValue.count % _lineCharNumber == 0 {
                lines -= 1
            }
            if _lineHeight == 0 {
                _lineHeight = _fontSize + 8
            }
            for i in 0...lines {
//                let y = i / _lineCharNumber
                let label = Label()
                var str = ""
                var x = 0
                for c in newValue {
                    if x >= i * _lineCharNumber && x < (i + 1) * _lineCharNumber {
                        str.append(c)
                    }
                    x += 1
                }
                label.align = "left"
                label.text = str
                label.position.y -= i.toFloat() * _lineHeight
                label.fontSize = _fontSize
                addChild(label)
            }
            
            _height = lines.toFloat() * _lineHeight
        }
        get {
            return _text
        }
    }
}
