//
//  WeaponsHouse.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/31.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class MagicHouseInside: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.inside_a4
        _groundSets = GroundSets(ground: oa4.getCell(14, 12, 2, 2), wall: oa4.getCell(14, 14, 2, 2))
        _name = "魔法小屋"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 17
        hasInitialized = true
        createGround(start: 0, end: xSize.toInt())
//        createTopWall()
        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
        //
        //         addSingleCellItem(x: 2, line: 2.15, texture: shadow)
        //         addSingleCellItem(x: 3, line: 2.15, texture: shadow)
        //
        //         addSingleCellItem(x: 5, line: 2.65, texture: shadow)
        //         addSingleCellItem(x: 6, line: 2.65, texture: shadow)
        //         addSingleCellItem(x: 7, line: 2.65, texture: shadow)
        //         addSingleCellItem(x: 7, line: 1.65, texture: shadow)
        //         addSingleCellItem(x: 8, line: 2.15, texture: shadow)
        //
        //         addSingleCellItem(x: 0, line: 3, texture: Data.instance.inside_b.getCell(0, 11, 1, 2))
        //         addSingleCellItem(x: 1, line: 3, texture: Data.instance.inside_c.getCell(2, 11))
        //         addSingleCellItem(x: 3, line: 3, texture: Data.instance.inside_c.getCell(2, 13))
        //         addSingleCellItem(x: 8, line: 4, texture: Data.instance.inside_b.getCell(2, 7, 1, 2))
        //         let pc8 = Data.instance.pictureCollabo8_1
        //
        //         addSingleCellItem(x: 3, line: 2.5, texture: pc8.getCell(4, 0))
        //         addSingleCellItem(x: 2, line: 2.5, texture: Data.instance.pictureNature.getCell(4, 0))
        //
        //         addSingleCellItem(x: 5, line: 3, texture: pc8.getCell(10, 0))
        //         addSingleCellItem(x: 6, line: 3, texture: pc8.getCell(1, 4))
        //         addSingleCellItem(x: 7, line: 3, texture: pc8.getCell(4, 4))
        //         addSingleCellItem(x: 8, line: 2.5, texture: pc8.getCell(7, 4))
        //         addSingleCellItem(x: 7, line: 2, texture: pc8.getCell(10, 4))
        
        let inside_c = Data.instance.inside_c;
        let inside_b = Data.instance.inside_b;
        addSingleCellItem(x: 0, line: 4, texture: inside_b.getCell(2, 7, 6, 2))
        addSingleCellItem(x: 6, line: 4, texture: inside_b.getCell(0, 9, 8, 2))
        addSingleCellItem(x: 14, line: 4, texture: inside_b.getCell(5, 9, 3, 2))
//        addSingleCellItem(x: 7, line: 4, texture: inside_c.getCell(14, 6, 1, 2))
//        addSingleCellItem(x: 8, line: 4, texture: inside_c.getCell(14, 6, 1, 2))
//
//        addSingleCellItem(x: 2, line: 3, texture: inside_c.getCell(8, 2))
//        addSingleCellItem(x: 6, line: 3, texture: inside_c.getCell(9, 2))
//
//        addSingleCellItem(x: 0, line: 2, texture: inside_c.getCell(10, 0))
//        addSingleCellItem(x: 1, line: 2, texture: inside_c.getCell(11, 0))
//        addSingleCellItem(x: 7, line: 2, texture: inside_c.getCell(10, 2))
//        addSingleCellItem(x: 8, line: 2, texture: inside_c.getCell(11, 2))
//        addSingleCellItem(x:4, line: 3, texture: inside_b.getCell(10, 7, 3, 2))
//        addSingleCellItem(x:8, line: 2, texture: inside_b.getCell(3, 13))
        addSingleCellItem(x:1, line: 1, texture: inside_c.getCell(1, 7))
        addSingleCellItem(x:3, line: 2, texture: inside_c.getCell(2, 7))
        addSingleCellItem(x:7, line: 2, texture: inside_c.getCell(4, 7))
        addSingleCellItem(x:12, line: 1, texture: inside_c.getCell(1, 7))
        addSingleCellItem(x:13, line: 2, texture: inside_c.getCell(5, 8))
        addSingleCellItem(x:4, line: 1, texture: inside_c.getCell(1, 8))
        addSingleCellItem(x:1, line: 3, texture: inside_c.getCell(8, 8, 3, 2), z: UIStage.LAYER2 + 2)
