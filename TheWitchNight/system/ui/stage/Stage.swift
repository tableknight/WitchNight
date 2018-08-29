//
//  Stage.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/19.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Stage:SKSpriteNode {
//    var _node:SKSpriteNode?
    private let BOTTOM:CGFloat = 0
    private let MIDDLE:CGFloat = 50
    private let TOP:CGFloat = 100
    private let _nightCover = SKSpriteNode.init(color: UIColor.black, size: UIScreen.main.bounds.size)
    private let _mask = SKCropNode()
    private var _dest:CGPoint!
    private var _char:UIUnit!
    private var _scene:Scenery!
    static let LAYER1:CGFloat = 0
    static let LAYER2:CGFloat = 10
    static let LAYER3:CGFloat = 20
    static let LAYER4:CGFloat = 30
    static let LAYER5:CGFloat = 40
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _nightCover.alpha = 0.3
//        let village = SKSpriteNode(texture: SKTexture(imageNamed: "village.png"))
//        village.zPosition = 0
//        _nightCover.zPosition = 100
//        addChild(village)
//        addChild(_nightCover)
//        setSight()
        isUserInteractionEnabled = true
    }
    func setSight(_ sight:CGFloat = 4) {
        let sightShape = SKShapeNode(circleOfRadius: 30 * sight)
        sightShape.lineWidth = 1
        sightShape.fillColor = UIColor.blue
        sightShape.glowWidth = 50
        _mask.maskNode = sightShape
    }
    
    func charInScene() -> CGPoint {
        let w = _scene._ground.size.width
        let h = _scene._ground.size.height
        let x = round(w / 2 - _scene._ground.position.x - cellSize / 2)
        let y = round(h / 2 + _scene._ground.position.y - cellSize / 2)
        return CGPoint(x: x, y: y)
    }
    
   
    
    func loadScene(_ scene:Scenery) {
        if _scene != nil {
            _scene._ground.removeFromParent()
        }
        _scene = scene
//        _scene.position.x = -24
//        _scene.position.y = 24
//        _mask.zPosition = BOTTOM
//        _mask.addChild(scene)
//        addChild(_mask)
        _scene._ground.zPosition = BOTTOM
//        _scene._itemLayer.zPosition = TOP
        addChild(_scene._ground)
//        addChild(_scene._itemLayer)
    }
    
    func setChar(_ char:UIUnit) {
        _char = char
//        _char.scale(to: CGSize(width: 60, height: 60))
        _char.zPosition = Stage.LAYER3
        addChild(_char)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _to:Int!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let view = touches.first?.view
        
//        self.texture = Cell.pot_broken()
//        print(touches.first?.view)
//        next?.touchesBegan(touches, with: event)
        
        let touch = touches.first?.location(in: self)
//        let view = touches.first?.view
//        let pos = getPosition(touchX!, touchY!)
        _dest = CGPoint(x: (touch?.x)!, y: (touch?.y)!)
        if _isMoving {
            debug("char in moving")
            return
        }
        move(next())
        
    }
    private func move(_ point:CGPoint) {
        if point.x == -1 && point.y == -1 {
            return
        }
        switch _to {
        case Position.NORTH:
            _char.faceNorth()
            _char.moveNorth()
            break
        case Position.SOUTH:
            _char.faceSouth()
            _char.moveSouth()
            break
        case Position.WEST:
            _char.faceWest()
            _char.moveWest()
            break
        case Position.EAST:
            _char.faceEast()
            _char.moveEast()
            break
        default:
            debug("no face direction in func move")
        }
        let cgv = CGVector(dx: -point.x, dy: -point.y)
        let mv = SKAction.move(by: cgv, duration: TimeInterval(Data.instance.frameSize * 2))
        let _self = self
        _isMoving = true
//        _scene._itemLayer.run(mv)
        _scene._ground.run(mv, completion: {
            _self._isMoving = false
//            var sd =
            _self._dest.x -= point.x
            _self._dest.y -= point.y
            let dis = _self.distanceOfPoints(_self._dest, CGPoint(x: 0, y: 0))
            if dis > _self.cellSize / 2 && _self._step < 5 {
                _self._step += 1
                _self.move(_self.next())
            } else {
                _self._step = 0
                _self.fixFace()
            }
        })
    }
    private func fixFace() {
        switch _to {
        case Position.NORTH:
            _char.faceNorth()
            break
        case Position.SOUTH:
            _char.faceSouth()
            break
        case Position.WEST:
            _char.faceWest()
            break
        case Position.EAST:
            _char.faceEast()
            break
        default:
            debug("no face direction in func move handler")
        }
    }
