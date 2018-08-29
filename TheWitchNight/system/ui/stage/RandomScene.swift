//
//  RandomScene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class RandomScene: Scenery {
    override init() {
        super.init()
    }
    
    func create() {
        createSize()
        createMatrix()
        convertGround()
//        addDoors()
//        calEvils()
//        createMovingEvils()
//        setUnitMove()
        createTouchableItems()
    }
    
    internal func createSize() {
        xSize = seed(min:4, max: 16) * 2 + 1
        ySize = seed(min:4, max: 16) * 2 + 1
//        xSize = 5
//        ySize = 5
        let __size = CGSize(width: xSize.toFloat() * cellSize, height: ySize.toFloat() * cellSize)
        _ground.size = __size
        _itemLayer.size = __size
    }
    
    internal func createMatrix() {
        var matrix = Array<Array<Int>>()
        let __x0 = -_ground.size.width / 2
        let __y0 = _ground.size.height / 2
        for y in 0...ySize - 1 {
            var xMatrix = Array<Int>()
            for x in 0...xSize - 1 {
                xMatrix.append(0)
                let node = getGroundCell()
                node.position.x = __x0 + cellSize * x.toFloat() + cellSize / 2
                node.position.y = __y0 - cellSize * y.toFloat() - cellSize / 2
                node.zPosition = Stage.LAYER1
                _ground.addChild(node)
            }
            matrix.append(xMatrix)
        }
        setMatrix(matrix)
    }
    
    internal func getGroundCell() -> SKSpriteNode {
        return SKSpriteNode(texture: Data.instance.inside_a5.getCell(2, 2))
    }
    
    internal func addItems(_ getItem:() -> UICell, _ max:Int) {
        for _ in 0...max {
            let _x = seed(max: xSize - 1)
//            let _x = 3
            let _y = seed(max: ySize - 1)
//            var _x = 2
//            var _y = 1
//            if i == 1 {
//                _x = 2
//                _y = 2
//            }
            let item = getItem()
            if item.canPlace(scene:self, x: _x, y: _y) {
//                p-rint("x:\(_x) y:\(_y) i:\(i) pos:\(item.zPosition)")
                item.place(parent: self, x: _x, y: _y)
                item.zPosition = Stage.LAYER4 + _y.toFloat()

            }
        }
//        let item = getItem()
//        item.zPosition = Stage.LAYER4 + 4
//        item.place(parent: self, x: 2, y: 2)
//        let item1 = getItem()
//        item1.zPosition = Stage.LAYER4 + 5
//        item1.place(parent: self, x: 2, y: 3)
    }
    
//    internal func addGroundItem() {
//
//    }
    
    internal func calEvils() {
        _evilList = [EvilId.Mummy, EvilId.Slime]
        _evilCount = min(xSize, ySize)
    }

    internal func createTouchableItems() {
//        let bed = Bed()
//        bed.place(parent: self, x: 0, y: 0)
    }
    
    internal func addDoors() {
        let _lastX = seed(max: xSize)
        let _lastY = seed(max: ySize)
        let _nextX = seed(max: xSize)
        let _nextY = seed(max: ySize)

        addItemNode(item:LastFloor(), x:_lastX.toFloat(), y:_lastY.toFloat())
        addItemNode(item:NextFloor(), x:_nextX.toFloat(), y:_nextY.toFloat())
        createPath(x1: _lastX, y1: _lastY, x2: _nextX, y2: _nextY)
    }
    internal var _path = Array<CGPoint>()
    internal func createPath(x1:Int, y1:Int, x2:Int, y2:Int) {
        var dirs = Array<CGPoint>()
        if x2 > x1 {
            dirs.append(CGPoint(x: x1 + 1, y: y1))
        }
        if x1 > x2 {
            dirs.append(CGPoint(x: x1 - 1, y: y1))
        }
        if y1 < y2 {
            dirs.append(CGPoint(x: x1, y: y1 + 1))
        }
        if y2 < y1 {
            dirs.append(CGPoint(x: x1, y: y1 - 1))
        }
        if dirs.count == 0 {
            return
        }
        let next = dirs[seed(max: dirs.count)]
        _path.append(next)
        createPath(x1: next.x.toInt(), y1: next.y.toInt(), x2: x2, y2: y2)
    }
    func inPath(x:CGFloat, y:CGFloat) -> Bool {
//        for i in 0..._path.count - 1 {
//            if _path[i].x == x && _path[i].y == y {
//                return true
//            }
//        }
        
        return false
    }
//    internal func ___createPath(x1:Int, y1:Int, x2:Int, y2:Int) {
//        var _dirs = Array<CGPoint>()
//        if x1 > 0 {
//            _dirs.append(CGPoint(x: x1 - 1, y: y1))
//        }
//        if x1 < xSize - 1 {
//            _dirs.append(CGPoint(x: x1 + 1, y: y1))
//        }
//        if y1 > 0 {
//            _dirs.append(CGPoint(x: x1, y: y1 - 1))
//        }
//        if y1 < ySize - 1 {
//            _dirs.append(CGPoint(x: x1, y: y1 + 1))
//        }
//        var _min:CGFloat = 0
//        var _minIndex = 0
//        for i in 0..._dirs.count - 1 {
//            let dis = distanceOfPoints(_dirs[i], CGPoint(x: x2, y: y2))
//            if i == 0 {
//                _min = dis
//                _minIndex = 0
//            } else {
//                if dis == 0 {
//                    return
//                } else if _min > dis {
//                    _min = dis
//                    _minIndex = i
//                }
//            }
//        }
//        let minPoint = _dirs[_minIndex]
//        _path.append(minPoint)
//        createPath(x1: minPoint.x.toInt(), y1: minPoint.y.toInt(), x2: x2, y2: y2)
//    }
    private func distanceOfPoints(_ a:CGPoint, _ b:CGPoint) -> CGFloat {
        return round(sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)))
    }
}
