//
//  NorthOfVillage.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class NorthOfNewComersVillage: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.dungeon_a4
        _groundSets = GroundSets(ground: oa4.getCell(0, 2, 2, 2), wall: oa4.getCell(0, 4, 2, 2))
        _name = CenterVillage.VILLAGE_NAME + "·北"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 24
        hasInitialized = true
        createGround(start: 0, end: 24)
                let ob = Data.instance.outside_b
        addItem(x: 0, item: DoubleTrees())
        addItem(x: 1, item: TallTree())
        let fh = Data.instance.tilee_outsidetown
        addSingleCellItem(x: 2, line: 5, texture: fh.getCell(0, 9, 5, 4))
//        addSingleCellItem(x: 4, line: 1, texture: fh.getCell(14, 15))
        addItem(x: 7, item: MinionsHouse())
        addItem(x: 12, item: DoubleTrees())
        addSingleCellItem(x: 13, line: 2, texture: FlowerRoad().toTexture())
        addSingleCellItem(x: 13, line: 4, texture: ob.getCell(5, 12, 1, 2))
        addItem(x: 14, item: DoubleTrees())
        addItem(x: 15, item: Inn())
        addItem(x: 21, item: VillageTrees())
        addSingleCellItem(x: 16, line: 3.25, texture: ob.getCell(6, 1))

        addSingleCellItem(x: 9, line: 4.25, texture: ob.getCell(1, 0))
        addSingleCellItem(x: 4, line: 4.25, texture: ob.getCell(4, 1))

        addSingleCellItem(x: 23, line: 1, texture: ob.getCell(3, 11))
//
        
//        _ground = SKSpriteNode(imageNamed: "NorthOfVillage.png")
//        _ground.size = CGSize(width: 24 * cellSize, height: 7 * cellSize)
//        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
//        _ground.position.x = -cellSize * 0.5
//        _ground.position.y = cellSize * 1.5
//        _ground.zPosition = UIStage.LAYER1
//        addChild(_ground)
        
//        setPos(pos: 9)
    }
    
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
            if 9 == pos {
                let scene = WeaponsHouseInside()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 4)
                    stage._char.faceNorth()
                })
            } else if 4 == pos {
                let scene = ArmorsHouseInside()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 4)
                    stage._char.faceNorth()
                })
            } else if 16 == pos {
                
            }
        } else {
            if 13 == pos {
                let scene = CenterVillage()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 8)
                    stage._char.faceSouth()
                })
            }
            
        }
    }
    
}
