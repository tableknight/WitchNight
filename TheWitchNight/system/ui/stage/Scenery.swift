//
//  Scenery.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/22.
//  Copyright © 2018年 Chen. All rights reserved.
//
//总结 143.999999999988 注意转换
import SpriteKit
class Scenery:Core {
    var _matrix:Array<Array<Int>> = Array()
    internal var _ground:SKSpriteNode = SKSpriteNode()
    internal var _itemLayer:SKSpriteNode = SKSpriteNode()
    internal var _evilCount = 0
    internal var _evilList = Array<Int>()
    internal var _units = Array<UIUnit>()
    internal var cellSize = Data.instance.cellSize
    internal var _cells = [String: UICell]()
    
    override init() {
        super.init()
    }
    func setMatrix(_ matrix:Array<Array<Int>>) {
        self._matrix = matrix
//        ySize = matrix.count
//        xSize = matrix[0].count
        
//        _ground.size = CGSize(width: xSize.toFloat() * cellSize, height: ySize.toFloat() * cellSize)
    }
    
    internal func convertGround() {
        _ground = SKSpriteNode(texture:SKView().texture(from: _ground))
//        _itemLayer = SKSpriteNode(texture:SKView().texture(from: _itemLayer))
    }
    
    func getItemNode(_ x:Int, _ y:Int) -> UICell {
        let name = "\(y)\(x)"
        return _cells[name]!
    }
    
    func addItemNode(item:UICell, x:CGFloat, y:CGFloat) {
        let xSize = round(item.size.width / cellSize)
        let ySize = round(item.size.height / cellSize)
        let xHalf = (x + xSize / 2) * cellSize
        let yHalf = (y + ySize / 2) * cellSize
//        if xSize.truncatingRemainder(dividingBy: 2) == 0 {
//            xHalf = x * cellSize
//        }
//        if ySize.truncatingRemainder(dividingBy: 2) == 0 {
//            yHalf = y * cellSize
//        }
        item.position.x = -_ground.size.width / 2 + xHalf
        item.position.y = _ground.size.height / 2 - yHalf
        for key in item.nameWithPos {
            _cells[key] = item
        }
        if item.zLayer == UICell.BEYOND_PLAYER {
            item.zPosition = Stage.LAYER5
//            _itemLayer.addChild(item)
        } else {
            item.zPosition = Stage.LAYER2
        }
        _ground.addChild(item)
    }
    
//    func addItemToGround(_ item:UICell, _ y:CGFloat, _ x:CGFloat) {
//        let xSize = round(item.size.width / cellSize)
//        let ySize = round(item.size.height / cellSize)
//        let xHalf = (x + xSize / 2) * cellSize
//        let yHalf = (y + ySize / 2) * cellSize
//        //        if xSize.truncatingRemainder(dividingBy: 2) == 0 {
//        //            xHalf = x * cellSize
//        //        }
//        //        if ySize.truncatingRemainder(dividingBy: 2) == 0 {
//        //            yHalf = y * cellSize
//        //        }
//        item.position.x = -_itemLayer.size.width / 2 + xHalf
//        item.position.y = _itemLayer.size.height / 2 - yHalf
////        for key in item.nameWithPos {
////            _cells[key] = item
////        }
//        _ground.addChild(item)
//    }
    
    internal func setGround(_ fileName:String) {
        let t = SKTexture(imageNamed: fileName)
        _ground.texture = t
        _ground.size = t.size()
//        _itemLayer.size = t.size()
//        addChild(_ground)
    }
    
    var ySize:Int = 0
    var xSize:Int = 0
    
    func getWeight(_ x:Int, _ y:Int) -> Int {
        if x >= xSize {
            debug("> xSize in getWeight")
            return Block.OUTOFRANGE
        }
        if y >= ySize {
            debug("> ySize in getWeight")
            return Block.OUTOFRANGE
        }
        if x < 0 {
            debug("x < 0")
            return Block.OUTOFRANGE
        }
        if y < 0 {
            debug("y < 0")
            return Block.OUTOFRANGE
        }
        return _matrix[y][x]
    }
    
    internal func createMovingEvils() {
        for _ in 1..._evilCount {
            let sed = seed(max:_evilList.count)
            let evilId = _evilList[sed]
            let evil = createEvilById(evilId)
            let unit = UIUnit()
//            unit.setTexture(evil._img)
            unit.setSpeed(evil._moveSpeed)
            unit._contentUnit = evil
            putUnitOnGround(unit)
            _units.append(unit)
        }
    }
    
