//
//  WeaponsHouse.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/31.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class WeaponsHouseInside: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
                let oa4 = Data.instance.inside_a4
                _groundSets = GroundSets(ground: oa4.getCell(2, 7, 2, 2), wall: oa4.getCell(2, 9, 2, 2))
        _name = "武器店"
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
        
        let inside_c = Data.instance.inside_c;
        addSingleCellItem(x: 0, line: 4, texture: inside_c.getCell(15, 6, 1, 2))
        addSingleCellItem(x: 1, line: 4, texture: inside_c.getCell(15, 6, 1, 2))
        addSingleCellItem(x: 2, line: 4, texture: inside_c.getCell(15, 6, 1, 2))
        addSingleCellItem(x: 6, line: 4, texture: inside_c.getCell(14, 6, 1, 2))
        addSingleCellItem(x: 7, line: 4, texture: inside_c.getCell(14, 6, 1, 2))
        addSingleCellItem(x: 8, line: 4, texture: inside_c.getCell(14, 6, 1, 2))
        
        addSingleCellItem(x: 3.5, line: 3, texture: inside_c.getCell(8, 2))
        addSingleCellItem(x: 4.5, line: 3, texture: inside_c.getCell(9, 2))
        
        addSingleCellItem(x: 0.5, line: 4.75, texture: inside_c.getCell(10, 0))
        addSingleCellItem(x: 4, line: 4.75, texture: inside_c.getCell(11, 0))
//        addSingleCellItem(x: 7, line: 4.6, texture: inside_c.getCell(10, 2))
        addSingleCellItem(x: 7.5, line: 4.75, texture: inside_c.getCell(11, 2))
        
        addSingleCellItem(x: 0, line: 2, texture: inside_c.getCell(13, 2))
        
        
        let all2 = Data.instance.pictureAll2;
        addSingleCellItem(x: 3, line: 2.15, texture: shadow)
        addSingleCellItem(x: 3, line: 2.5, texture: all2.getCell(1, 4), z: UIStage.LAYER2 + 1)
        
        addSingleCellItem(x: 5, line: 2.15, texture: shadow)
        addSingleCellItem(x: 5, line: 2.5, texture: all2.getCell(10, 4), z: UIStage.LAYER2 + 1)
        
        let dc = Data.instance.dungeon_c
        addSingleCellItem(x: 2, line: 5.25, texture: dc.getCell(9, 3, 1, 2))
        addSingleCellItem(x: xSize - 3, line: 5.25, texture: dc.getCell(10, 3, 1, 2))
        
//        _ground = SKSpriteNode(imageNamed: "MinionsHouseInside")
//        _ground.size = CGSize(width: xSize * cellSize, height: 6 * cellSize)
//        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
//        _ground.position.x = -cellSize * 0.5
//        _ground.position.y = cellSize
//        _ground.zPosition = UIStage.LAYER1
//        addChild(_ground)
        
//        position.x = -cellSize * 2
        
        dealingPanel.createSellingItems()
        dealingPanel.create()
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
            
            if 3 == pos && !stage._dialogExist {
                let img = Data.instance.pictureAll2.getCell(1, 4)
                let c = stage.showDialog(img: img, text: "看看吧，这里今天有有上好的武器。", name: "武器大师奇诺")
                c.addConfirmButton()
                
                c._confirmAction = {
                    stage.removeDialog(dlg: c)
                    stage.addPanelDefault(p: this.dealingPanel)
//                    let panel = DealingPanel()
//                    panel.create()
                }
            } else if 5 == pos && !stage._dialogExist {
                let img = Data.instance.pictureAll2.getCell(10, 0)
                let c = stage.showDialog(img: img, text: "你好啊，要来我这里碰碰运气吗？", name: "铁匠伊凡诺")
                c.addConfirmButton()
                
                c._confirmAction = {
                    stage.removeDialog(dlg: c)
                    let panel = DealingPanel()
                    panel.createRandomWeapon()
                    panel.create()
                    stage.addPanelDefault(p: panel)
                }
            }
        } else {
            if 4 == pos {
                let scene = NorthOfNewComersVillage()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 9)
                    stage._char.faceSouth()
                })
            }
        }
    }
}

