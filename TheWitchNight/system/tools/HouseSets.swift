//
//  HouseSets.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/31.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class HouseSets: Core {
    private var _roofs = SKTexture()
    private var _wall = SKTexture()
    init(roofs:SKTexture, wall:SKTexture) {
        _roofs = roofs
        _wall = wall
    }
    func roofStart() -> SKSpriteNode {
        return SKSpriteNode(texture: _roofs.getCell(0, 1, 1, 2))
    }
    
    func roofConnect() -> SKSpriteNode {
        return SKSpriteNode(texture: _roofs.getCell(0.5, 1, 1, 2))
    }
    
    func roofEnd() -> SKSpriteNode {
        return SKSpriteNode(texture: _roofs.getCell(1, 1, 1, 2))
    }
    
    func wallStart() -> SKSpriteNode {
        return SKSpriteNode(texture: _wall.getCell(0, 1, 1, 2))
    }
    
    func wallConnect() -> SKSpriteNode {
        return SKSpriteNode(texture: _wall.getCell(0.5, 1, 1, 2))
    }
    
    func wallEnd() -> SKSpriteNode {
        return SKSpriteNode(texture: _wall.getCell(1, 1, 1, 2))
    }
}