//    private func toArrayXByPositionX(_ x:CGFloat) -> Int {
//        let __x = round(x)
//        return ((__x - cellSize / 2 + _scene._ground.size.width / 2) / cellSize).toInt()
//    }
//    private func toArrayYByPositionY(_ y:CGFloat) -> Int {
//        let __y = round(y)
//        return ((_scene._ground.size.height / 2 - __y - cellSize / 2) / cellSize).toInt()
//    }
//    private func destXToArratX(_ x:CGFloat) {
//
//    }
    private func touchItem() -> Bool {
        let charPos = charInScene()
        let dx = toArrayX(charPos.x + _dest.x)
        let dy = toArrayY(charPos.y - _dest.y)
        let cx = toArrayX(charPos.x)
        let cy = toArrayY(charPos.y)
        let weight = _scene.getWeight(dx, dy)
        if weight == Block.TOUCHABLEITEM || weight == Block.EVIL {
            if distanceOfPoints(CGPoint(x:0, y:0), _dest) <= cellSize * 1.5 && (cx == dx || cy == dy) {
                if cx < dx {
                    _char.faceEast()
                } else if cx > dx {
                    _char.faceWest()
                } else if cy < dy {
                    _char.faceSouth()
                } else if cy > dy {
                    _char.faceNorth()
                }
                if weight == Block.TOUCHABLEITEM {
                    let item = _scene.getItemNode(dx, dy)
                    item.doTouch()
                } else if weight == Block.EVIL {
                    print("evil")
                } else {
                    print("point")
                }
                return true
            }
        }
        
        return false
    }
    private func passable(_ x:Int, _ y:Int) -> Bool {
        let weight = _scene.getWeight(x, y)
        if weight == Block.PASSABLE || weight == Block.PASSABLEITEM {
            return true
        }
        return false
    }
    private func next() -> CGPoint {
        if touchItem() {
            return CGPoint(x: -1, y: -1)
        }
        let charPos = charInScene()
        let cx = toArrayX(charPos.x)
        let cy = toArrayY(charPos.y)
        var blocks = Array<CGPoint>()
        var dirs = Array<Int>()
        
        if cy > 0 && passable(cx, cy - 1) {
            blocks.append(CGPoint(x: 0, y: cellSize))
            dirs.append(Position.NORTH)
        }
        if cx > 0 && passable(cx - 1, cy) {
            blocks.append(CGPoint(x: -cellSize, y: 0))
            dirs.append(Position.WEST)
        }
        if cx < _scene.xSize - 1 && passable(cx + 1, cy) {
            blocks.append(CGPoint(x:cellSize, y:0))
            dirs.append(Position.EAST)
        }
        if cy < _scene.ySize - 1 && passable(cx, cy + 1) {
            blocks.append(CGPoint(x:0, y:-cellSize))
            dirs.append(Position.SOUTH)
        }
        var min:CGFloat = -1
        var direction:Int = 0
        for i in 0...(blocks.count - 1) {
            let dis = distanceOfPoints(_dest, blocks[i])
            if min == -1 {
                min = dis
                direction = i
            } else {
                if min > dis {
                    min = dis
                    direction = i
                }
            }
        }
        _to = dirs[direction]
        return blocks[direction]
    }
    
    private func distanceOfPoints(_ a:CGPoint, _ b:CGPoint) -> CGFloat {
        return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y))
    }

    private var _isMoving = false;
    private var _step:Int = 0;
    
    private func toArrayX(_ x:CGFloat) -> Int {
        return round(x / cellSize).toInt()
    }
    private func toArrayY(_ y:CGFloat) -> Int {
        return round(y / cellSize).toInt()
    }
    
}
