//
//  MinionsHouse.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/10.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MinionsHouseInside: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.inside_a4
        _groundSets = GroundSets(ground: oa4.getCell(2, 7, 2, 2), wall: oa4.getCell(2, 9, 2, 2))
        _name = "饲养师之家"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 9
        hasInitialized = true
        createGround(start: 0, end: xSize.toInt())
        createTopWall()
        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
        
        
        addSingleCellItem(x: 2, line: 2.15, texture: shadow, z: UIStage.LAYER2 - 1)
        addSingleCellItem(x: 3, line: 2.15, texture: shadow, z: UIStage.LAYER2 - 1)
        
        addSingleCellItem(x: 5, line: 2.65, texture: shadow, z: UIStage.LAYER2 - 1)
        addSingleCellItem(x: 6, line: 2.65, texture: shadow, z: UIStage.LAYER2 - 1)
        addSingleCellItem(x: 7, line: 2.65, texture: shadow, z: UIStage.LAYER2 - 1)
        addSingleCellItem(x: 7, line: 1.65, texture: shadow, z: UIStage.LAYER2 - 1)
        addSingleCellItem(x: 8, line: 2.15, texture: shadow, z: UIStage.LAYER2 - 1)
    
        addSingleCellItem(x: 0, line: 3, texture: Data.instance.inside_b.getCell(0, 11, 1, 2))
        addSingleCellItem(x: 2, line: 5.25, texture: Data.instance.inside_b.getCell(0, 3, 1, 2))
        addSingleCellItem(x: 1, line: 3, texture: Data.instance.inside_c.getCell(2, 11))
        addSingleCellItem(x: 6, line: 4.5, texture: Data.instance.inside_c.getCell(9, 1))
        addSingleCellItem(x: 3, line: 3, texture: Data.instance.inside_c.getCell(2, 13))
        addSingleCellItem(x: 8, line: 4, texture: Data.instance.inside_b.getCell(2, 7, 1, 2))
        let pc8 = Data.instance.pictureCollabo8_1

        addSingleCellItem(x: 3, line: 2.5, texture: pc8.getCell(4, 0), z: UIStage.LAYER2 + 1)
        addSingleCellItem(x: 2, line: 2.5, texture: Data.instance.pictureNature.getCell(4, 0), z: UIStage.LAYER2 + 1)
        
        addSingleCellItem(x: 5, line: 3, texture: pc8.getCell(10, 0), z: UIStage.LAYER2 + 1)
        addSingleCellItem(x: 6, line: 3, texture: pc8.getCell(1, 4), z: UIStage.LAYER2 + 1)
        addSingleCellItem(x: 7, line: 3, texture: pc8.getCell(4, 4), z: UIStage.LAYER2 + 1)
        addSingleCellItem(x: 8, line: 2.5, texture: pc8.getCell(7, 4), z: UIStage.LAYER2 + 1)
        addSingleCellItem(x: 7, line: 2, texture: pc8.getCell(10, 4), z: UIStage.LAYER2 + 1)
        
        addSingleCellItem(x: 6, line: 1.65, texture: shadow, z: UIStage.LAYER2 - 1)
        addSingleCellItem(x: 6, line: 2, texture: pc8.getCell(1, 0), z: UIStage.LAYER2 + 1)
        
        
         
 
        
        
        
//        _ground = SKSpriteNode(imageNamed: "MinionsHouseInside")
//        _ground.size = CGSize(width: xSize * cellSize, height: 6 * cellSize)
//        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
//        _ground.position.x = -cellSize * 0.5
//        _ground.position.y = cellSize
//        _ground.zPosition = UIStage.LAYER1
//        addChild(_ground)
        
        position.x = -cellSize * 3
        
        
    }

    override func firstCellEvent() {
    }
    override func lastCellEvent() {
    }
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
//        let char = Data.instance._char!
        if stage.isUpperPoint {
            if 2 == pos {
                stage._char.speak(text: "好可爱的喵咪～～")
                return
            }
            if 3 == pos && !stage._dialogExist {
                let img = Data.instance.pictureCollabo8_1.getCell(4, 0)
                let c = stage.showDialog(img: img, text: "你好啊，需要存取你的随从和宠物吗？", name: "饲养师伊泽贝尔")
                c.addConfirmButton()
                c._confirmAction = {
                    stage.removeDialog(dlg: c)
                    let panel = MinionsHousePanel()
                    panel.create()
                    stage.addPanelDefault(p: panel)
                }
            } else if 6 == pos && !stage._dialogExist {
                let img = Data.instance.pictureCollabo8_1.getCell(1, 0)
                let dlg = stage.showDialog(img: img, text: "你好啊，冒险者！我是封印大师艾里，这世上有很多强力的怪物可以招至麾下为你所用。", name: "封印大师艾里")
                
                dlg.addNextButton()
                dlg._nextAction = {
                    dlg.text = "封印怪物需要使用[封印卷轴]，怪物的血量越少，封印成功的几率也就越大。"
                    dlg._nextAction = {
                        dlg.text = "怪物的能力多种多样，就算是同一种怪物，属性也是有所不同的，尽量找厉害一点的怪物作为手下吧。"
                        if Data.instance._char._event.contains(2) {
                            return
                        }
                        dlg._nextAction = {
                            dlg.text = "好了，我呢，私人赞助你几个[封印卷轴]，希望你招募到强大的手下。"
                            dlg._nextAction = {
                                let ss = SealScroll()
                                ss._count = 5
                                Data.instance._char.addProp(p: ss)
                                showMsg(text: "获得[封印卷轴]x5。")
                                Data.instance._char._event.append(2)
                                dlg.remove()
                                stage._char.speak(text: "谢谢～～")
                            }
                        }
                    }
                }
                
            }
        } else {
            if 4 == pos {
                let scene = WestOfNewComersVillage()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 4)
                    stage._char.faceSouth()
                })
            }
        }
    }
}
