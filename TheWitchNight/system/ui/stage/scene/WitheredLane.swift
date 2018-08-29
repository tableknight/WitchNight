//
//  WitheredLane.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/6/11.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class WitheredLane: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.dungeon_a4
        _groundSets = GroundSets(ground: oa4.getCell(8, 2, 2, 2), wall: oa4.getCell(8, 4, 2, 2))
        _name = "枯萎小径"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createGround(start:Int, end:Int) {
        let node = SKSpriteNode()
        var _end = end
        if end > xSize.toInt() {
            _end = xSize.toInt()
        }
        var size = 3
        if isRandomScene {
            size = 2
        }
        for i in start..._end - 1 {
            if i == 10 {
                let oa4 = Data.instance.dungeon_a4
                _groundSets = GroundSets(ground: oa4.getCell(4, 2, 2, 2), wall: oa4.getCell(4, 4, 2, 2))
            }
            var groundTexture = _groundSets.groundConnect(size)
            var wallTexture = _groundSets.wallConnect()
            if 0 == i {
                groundTexture = _groundSets.groundStart(size)
                wallTexture = _groundSets.wallStart()
            }
            if (xSize - 1).toInt() == i {
                groundTexture = _groundSets.groundEnd(size)
                wallTexture = _groundSets.wallEnd()
            }
            let ground = SKSpriteNode(texture: groundTexture)
            let wall = SKSpriteNode(texture: wallTexture)
            let sha = SKSpriteNode(texture: _sha)
            ground.position.x = cellSize * (i - start).toFloat()
            wall.position.x = cellSize * (i - start).toFloat()
            sha.position.x = cellSize * (i - start).toFloat()
            
            //            ground.position.y = cellSize * 0.5
            //            wall.position.y = cellSize * 0.5
            //            sha.position.y = cellSize * 0.5
            
            ground.anchorPoint = CGPoint(x: 0.5, y: 0)
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
        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
        _ground.position.x = -cellSize * 0.5
        _ground.texture = t
        if 3 == size {
            _ground.position.y = cellSize * 0.5
        }
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
        hasInitialized = true
        xSize = 23
        createGround(start: 0, end: xSize.toInt())
        let td = Data.instance.tiled_dungeons
        addSingleCellItem(x: 3, line: 4.25, texture: td.getCell(3, 3, 3, 4))
        addSingleCellItem(x: 0, line: 4, texture: td.getCell(1, 5, 1, 2))
        addSingleCellItem(x: 1, line: 3, texture: td.getCell(2, 5, 1, 2))
        addSingleCellItem(x: 2, line: 3, texture: td.getCell(2, 5, 1, 2))
        addSingleCellItem(x: 6, line: 3, texture: td.getCell(2, 5, 1, 2))
        addSingleCellItem(x: 7, line: 3, texture: td.getCell(2, 5, 1, 2))
        addSingleCellItem(x: 8, line: 4, texture: td.getCell(1, 5, 1, 2))
        
        let ob = Data.instance.outside_b
        let db = Data.instance.dungeon_b
        addSingleCellItem(x: 11, line: 1, texture: ob.getCell(4, 9, 1, 1))
        addSingleCellItem(x: 12, line: 4, texture: ob.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 13, line: 4, texture: ob.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 14, line: 4, texture: ob.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 13, line: 3, texture: ob.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 15, line: 3, texture: ob.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 16, line: 4, texture: ob.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 17, line: 4, texture: ob.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 18, line: 4, texture: ob.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 19, line: 4, texture: ob.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 17, line: 3, texture: ob.getCell(8, 6, 1, 2))
        
        
        addSingleCellItem(x: 12, line: 2, texture: db.getCell(10, 14, 1, 1))
        
        addSingleCellItem(x: 15, line: 2.5, texture: db.getCell(8, 15, 2, 2))
        addSingleCellItem(x: 18, line: 1, texture: db.getCell(10, 15, 1, 1))
        
        
        addSingleCellItem(x: 20, line: 4.5, texture: td.getCell(3, 10, 3, 3))
        addSingleCellItem(x: 20, line: 3, texture: td.getCell(2, 12, 1, 2))
        addSingleCellItem(x: 22, line: 3, texture: td.getCell(2, 12, 1, 2))
        //        let ob = Data.instance.outside_b
        //        let t = Data.instance.fullHouse
        //        addItem(x: 0, item: TallTree())
        //        addItem(x: 1, item: DoubleTrees())
        //        addItem(x: 2, item: DoubleTrees())
        //        addSingleCellItem(x: 0, line: 1, texture: ob.getCell(15, 10))
        //        addSingleCellItem(x: 3, line: 2, texture: t.getCell(6, 9))
        //        addItem(x: 3, item: MagicHouse())
        //        addItem(x: 10, item: VillageTrees())
        //        addItem(x: 13, item: VillagersHouse())
        //        addItem(x: 16, item: Goods())
        //        addItem(x: 19, item: NormalHouse())
        //        addSingleCellItem(x: 24, line: 2, texture: ob.getCell(5, 9))
        //        addSingleCellItem(x: 24, line: 3, texture: ob.getCell(5, 9))
        //        addItem(x: 25, item: TallTree())
        //        addItem(x: 26, item: DoubleTrees())
        //        addItem(x: 27, item: DoubleTrees())
        //        addItem(x: 28, item: TallTree())
        //        addSingleCellItem(x: 29, line: 2, texture: ob.getCell(4, 11))
        //        addSingleCellItem(x: 8, line: 3.25, texture: ob.getCell(2, 1))
        //
        
//        _ground = SKSpriteNode(imageNamed: "EastOfVillage.png")
//        _ground.size = CGSize(width: 30 * cellSize, height: 7 * cellSize)
//        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
//        _ground.position.x = -cellSize * 0.5
//        _ground.position.y = cellSize * 1.5
//        _ground.zPosition = UIStage.LAYER1
//        addChild(_ground)
        
        setPos(pos: 11)
    }
    
    override func firstCellEvent() {
        let cv = CenterVillage()
        Data.instance.stage.switchScene(next: cv, afterCreation: {
            cv.setPos(pos: (cv.xSize - 1).toInt())
        })
    }
    
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
            if 4 == pos {
//                let scene = MagicHouseInside()
//                stage.switchScene(next: scene, afterCreation: {
//                    scene.setPos(pos: 10)
//                    stage._char.faceNorth()
//                })
            } else if 21 == pos {
                
            }
        } else {
            if 11 == pos {
                let scene = CenterVillage()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 17)
                    stage._char.faceSouth()
                })
            }
        }
    }
    
}

