//
//  UIOrder.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIOrder:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func create(label:String) {
        let l = Label(label, 0, 0)
        addChild(l)
        let bg = SKShapeNode(rect: CGRect(x: -cellSize * 0.5, y: -cellSize * 0.5, width: cellSize, height: cellSize))
        bg.fillColor = UIColor.white
        addChild(bg)
        l.zPosition = 41
        bg.zPosition = 40
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let view = touches.first?.view
//        print(view)
    }
}
