//
//  UIRandomScene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIRandomScene: UIScene {
    override func create() {
        hasInitialized = true
        createXSzie()
        //_index start from 1
        if _index <= 1 {
            _totalFloor = seed(min: 1, max: 7)
            _gateFloor = seed(min: 1, max: _totalFloor + 1)
        } else {
            let scene = Data.instance.stage._scenes[0] as! UIRandomScene
            _totalFloor = scene._totalFloor
            _gateFloor = scene._gateFloor
        }
        debug("totalFloor is \(_totalFloor)")
        debug("_gateFloor is \(_gateFloor)")
        createGround(start: 0, end: xSize.toInt())
        createEvils()
        if _index < _totalFloor {
            createNextScenePortal()
        }
        if _index > 1 {
            createPrevScenePortal()
        }
        _groundSize = 2
    }
    override func createGround(start: Int, end: Int) {
        super.createGround(start: start, end: end)
        createItems(start: start, end: end)
    }
    override func getEvil(id:Int = -1) -> UIEvil {
        //创建要现实的怪物样子
        let uie = UIEvil()
        //确定时哪个怪物
        var which = seed(min: 0, max: 4)
        if id > -1 {
            which = id
        }
        let e = getEvilById(which)
        uie.setTexture(e._img)
        uie.faceWest()
        //战斗中怪物组合中的另一个怪物
        let another = seed(min: 0, max: 4)
        let elist = [which, another]
        var maxEvilCount = seed(min: 1, max: 5)
        if _level <= 5 {
            maxEvilCount = seed(min: 1, max: 3)
        } else if _level <= 10 {
            maxEvilCount = seed(min: 1, max: 4)
        }
        for _ in 0...maxEvilCount - 1 {
            var eid = elist[seed(min: 0, max: 2)]
            if 1 == maxEvilCount {
                eid = which
            }
            let c = getEvilById(eid)
            var level = 1
            if _level > 1 {
                level = seed(min: _level - 1, max: _level + 2)
            }
            if level < 1 {
                level = 1
            }
            c.create(level: level.toFloat())
            uie._evils.append(c)
        }
        uie._thisType = which
        return uie
    }
    override func getEvilById(_ id: Int) -> Creature {
        return Creature()
    }
    
    override func firstCellEvent() {
        let stage = Data.instance.stage!
        let index = stage._curScene._index
        let prev = index - 1
        for scn in stage._scenes {
            if scn._index == prev {
                stage.switchScene(next: scn)
                break
            }
        }
    }
    var _totalFloor = 0
    var _gateFloor = 0
    override func lastCellEvent() {
        let stage = Data.instance.stage!
        let index = stage._curScene._index
        let nextIndex = index + 1
        var nextScene = UIScene()
        var exist = false
        for scn in stage._scenes {
            if scn._index == nextIndex {
                nextScene = scn
                exist = true
                break
            }
        }
        if !exist {
            nextScene = stage.getSceneById(id: stage._curScene._id)
            nextScene._index = nextIndex
            nextScene._level = _level
            stage._scenes.append(nextScene)
            //            nextScene.create()
        }
        stage.switchScene(next: nextScene)
    }
    
    internal func createItems(start:Int, end:Int) {
        var i = start
        var gateExist = false
        let gatePosition = seed(min: 1, max: xSize.toInt() - 5)
        while i < end - 2 {
            var item = getItem()
            if _index == _gateFloor && !gateExist && i >= gatePosition {
                gateExist = true
                item = Gate()
            }
            if 1 == item._ySize {
                item.position.y = cellSize * 1.5
            } else {
                item.position.y = cellSize * 2
            }
            item.name = "item\(i)"
            if item._xSize == 3 {
                item.name = "item\(i + 1)"
            }
            
            item.position.x = i.toFloat() * cellSize
            item.anchorPoint = CGPoint(x: 0, y: 0.5)
            //            item.position.x = i.toFloat() * cellSize + item.size.width * 0.5
            //            item.position.y = item._ySize.toFloat() * cellSize + cellSize * 0.5
            //            item.anchorPoint = CGPoint(x: 0.5, y: 1)
            item.zPosition = UIStage.LAYER2
            i += item._xSize
            _ground.addChild(item)
        }
    }
    
    override func triggerEvent(pos: Int) {
        let item = _ground.childNode(withName: "item\(pos)") as! UIItem
        item.triggerEvent()
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isRandomScene = true
        _groundSize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
