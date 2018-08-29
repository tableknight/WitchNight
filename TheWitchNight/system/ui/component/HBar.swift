//
//  hbar.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class HBar:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        let rect = SKShapeNode(
//        zPosition = UIStage.UILAYER
        self.size = CGSize(width: cellSize * 2, height: 6)
        //        let bg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize * 2, height: cellSize * 2))
        ////        bg.fillColor = UIColor.
        ////        bg.
        //        addChild(bg)
//        self.anchorPoint = CGPoint(x: 0, y: 1)
        let bg = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize * 2, height: 6))
        bg.fillColor = UIColor.black
        
        addChild(bg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _bar:SKShapeNode!
    var _color:UIColor!
    func setBar(value:CGFloat = 1) {
        _bar?.removeFromParent()
        let width = cellSize * 2 * value
        _bar = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: 6))
        _bar.fillColor = _color
        addChild(_bar)
    }
}
