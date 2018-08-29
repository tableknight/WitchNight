//
//  GroundSets.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class GroundSets: Core {
    var _ground:SKTexture = SKTexture()
    var _wall:SKTexture = SKTexture()
    private var _gs = SKTexture()
    private var _gc = SKTexture()
    private var _ge = SKTexture()
    var __gs = SKTexture()
    var __gc = SKTexture()
    var __ge = SKTexture()
    init(ground:SKTexture, wall:SKTexture) {
        super.init()
        _ground = ground
        _wall = wall
        let cs = Data.instance.cellSize
        var top = SKSpriteNode(texture: ground.getCell(0, 0))
        var middle = SKSpriteNode(texture: ground.getCell(0, 0.5))
        var bottom = SKSpriteNode(texture: ground.getCell(0, 1))
        let gs = SKSpriteNode()
        top.position.y = cs
        bottom.position.y = -cs
        gs.addChild(top)
        gs.addChild(middle)
        gs.addChild(bottom)
        _gs = gs.toTexture()
        
        top = SKSpriteNode(texture: ground.getCell(0.5, 0))
        middle = SKSpriteNode(texture: ground.getCell(0.5, 0.5))
        bottom = SKSpriteNode(texture: ground.getCell(0.5, 1))
        let gc = SKSpriteNode()
        top.position.y = cs
        bottom.position.y = -cs
        gc.addChild(top)
        gc.addChild(middle)
        gc.addChild(bottom)
        _gc = gc.toTexture()
        
        top = SKSpriteNode(texture: ground.getCell(1, 0))
        middle = SKSpriteNode(texture: ground.getCell(1, 0.5))
        bottom = SKSpriteNode(texture: ground.getCell(1, 1))
        let ge = SKSpriteNode()
        top.position.y = cs
        bottom.position.y = -cs
        ge.addChild(top)
        ge.addChild(middle)
        ge.addChild(bottom)
        _ge = ge.toTexture()
        
        __gs = gStart()
        __gc = gConnect()
        __ge = gEnd()
        
    }
    
    func groundStart(_ size:Int = 3) -> SKTexture {
        if size == 2 {
            return _ground.getCell(0, 1, 1, 2)
        }
        return _gs
    }
    
    func groundConnect(_ size:Int = 3) -> SKTexture {
        if size == 2 {
            return _ground.getCell(0.5, 1, 1, 2)
        }
        return _gc
    }
    
    func groundEnd(_ size:Int = 3) -> SKTexture {
        if size == 2 {
            return _ground.getCell(1, 1, 1, 2)
        }
        return _ge
    }
    
    func wallStart() -> SKTexture {
        return _wall.getCell(0, 1, 1, 2)
    }
    
    func wallConnect() -> SKTexture {
        return _wall.getCell(0.5, 1, 1, 2)
    }
    
    func wallEnd() -> SKTexture {
        return _wall.getCell(1, 1, 1, 2)
    }
    
    func gStart() -> SKTexture {
        let cs = Data.instance.cellSize
        let top = SKSpriteNode(texture: _ground.getCell(0, 0))
        let bottom = SKSpriteNode(texture: _ground.getCell(0, 1))
        let gs = SKSpriteNode()
        top.position.y = cs * 4
        bottom.position.y = -cs * 3
        gs.addChild(top)
        for i in 0...5 {
            let middle = SKSpriteNode(texture: _ground.getCell(0, 0.5))
            middle.position.y = (3 - i).toFloat() * cs
            gs.addChild(middle)
            
        }
        gs.addChild(bottom)
        
        return gs.toTexture()
    }
    
    func gConnect() -> SKTexture {
        let cs = Data.instance.cellSize
        let top = SKSpriteNode(texture: _ground.getCell(0.5, 0))
        let bottom = SKSpriteNode(texture: _ground.getCell(0.5, 1))
        let gs = SKSpriteNode()
        top.position.y = cs * 4
        bottom.position.y = -cs * 3
        gs.addChild(top)
        for i in 0...5 {
            let middle = SKSpriteNode(texture: _ground.getCell(0.5, 0.5))
            middle.position.y = (3 - i).toFloat() * cs
            gs.addChild(middle)
            
        }
        gs.addChild(bottom)
        
        return gs.toTexture()
    }
    
    func gEnd() -> SKTexture {
        let cs = Data.instance.cellSize
        let top = SKSpriteNode(texture: _ground.getCell(1, 0))
        let bottom = SKSpriteNode(texture: _ground.getCell(1, 1))
        let gs = SKSpriteNode()
        top.position.y = cs * 4
        bottom.position.y = -cs * 3
        gs.addChild(top)
        for i in 0...5 {
            let middle = SKSpriteNode(texture: _ground.getCell(1, 0.5))
            middle.position.y = (3 - i).toFloat() * cs
            gs.addChild(middle)
            
        }
        gs.addChild(bottom)
        
        return gs.toTexture()
    }
}
