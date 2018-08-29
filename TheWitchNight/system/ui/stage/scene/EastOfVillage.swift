//
//  NewComersVillage.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class EastOfNewComersVillage: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.dungeon_a4
        _groundSets = GroundSets(ground: oa4.getCell(0, 2, 2, 2), wall: oa4.getCell(0, 4, 2, 2))
        _name = CenterVillage.VILLAGE_NAME + "·东"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        hasInitialized = true
        xSize = 20
        createGround(start: 0, end: xSize.toInt())
        let ob = Data.instance.outside_b
        let t = Data.instance.tilee_outsidetown
        addItem(x: 0, item: TallTree())
        addItem(x: 1, item: DoubleTrees())
        addItem(x: 2, item: DoubleTrees())
        addSingleCellItem(x: 0, line: 1, texture: ob.getCell(15, 10))
        addSingleCellItem(x: 3, line: 2, texture: t.getCell(6, 9))
        addItem(x: 3, item: MagicHouse())
        addItem(x: 10, item: VillageTrees())
        addItem(x: 13, item: VillagersHouse())
        addItem(x: 16, item: Goods())
//        addItem(x: 19, item: NormalHouse())
//        addSingleCellItem(x: 24, line: 2, texture: ob.getCell(5, 9))
//        addSingleCellItem(x: 24, line: 3, texture: ob.getCell(5, 9))
//        addItem(x: 25, item: TallTree())
//        addItem(x: 26, item: DoubleTrees())
//        addItem(x: 27, item: DoubleTrees())
//        addItem(x: 28, item: TallTree())
//        addSingleCellItem(x: 29, line: 2, texture: ob.getCell(4, 11))
        addSingleCellItem(x: 8, line: 3.25, texture: ob.getCell(2, 1))
//
        
//        _ground = SKSpriteNode(imageNamed: "EastOfVillage.png")
//        _ground.size = CGSize(width: 30 * cellSize, height: 7 * cellSize)
//        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
//        _ground.position.x = -cellSize * 0.5
//        _ground.position.y = cellSize * 1.5
//        _ground.zPosition = UIStage.LAYER1
//        addChild(_ground)
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
            if 8 == pos {
                let scene = MagicHouseInside()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 10)
                    stage._char.faceNorth()
                })
            }
        }
    }
    
}

class MagicHouse:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Data.instance.tilee_outsidetown
        let house = SKSpriteNode(texture: t.getCell(10, 14, 6, 4))
        let l = SKSpriteNode(texture: t.getCell(9, 15, 1, 3))
        l.position.x = -cellSize * 3
        l.anchorPoint = CGPoint(x: 1, y: 1)
        house.addChild(l)
        let b = SKSpriteNode(texture: t.getCell(10, 15, 3, 1))
        b.position.y = -cellSize * 2.5
        b.position.x = -cellSize * 1.5
//        b.anchorPoint = CGPoint(x: 1, y: 1)
        house.addChild(b)
//        let road = SKSpriteNode(texture: t.getCell(14, 15))
//        road.position.x = cellSize * 1.5
//        road.position.y = -cellSize * 2.5
//        house.addChild(road)
        setTexture(house.toTexture())
        //        _items = [0]
        _xSize = 6
        _ySize = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class VillagersHouse:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Data.instance.tilee_outsidetown
        setTexture(t.getCell(5, 3.5, 3, 4))
        //        _items = [0]
        _xSize = 3
        _ySize = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class Goods:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = Data.instance.outside_b
        setTexture(t.getCell(5, 15, 3, 2))
        //        _items = [0]
        _xSize = 3
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