    private func putUnitOnGround(_ unit:UIUnit) {
        let x = seed(max:xSize - 1)
        let y = seed(max:ySize - 1)
//        let x = 6
//        let y = 6
        if getWeight(x, y) == Block.PASSABLE {
            unit.position.x = x.toFloat() * cellSize - (_ground.size.width / 2) + cellSize / 2
            unit.position.y = (_ground.size.height / 2) - y.toFloat() * cellSize - cellSize / 2
            _matrix[y][x] = Block.EVIL
            unit.zPosition = Stage.LAYER3
            _ground.addChild(unit)
        } else {
            putUnitOnGround(unit)
        }
    }
    
    internal func setUnitMove() {
        for i in 0..._units.count - 1 {
            move(_units[i], next(_units[i]))
        }
    }
    
    private func toArrayXByPositionX(_ x:CGFloat) -> Int {
        let __x = round(x)
        return ((__x - cellSize / 2 + _ground.size.width / 2) / cellSize).toInt()
    }
    private func toArrayYByPositionY(_ y:CGFloat) -> Int {
        let __y = round(y)
        return ((_ground.size.height / 2 - __y - cellSize / 2) / cellSize).toInt()
    }
//    private var _nextPoint:CGPoint = CGPoint(x: 0, y: 0)
    private func canMove(_ x:Int, _ y:Int) -> Bool {
        if getWeight(x - 1, y) == Block.PASSABLE
        || getWeight(x + 1, y) == Block.PASSABLE
        || getWeight(x, y - 1) == Block.PASSABLE
            || getWeight(x, y + 1) == Block.PASSABLE {
            return true
        }
        return false
        
    }
    private func next(_ unit:UIUnit) -> CGPoint {
        var arrayX = toArrayXByPositionX(unit.position.x)
        var arrayY = toArrayYByPositionY(unit.position.y)
        if !canMove(arrayX, arrayY) {
            return CGPoint(x: -1, y: -1)
        }
        let pos = seed(max:4)
//        print(pos)
//        let pos = Position.NORTH
        var point = CGPoint(x: 0, y: 0)
        switch pos {
        case Position.NORTH:
            arrayY -= 1
            point.y = cellSize
            break
        case Position.SOUTH:
            arrayY += 1
            point.y = -cellSize
            break
        case Position.WEST:
            arrayX -= 1
            point.x = -cellSize
            break
        case Position.EAST:
            arrayX += 1
            point.x = cellSize
            break
        default:
            debug("no postion in func next!")
        }
        if Block.PASSABLE == getWeight(arrayX, arrayY) {
//            _nextPoint.x = arrayX.toFloat()
//            _nextPoint.y = arrayY.toFloat()
            return point
        } else {
            return next(unit)
        }
    }
    
    private func move(_ unit:UIUnit, _ point:CGPoint) {
        if _pause {
            debug("\(unit._contentUnit._name)'s action paused!")
            return
        }
        if point.x == -1 && point.y == -1 {
            return
        }
        if point.x == cellSize {
            unit.faceEast()
            unit.moveEast()
        } else if point.x == -cellSize {
            unit.faceWest()
            unit.moveWest()
        } else if point.y == cellSize {
            unit.faceNorth()
            unit.moveNorth()
        } else if point.y == -cellSize {
            unit.faceSouth()
            unit.moveSouth()
        } else {
            debug("error in func move!")
        }
        let cgv = CGVector(dx: point.x, dy: point.y)
        let mv = SKAction.move(by: cgv, duration: TimeInterval(Data.instance.frameSize * unit._moveSpeed))
        let __stop = seed(min:1, max:unit._moveSpeed.toInt() * 4).toFloat()
        let wait = SKAction.wait(forDuration: TimeInterval(Data.instance.frameSize * __stop))
//        let animate = SKAction.sequence([mv, wait])
        let _self = self
        let arrayX = toArrayXByPositionX(unit.position.x)
        let arrayY = toArrayYByPositionY(unit.position.y)
        
        unit.run(mv, completion: {
            let py = round(point.y / _self.cellSize).toInt()
            let px = round(point.x / _self.cellSize).toInt()
            _self._matrix[arrayY][arrayX] = Block.PASSABLE
            _self._matrix[arrayY - py][arrayX + px] = Block.EVIL
            
            unit.run(wait, completion: {
                _self.move(unit, _self.next(unit))
            })
        })
    }
    private var _pause:Bool = false
    var pause:Bool {
        set {
            if !newValue {
                setUnitMove()
            }
            _pause = newValue
        }
        get {
            return _pause
        }
    }
}
