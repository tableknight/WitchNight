//
//  UIScene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BaseScene: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.outside_a4
        _groundSets = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
        _name = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createGround(start:Int, end:Int) {
        let node = SKSpriteNode()
//        var _end = 15
        for i in start...14 {
            var groundTexture = _groundSets.__gc
            var wallTexture = _groundSets.wallConnect()
            if 0 == i {
                groundTexture = _groundSets.__gs
                wallTexture = _groundSets.wallStart()
            }
            if 14 == i {
                groundTexture = _groundSets.__ge
                wallTexture = _groundSets.wallEnd()
            }
            let ground = SKSpriteNode(texture: groundTexture)
            let wall = SKSpriteNode(texture: wallTexture)
            let sha = SKSpriteNode(texture: _sha)
            ground.position.x = cellSize * (i - start).toFloat()
            wall.position.x = cellSize * (i - start).toFloat()
            sha.position.x = cellSize * (i - start).toFloat()
            
            ground.position.y = cellSize * 3
            wall.position.y = -cellSize * 4
            sha.position.y = -cellSize * 4
            
            ground.anchorPoint = CGPoint(x: 0.5, y: 1)
            wall.anchorPoint = CGPoint(x: 0.5, y: 1)
            sha.anchorPoint = CGPoint(x: 0.5, y: 1)
            
            sha.alpha = 0.85
            
            ground.zPosition = UIStage.LAYER1
            wall.zPosition = UIStage.LAYER1
            sha.zPosition = UIStage.LAYER4
            
            node.addChild(ground)
            node.addChild(wall)
            node.addChild(sha)
            
            
        }
        //        addChild(node)
        let t = node.toTexture()
        //        node.removeFromParent()
//        _ground.position.x = -cellSize * 8
        
        
        _ground.texture = t
        _ground.anchorPoint = CGPoint(x: 0.5, y: 1)
        _ground.position.y = cellSize * 4
        _ground.size = t.size()
        _ground.zPosition = UIStage.LAYER1
        addChild(_ground)
        
        
        //        let gate = Gate()
        //        gate.position.x = cellSize * 2
        //        gate.position.y = cellSize * 2
        //        addItem(x: 4, item: gate)
        
//        createItems(start: start, end: _end)
        //        let tt = SmallHouse()
        //        tt.position.x = -cellSize * 0.5 + cellSize * 2
        //        tt.position.y = cellSize * 2
        //        tt.zPosition = UIStage.LAYER2
        //        _ground.addChild(tt)
    }
    override func create() {
        createGround(start: 0, end: 0)
        let ob = Data.instance.outside_b
        addStuff(x: 0, y: 0, texture: ob.getCell(6, 12))

    }
    
    func addStuff(x:CGFloat, y:CGFloat, texture:SKTexture) {
        let node = SKSpriteNode(texture: texture)
        node.position.x = cellSize * x - cellSize * 7
        node.position.y = cellSize * y
        node.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.zPosition = UIStage.LAYER2
        _ground.addChild(node)
    }
}

