//
//  Forest.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Forest: RandomScene {
    override init() {
        super.init()
    }

    override func create() {
        super.create()
//        createSize()
//        createMatrix()
//        convertGround()
        selfItems()
    }
    override func createTouchableItems() {
        
    }
    override func addDoors() {
        super.addDoors()
    }
    
    override func createMatrix() {
        super.createMatrix()
        addItems({
            return ForestStump()
        }, 3)
        addItems({
            return ForestTrunk()
        }, 2)
        addItems({
            return ForestFlower()
        }, 8)
    }
    
    private func selfItems() {
//        let fh = ForestHouse()
//        fh.place(parent: self, x: 0, y: 0, shadowR: true)
        let _max = min(xSize, ySize)
        addItems({
            return Tree2()
        }, _max)
    }
    
    override func getGroundCell() -> SKSpriteNode {
        return SKSpriteNode(texture: Data.instance.outside_a2.getCell(0, 0))
//        let which = seed()
//        if which < 10 {
//            return SKSpriteNode(texture: Data.instance.outside_a2.getCell(2, 0))
//        } else if which < 20 {
//            return SKSpriteNode(texture: Data.instance.outside_a2.getCell(2, 1))
//        } else if which < 30 {
//            return SKSpriteNode(texture: Data.instance.outside_a2.getCell(2, 2))
//        } else {
//        }
    }
    
//    override func addGroundItem() {
//        let _is = seed(max:100)
//        print(_is)
//        if _is < 25 {
//            let node = SKSpriteNode()
//            let t = Data.instance.outside_b.getCell(0, 11)
//            node.texture = t
//            node.size = t.size()
//            _ground.addChild(node)
//        }
//    }
    
}
class Tree2:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.outside_b.getCell(5, 12, 1, 2)
        setTexture(tree)
        xSize = 1
        ySize = 2
        _matrix = [[Block.PASSABLE],[Block.IMPASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class Sand:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.outside_a2.getCell(2, 1)
        setTexture(tree)
        xSize = 1
        ySize = 1
        _matrix = [[Block.PASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
//class ForestHouse:Portal {
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//        let part = UIPart()
//        let di = Data.instance;
//        let outside_a3 = di.outside_a3;
//        part.size = CGSize(width: cellSize * 3, height: cellSize * 4)
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(12, 0)), x: 0, y: 0)
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(12.5, 0)), x: 1, y: 0)
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(13, 0)), x: 2, y: 0)
//       
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(12, 1)), x: 0, y: 1)
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(12.5, 1)), x: 1, y: 1)
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(13, 1)), x: 2, y: 1)
//        
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(12, 2)), x: 0, y: 2)
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(12.5, 2)), x: 1, y: 2)
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(13, 2)), x: 2, y: 2)
//        
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(12, 3)), x: 0, y: 3)
//        part.addPart(item: SKSpriteNode(texture:di.outside_b.getCell(4, 8)), x: 1, y: 3)
//        part.addPart(item: SKSpriteNode(texture:outside_a3.getCell(13, 3)), x: 2, y: 3)
//        
//        setTexture(part.toTexture())
//        xSize = 3
//        ySize = 4
//        _matrix = [
//            [Block.PASSABLE, Block.PASSABLE, Block.PASSABLE],
//            [Block.PASSABLE, Block.PASSABLE, Block.PASSABLE],
//            [Block.IMPASSABLE, Block.IMPASSABLE, Block.IMPASSABLE],
//            [Block.IMPASSABLE, Block.PORTAL, Block.IMPASSABLE],
//        ]
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}
class ForestFlower:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.outside_b.getCell(CGFloat(seed(min: 0, max: 4)), CGFloat(seed(min: 11, max: 13)))
        setTexture(item)
        xSize = 1
        ySize = 1
        _matrix = [[Block.PASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class ForestStump:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.outside_b.getCell(4, 11)
        setTexture(item)
        xSize = 1
        ySize = 1
        _matrix = [[Block.IMPASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class ForestTrunk:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.outside_b.getCell(4, 12)
        setTexture(item)
        xSize = 1
        ySize = 1
        _matrix = [[Block.IMPASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
