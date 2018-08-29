//
//  StartValley.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/6/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class StartValley: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.outside_a4
        _groundSets = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
        _name = "迷踪丛林"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 21
        hasInitialized = true
        createGround(start: 0, end: xSize.toInt())
        
        addItem(x: 0, item: DoubleTrees())
        addItem(x: 1, item: DoubleTrees())
        addItem(x: 2, item: TallTree())
        addItem(x: 3, item: DoubleTrees())
        addItem(x: 4, item: TallTree())
        addItem(x: 6, item: DoubleTrees())
        addItem(x: 7, item: DoubleTrees())
        addItem(x: 8, item: TallTree())
        addItem(x: 9, item: TallTree())
        addItem(x: 10, item: TallTree())
        addItem(x: 11, item: DoubleTrees())
        addItem(x: 12, item: DoubleTrees())

        addItem(x: 13, item: TallTree())
        addItem(x: 14, item: TallTree())
        addItem(x: 15, item: DoubleTrees())
        
        addItem(x: 17, item: TallTree())
        addItem(x: 18, item: TallTree())
        addItem(x: 19, item: DoubleTrees())
        addItem(x: 20, item: DoubleTrees())
        
        addSingleCellItem(x: 20, line: 1, texture: Data.instance.outside_b.getCell(14, 10))
        
        createEvil(xPos: 8)
        createEvil(xPos: 12)
        createEvil(xPos: 18)
        
        eventIn.append(7)
        
//        Data.instance.stage.hideUI()
        
    }
    

    override func firstCellEvent() {
    }
    override func lastCellEvent() {
        let stage = Data.instance.stage!
        let scene = CenterVillage()
        showMsg(text: "进入\(CenterVillage.VILLAGE_NAME)")
        stage.switchScene(next: scene, afterCreation: {
            scene.setPos(pos: 14)
            stage._char.faceEast()
//            stage.showUI()
        })
    }
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if 7 == pos {
            stage._char.speak(text: "这是什么玩意？")
            removeEvent(x: 7)
        }
    }
    override func getEvil(id:Int = -1) -> UIEvil {
        let uie = UIEvil()
        let c = GreenGhost()
        c.create(level: 1)
        uie.setTexture(c._img)
        uie.faceWest()
        uie._evils.append(c)
        return uie
    }
    
    override func createEvil(xPos: Int) {
        let evil = getEvil()
        evil.position.x = xPos.toFloat() * cellSize + cellSize * 0.5
        evil.zPosition = UIStage.LAYER3
        evil.position.y = cellSize * 0.25
        evil.name = "evil\(xPos)";
        //            print(evil.name)
        _ground.addChild(evil)
        evilIn.append(xPos)
        
        
    }
}
class GreenGhost: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.8
        _stars.stamina = 1.6
        _stars.agility = 1.4
        _stars.intellect = 0.6
        _name = "小绿龙"
        _race = EvilType.NATURE
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Data.instance.pictureCollabo8_2.getCell(3, 7, 3, 4)
    }
}
