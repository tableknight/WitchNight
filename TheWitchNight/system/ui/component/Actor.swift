//
//  Actor.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Actor:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        let rect = SKShapeNode(
        zPosition = UIStage.UILAYER
        self.size = CGSize(width: cellSize, height: cellSize)
//        let bg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize * 2, height: cellSize * 2))
////        bg.fillColor = UIColor.
////        bg.
//        addChild(bg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setActor() {
        let face = Data.instance._char._img.getCell(1, 0)
//        let node = SKSpriteNode(texture: face)
////        node.anchorPoint = CGPoint(x: 0, y: 1)
//        node.size = CGSize(width: cellSize, height: cellSize)
//        node.position.y = cellSize * 0.5
//        addChild(node)
        self.texture = face
    }
}
