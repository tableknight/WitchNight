//
//  WeaponsHouse.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/31.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class ArmorsHouseInside: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.inside_a4
        _groundSets = GroundSets(ground: oa4.getCell(2, 7, 2, 2), wall: oa4.getCell(2, 9, 2, 2))
        _name = "防具店"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 9
        hasInitialized = true
        createGround(start: 0, end: xSize.toInt())
//        let oa4 = Data.instance.inside_a4
//        _groundSets = GroundSets(ground: oa4.getCell(0, 7, 2, 2), wall: oa4.getCell(0, 9, 2, 2))
//        _groundSets = GroundSets(ground: oa4.getCell(14, 12, 2, 2), wall: oa4.getCell(14, 14, 2, 2))
        createTopWall()
        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
        let dc = Data.instance.dungeon_c
        let inside_c = Data.instance.inside_c;
        addSingleCellItem(x: 1, line: 3.45, texture: inside_c.getCell(8, 4))
        addSingleCellItem(x: 2, line: 3.45, texture: inside_c.getCell(9, 4))
        addSingleCellItem(x: 3, line: 3.45, texture: inside_c.getCell(10, 4))
        addSingleCellItem(x: 1, line: 2.75, texture: inside_c.getCell(11, 4), z: UIStage.LAYER2 + 1)
//        addSingleCellItem(x: 2, line: 2.75, texture: inside_c.getCell(13, 4), z: UIStage.LAYER2 + 1)
        addSingleCellItem(x: 0, line: 2, texture: inside_c.getCell(12, 2))
        
        addSingleCellItem(x: 5, line: 3.45, texture: inside_c.getCell(12, 4))
        addSingleCellItem(x: 6, line: 3.45, texture: inside_c.getCell(13, 4))
        addSingleCellItem(x: 7, line: 3.45, texture: inside_c.getCell(14, 4))
        addSingleCellItem(x: 7, line: 2.75, texture: inside_c.getCell(15, 4), z: UIStage.LAYER2 + 1)
        
        addSingleCellItem(x: 3, line: 4.6, texture: inside_c.getCell(10, 1))
        addSingleCellItem(x: 4, line: 4.6, texture: inside_c.getCell(11, 1))
        addSingleCellItem(x: 5, line: 4.6, texture: inside_c.getCell(12, 1))
//        addSingleCellItem(x: 6, line: 4.75, texture: inside_c.getCell(13, 1))
//        addSingleCellItem(x: 7, line: 4.75, texture: inside_c.getCell(14, 1))
//        addSingleCellItem(x: 8, line: 4.75, texture: inside_c.getCell(15, 1))
        
//        addSingleCellItem(x: 0, line: 2, texture: inside_c.getCell(12, 2))
//        addSingleCellItem(x: 0, line: 1.5, texture: inside_c.getCell(11, 9))
//        addSingleCellItem(x: 1, line: 1.5, texture: inside_c.getCell(11, 9))
//        addSingleCellItem(x: 0, line: 2, texture: inside_c.getCell(11, 4))
//        addSingleCellItem(x: 1, line: 2, texture: inside_c.getCell(12, 4))
//        addSingleCellItem(x: 2, line: 2, texture: inside_c.getCell(13, 4))
        
//        addSingleCellItem(x: 6, line: 3, texture: inside_c.getCell(14, 4))
//        addSingleCellItem(x: 7, line: 3, texture: inside_c.getCell(15, 4))
//        addSingleCellItem(x: 8, line: 3, texture: inside_c.getCell(8, 3))
//        addSingleCellItem(x: 6, line: 2, texture: inside_c.getCell(10, 3))
//        addSingleCellItem(x: 7, line: 2, texture: inside_c.getCell(9, 3))
//        addSingleCellItem(x: 8, line: 2, texture: inside_c.getCell(8, 3))
        
        addSingleCellItem(x: 1, line: 5.25, texture: dc.getCell(9, 3, 1, 2))
        addSingleCellItem(x: xSize - 2, line: 5.25, texture: dc.getCell(10, 3, 1, 2))
        
        
        
        
        let all2 = Data.instance.pictureAll2;
        addSingleCellItem(x: 2, line: 2, texture: shadow)
        addSingleCellItem(x: 2, line: 2.3, texture: all2.getCell(4, 0), z: UIStage.LAYER2 + 1)
        
        addSingleCellItem(x: 6, line: 2, texture: shadow)
        addSingleCellItem(x: 6, line: 2.3, texture: all2.getCell(10, 0), z: UIStage.LAYER2 + 1)
        
        
        
        //        _ground = SKSpriteNode(imageNamed: "MinionsHouseInside")
        //        _ground.size = CGSize(width: xSize * cellSize, height: 6 * cellSize)
        //        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
        //        _ground.position.x = -cellSize * 0.5
        //        _ground.position.y = cellSize
        //        _ground.zPosition = UIStage.LAYER1
        //        addChild(_ground)
        
//        position.x = -cellSize * 2
        
        createSellingItems()
        dealingPanel.create()
    }
    private func createSellingItems() {
        let char = Data.instance._char!
        let level = char._level
        let armors:Array<Armor> = [Amulet(), EarRing(), Shield(), Ring(), Ring(), MagicMark(), SoulStone()]
        for a in armors {
            a.create(level: level)
        }
        dealingPanel._sellingItems = armors
    }

    override func firstCellEvent() {
    }
    override func lastCellEvent() {
    }
    private var dealingPanel = DealingPanel()
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        //        let char = Data.instance._char!
        let this = self
        if stage.isUpperPoint {
            
            if 2 == pos && !stage._dialogExist {
                let img = Data.instance.pictureAll2.getCell(4, 0)
                let c = stage.showDialog(img: img, text: "看看吧，这里今天有有上好的装备。", name: "防具大师玛兰")
                c.addConfirmButton()
                
                c._confirmAction = {
                    stage.removeDialog(dlg: c)
            //                    let panel = DealingPanel()
            //                    panel.create()
                    stage.addPanelDefault(p: this.dealingPanel)
                }
            } else if 6  == pos && !stage._dialogExist {
                let img = Data.instance.pictureAll2.getCell(10, 0)
                let c = stage.showDialog(img: img, text: "你好啊，要来碰碰运气吗？", name: "铁匠伊索")
                c.addConfirmButton()
                
                c._confirmAction = {
                    stage.removeDialog(dlg: c)
                    let panel = DealingPanel()
                    panel.createRandomArmor()
                    panel.create()
                    stage.addPanelDefault(p: panel)
                }
            }
        } else {
            if 4 == pos {
                let scene = NorthOfNewComersVillage()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 4)
                    stage._char.faceSouth()
                })
            }
        }
    }
}

