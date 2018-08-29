//
//  MenuButton.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MenuButton:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let rect = SKShapeNode(
        zPosition = UIStage.UILAYER
        let bg = SKShapeNode(rect: CGRect(x: -cellSize * 0.5, y: -cellSize * 0.375, width: cellSize, height: cellSize * 0.75), cornerRadius:2)
        bg.fillColor = UIColor.black
//        addChild(bg)
        _node.addChild(bg)
    }
    private var _node = SKSpriteNode()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setText(text:String) {
        let label = Label()
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        label.text = text
        label.fontColor = UIColor.white
//        label.position.x = cellSize * 0.5
        label.position.y = -cellSize * 0.1
        _node.addChild(label)
        
        self.texture = _node.toTexture()
        self.size = _node.size
        addChild(_node)
    }
}
