//
//  CardSlot.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class CardSlot {
    let node:SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "card.png"))
    init() {
        node.scale(to: CGSize(width: 50, height: 72))
    }
    func setPos(_ x:CGFloat, _ y:CGFloat) {
        node.position.x = x;
        node.position.y = y;
    }
    func getNode() -> SKSpriteNode {
        return node
    }
}
