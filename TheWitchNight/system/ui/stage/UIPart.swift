//
//  UIPart.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIPart: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func addPart(item:SKSpriteNode, x:CGFloat, y:CGFloat) {
        let xSize = round(item.size.width / cellSize)
        let ySize = round(item.size.height / cellSize)
        let xHalf = (x + xSize / 2) * cellSize
        let yHalf = (y + ySize / 2) * cellSize
 
        item.position.x = -size.width / 2 + xHalf
        item.position.y = size.height / 2 - yHalf
        addChild(item)
    }
//    func toTexture() ->SKTexture {
//        return node2texture(self)
//    }
}