//        addSingleCellItem(x:0, line: 3, texture: inside_c.getCell(11, 8, 1, 2))
        addSingleCellItem(x:14, line: 3, texture: inside_b.getCell(5, 15, 3, 2), z: UIStage.LAYER2 + 2)
        addSingleCellItem(x:0, line: 2, texture: inside_b.getCell(0, 13))
        addSingleCellItem(x:4, line: 2, texture: inside_b.getCell(0, 13))
        addSingleCellItem(x:11, line: 2, texture: inside_c.getCell(5, 14))
        
        let actor2 = Data.instance.pictureActor2
        addSingleCellItem(x: 5, line: 1.95, texture: shadow)
        addSingleCellItem(x: 5, line: 2.3, texture: actor2.getCell(1, 4), z: UIStage.LAYER2 + 2)
        
        addSingleCellItem(x: 9, line: 1.95, texture: shadow)
        addSingleCellItem(x: 9, line: 2.3, texture: actor2.getCell(4, 4), z: UIStage.LAYER2 + 2)
        
        
//        let all2 = Data.instance.pictureAll2;
//        addSingleCellItem(x: 3, line: 2.15, texture: shadow)
//        addSingleCellItem(x: 3, line: 2.5, texture: all2.getCell(1, 4))
//
//        addSingleCellItem(x: 5, line: 2.15, texture: shadow)
//        addSingleCellItem(x: 5, line: 2.5, texture: all2.getCell(10, 4))
        
        
        
        //        _ground = SKSpriteNode(imageNamed: "MinionsHouseInside")
        //        _ground.size = CGSize(width: xSize * cellSize, height: 6 * cellSize)
        //        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
        //        _ground.position.x = -cellSize * 0.5
        //        _ground.position.y = cellSize
        //        _ground.zPosition = UIStage.LAYER1
        //        addChild(_ground)
        
                position.x = -cellSize * 10
        
//        dealingPanel.createSellingItems()
//        dealingPanel.create()
    }

    override func firstCellEvent() {
    }
    override func lastCellEvent() {
    }
    private var dealingPanel = DealingPanel()
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
                let char = Data.instance._char!
        let this = self
        if stage.isUpperPoint {
            if 15 == pos {
                stage._char.speak(text: "好可怕的声音～～")
                return
            }
            if 7 == pos {
                stage._char.speak(text: "知识就是力量～～")
                return
            }
            if 11 == pos {
                stage._char.speak(text: "哇～～会说话的人偶～～")
                return
            }
            if 5 == pos && !stage._dialogExist {
                let img = Data.instance.pictureActor2.getCell(1, 4)
                let c = stage.showDialog(img: img, text: "你好，\(char._name)，欢迎来到魔法的世界。", name: "大魔法师卡罗兰")
                c.addConfirmButton()
                
                c._confirmAction = {
                    stage.removeDialog(dlg: c)
                    let panel = DealingPanel()
                    panel.createMagicItems()
                    panel.create()
                    stage.addPanelDefault(p: panel)
                }
            } else if 9 == pos && !stage._dialogExist {
                let img = Data.instance.pictureActor2.getCell(4, 4)
                let c = stage.showDialog(img: img, text: "你好，\(char._name)，欢迎来到魔法的世界。", name: "大魔法师泽拉")
                c.addConfirmButton()
                
                c._confirmAction = {
                    stage.removeDialog(dlg: c)
                    let panel = DealingPanel()
                    panel.createRandomBook()
                    panel.create()
                    stage.addPanelDefault(p: panel)
                }
            }
        } else {
            if 10 == pos {
                let scene = EastOfNewComersVillage()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 8)
                    stage._char.faceSouth()
                })
            }
        }
    }
}

