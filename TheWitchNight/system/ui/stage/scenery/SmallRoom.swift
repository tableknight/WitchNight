//
//  SmallRoom.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/12.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class SmallRoom: RandomScene {
    override init() {
        super.init()
    }
    
    override func create() {
        createSize()
        createMatrix()
        convertGround()
        createTouchableItems()
        
    }
    
    override func createSize() {
        xSize = seed(min:4, max: 7) * 2 + 1
        ySize = seed(min:4, max: 6) * 2 + 1
        let __size = CGSize(width: xSize.toFloat() * cellSize, height: ySize.toFloat() * cellSize)
        _ground.size = __size
    }
    
    override func createMatrix() {
        let __x0 = -_ground.size.width / 2
        let __y0 = _ground.size.height / 2
        let inside_a5 = Data.instance.inside_a5
//        let inside_a4 = Data.instance.inside_a4
//        let bs = BorderSets(border: (inside_a4.getCell(4, 7, 2, 2)), corner: (inside_a4.getCell(5, 5)))
//        createRow(y:0, first: bs.top_left_corner, last: bs.top_right_corner, cell: bs.horizontal_border, weight: Block.IMPASSABLE)
//        createRow(y: 1, first: bs.vertical_border, last: bs.vertical_border, cell: inside_a4.getCell(4.5, 8), weight: Block.IMPASSABLE)
//        createRow(y: 2, first: bs.vertical_border, last: bs.vertical_border, cell: inside_a4.getCell(4.5, 9), weight: Block.IMPASSABLE)
        
        for y in 3...ySize - 2 {
            var xMatrix = Array<Int>()
            for x in 0...xSize - 1 {
                let node = SKSpriteNode(texture:inside_a5.getCell(1, 2))
                if 0 == x || x == xSize - 1 {
//                    node = SKSpriteNode(texture: bs.vertical_border)
                    xMatrix.append(Block.IMPASSABLE)
                } else {
                    xMatrix.append(Block.PASSABLE)
                    
                }
                node.position.x = __x0 + cellSize * x.toFloat() + cellSize / 2
                node.position.y = __y0 - cellSize * y.toFloat() - cellSize / 2
                node.zPosition = Stage.LAYER1
                _ground.addChild(node)
                
            }
            _matrix.append(xMatrix)
            
        }
//        createRow(y: CGFloat(ySize - 1), first: bs.bottom_left_corner, last: bs.bottom_right_corner, cell: bs.horizontal_border, weight: Block.IMPASSABLE)
//        for y in 3...ySize - 2 {
//            let node = SKSpriteNode(texture:SKTexture(imageNamed: "sha.png"))
//            node.position.x = __x0 + cellSize + cellSize / 2
//            node.position.y = __y0 - cellSize * y.toFloat() - cellSize / 2
//            node.zPosition = Stage.LAYER1
//            _ground.addChild(node)
//        }
//        let window = Window()
        let windowX = seed(min: 2, max: xSize - 2)
        addItemNode(item: RoomWindow(), x: windowX.toFloat(), y: 1)
        addItemNode(item: RoomWindow(), x: (xSize - windowX - 1).toFloat(), y: 1)
        let bed = RoomBed()
        let bedX = seed(min: 1, max: xSize - 2)
        bed.place(parent: self, x: bedX, y: 3, shadowR: true)
        let table = RoomTable()
        table.place(parent: self, x: seed(min: 3, max: xSize - 3), y: seed(min: 5, max: ySize - 3))
        let cabinet = RoomRandomCabinet()
        let cabinetX = seed(min: 1, max: xSize - 2)
        if bedX != cabinetX {
            cabinet.place(parent: self, x: cabinetX, y: 2, shadowR: true)            
        }
    }
    override func createTouchableItems() {
        addFoods()
        addPots()
    }
    internal func addFoods() {
        let max = seed(max:4)
        for _ in 0...max {
            let y = seed(min: 4, max: ySize - 2)
            let x = yon() ? 1 : xSize - 2
            let rf = RoomFood()
            if rf.canPlace(scene: self, x: x, y: y) {
                rf.place(parent: self, x: x, y: y)
            }
        }
    }
    internal func addPots() {
        let max = seed(max:4)
        for _ in 0...max {
            let y = seed(min: 4, max: ySize - 2)
            let x = yon() ? 1 : xSize - 2
            let pot = Pot()
            if pot.canPlace(scene: self, x: x, y: y) {
                pot.place(parent: self, x: x, y: y)
            }
        }
    }
    
    internal func createRow(y:CGFloat, first:SKTexture, last:SKTexture, cell:SKTexture, weight:Int, layer:CGFloat = Stage.LAYER1) {
        let __x0 = -_ground.size.width / 2
        let __y0 = _ground.size.height / 2
        var xMatrix = Array<Int>()
        for x in 0...xSize - 1 {
            xMatrix.append(Block.IMPASSABLE)
            var node = SKSpriteNode(texture:cell)
            if 0 == x {
                node = SKSpriteNode(texture: first)
            } else if xSize - 1 == x {
                node = SKSpriteNode(texture: last)
            }
            node.position.x = __x0 + cellSize * x.toFloat() + cellSize / 2
            node.position.y = __y0 - cellSize * y - cellSize / 2
            node.zPosition = layer
            _ground.addChild(node)
        }
        _matrix.append(xMatrix)
    }

}

class RoomWindow:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.inside_b.getCell(0, 3, 1, 2)
        setTexture(item)
        xSize = 1
        ySize = 2
        _matrix = [[Block.PASSABLE],[Block.PASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class RoomBed:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.inside_b.getCell(4, 11, 1, 2)
        setTexture(item)
        xSize = 1
        ySize = 2
        _matrix = [[Block.IMPASSABLE],[Block.IMPASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class RoomTable:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.inside_b.getCell(0, 13, 1, 2)
        setTexture(item)
        xSize = 1
        ySize = 2
        _matrix = [[Block.IMPASSABLE],[Block.IMPASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class RoomFood:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.inside_b.getCell(9, 15)
        setTexture(item)
        _matrix = [[Block.IMPASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class RoomRandomCabinet:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.inside_b.getCell(seed(max: 6).toFloat(), 9, 1, 2)
        setTexture(item)
        xSize = 1
        ySize = 2
        _matrix = [[Block.PASSABLE],[Block.IMPASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
