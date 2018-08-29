//
//  AdventurersUnion.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class AdventurersUnionInside: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.inside_a4
        _groundSets = GroundSets(ground: oa4.getCell(0, 7, 2, 2), wall: oa4.getCell(0, 9, 2, 2))
        _name = "冒险者工会"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 14
        hasInitialized = true
        
        createGround(start: 0, end: xSize.toInt())
        createTopWall()
        let tile_innerTown = Data.instance.tile_innerTown
        let inside_c = Data.instance.inside_c
        let inside_b = Data.instance.inside_b
//        let zp1 = UIStage.LAYER2
//        let zp2 = zp1 + 1
//        addSingleCellItem(x: 0, line: 4, texture: inside_b.getCell(2, 7, 6, 2))
//        addSingleCellItem(x: 6, line: 4, texture: inside_b.getCell(0, 9, 8, 2))
//        addSingleCellItem(x: 15, line: 4, texture: inside_b.getCell(8, 1, 3, 2))
//        addSingleCellItem(x: 15, line: 2, texture: tile_innerTown.getCell(8, 6, 1, 2))
//        addSingleCellItem(x: 15, line: 3, texture: tile_innerTown.getCell(11, 6, 1, 2), z: zp2)
//        addSingleCellItem(x: 14, line: 4, texture: tile_innerTown.getCell(9, 6, 1, 2))
        
//        addSingleCellItem(x: 0, line: 3.5, texture: tile_innerTown.getCell(11, 6, 1, 2))
//        addSingleCellItem(x: 1, line: 2.5, texture: KnightMaster().toTexture())
//        addSingleCellItem(x: 2, line: 3.5, texture: tile_innerTown.getCell(10, 6, 1, 2))
//
//        addSingleCellItem(x: 4, line: 2.5, texture: ArchMage().toTexture())
//        addSingleCellItem(x: 5, line: 3.5, texture: tile_innerTown.getCell(9, 6, 1, 2))
//
//        addSingleCellItem(x: 6, line: 2.5, texture: ArchBishop().toTexture())
//        addSingleCellItem(x: 7, line: 3.5, texture: tile_innerTown.getCell(8, 6, 1, 2))
//
//        addSingleCellItem(x: 8, line: 2.5, texture: SealMaster().toTexture())
//        addSingleCellItem(x: 9, line: 3.5, texture: tile_innerTown.getCell(11, 6, 1, 2))
//
//        addSingleCellItem(x: 10, line: 2.5, texture: TheBurglar().toTexture())
//        addSingleCellItem(x: 11, line: 3.5, texture: tile_innerTown.getCell(10, 6, 1, 2))
//
//        addSingleCellItem(x: 12, line: 2.5, texture: MonkMaster().toTexture())
//        addSingleCellItem(x: 13, line: 3.5, texture: tile_innerTown.getCell(9, 6, 1, 2))
//
//        addSingleCellItem(x: 2, line: 5.5, texture: inside_b.getCell(1, 5, 1, 2))
//        addSingleCellItem(x: xSize - 3, line: 5.5, texture: inside_b.getCell(1, 5, 1, 2))
//
//        addSingleCellItem(x: 0, line: 4.5, texture: inside_b.getCell(10, 4))
//        addSingleCellItem(x: 7, line: 4.5, texture: inside_b.getCell(12, 4, 2, 1))
//        addSingleCellItem(x: 5, line: 4.5, texture: inside_b.getCell(14, 1, 1, 2))
//        addSingleCellItem(x: 10, line: 4.5, texture: inside_b.getCell(14, 1, 1, 2))
//
//        addSingleCellItem(x: 14, line: 4, texture: inside_b.getCell(10, 13, 2, 2))
//        addSingleCellItem(x: 0, line: 2, texture: Data.instance.outside_b.getCell(8, 7))
//        addSingleCellItem(x: 0, line: 3, texture: Data.instance.outside_b.getCell(8, 7))
//        addSingleCellItem(x: 1, line: 2, texture: Data.instance.outside_b.getCell(8, 7))
        
        
//        _ground = SKSpriteNode(imageNamed: "AdventurersUnion")
//        _ground.size = CGSize(width: xSize * cellSize, height: 6 * cellSize)
//        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
//        _ground.position.x = -cellSize * 0.5
//        _ground.position.y = cellSize
//        _ground.zPosition = UIStage.LAYER1
//        addChild(_ground)
        
//        position.x = -cellSize * 3
        
        
        let ia5 = Data.instance.inside_a5
        addSingleCellItem(x: 0, line: 4, texture: tile_innerTown.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 2, line: 4, texture: tile_innerTown.getCell(8, 6, 1, 2))
        
        addSingleCellItem(x: 1, line: 4, texture: ia5.getCell(0, 8, 0.5, 1))
        addSingleCellItem(x: 1.5, line: 4, texture: ia5.getCell(2.5, 8, 0.5, 1))
        addSingleCellItem(x: 1, line: 3, texture: ia5.getCell(0, 8, 0.5, 1))
        addSingleCellItem(x: 1.5, line: 3, texture: ia5.getCell(2.5, 8, 0.5, 1))
        addSingleCellItem(x: 1, line: 5, texture: ia5.getCell(0, 8, 0.5, 1))
        addSingleCellItem(x: 1.5, line: 5, texture: ia5.getCell(2.5, 8, 0.5, 1))

        addSingleCellItem(x: 3, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 4, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 5, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 6, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 7, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 8, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 9, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 10, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 11, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 12, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 13, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        
        addSingleCellItem(x: 3, line: 3, texture: inside_c.getCell(8, 8, 3, 2), z:UIStage.LAYER2 + 2)
        addSingleCellItem(x: 6, line: 4, texture: inside_c.getCell(11, 8, 1, 2), z:UIStage.LAYER2 + 2)
        addSingleCellItem(x: 7, line: 3, texture: tile_innerTown.getCell(8, 10, 3, 2), z:UIStage.LAYER2 + 2)
        addSingleCellItem(x: 10, line: 4, texture: tile_innerTown.getCell(11, 10, 1, 2), z:UIStage.LAYER2 + 2)
        addSingleCellItem(x: 11, line: 3, texture: inside_c.getCell(8, 8, 3, 2), z:UIStage.LAYER2 + 2)
        
        addSingleCellItem(x: 4, line: 3, texture: Data.instance.pictureBaldo.getCell(10, 0))
        addSingleCellItem(x: 8, line: 3, texture: Data.instance.pictureEvil.getCell(1, 0))
        addSingleCellItem(x: 12, line: 3, texture: Data.instance.pictureEvil.getCell(7, 0))
        
        
        addSingleCellItem(x: 0, line: 4.5, texture: inside_b.getCell(11, 4))
        addSingleCellItem(x: 2, line: 4.5, texture: inside_b.getCell(10, 4))
        
    }

    override func firstCellEvent() {
    }
    override func lastCellEvent() {
    }
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
//        let char = Data.instance._char!
//        let this = self
        if stage.isUpperPoint {
            if 1 == pos {
                let west = UnionsSecondFloor()
                stage.switchScene(next: west, afterCreation: {
                    west.setPos(pos: 1)
                    stage._char.faceNorth()
                })
                return
            }
            if 4 == pos && !stage._dialogExist {
                let img = Data.instance.pictureBaldo.getCell(10, 0)
                let dlg = stage.showDialog(img: img, text: "欢迎！战斗中，属性是最基础的战斗数值，比如攻击，防御，精神。是否需要详细的了解一下属性说明？", name: "哥布林讨伐者洛肯")
                dlg.addConfirmButton()
                dlg._confirmAction = {
                    dlg.remove()
                    let pep = PropertiesExplainPanel()
                    pep.create()
                    Data.instance.stage.addPanelDefault(p: pep)
                }
            } else if 8 == pos && !stage._dialogExist {
                let img = Data.instance.pictureEvil.getCell(1, 0)
                let dlg = stage.showDialog(img: img, text: "你好，旅行者。装备是一个人战斗力的体现，我这里有详细的装备介绍，你是否需要了解一下？", name: "匕首协会首领施普恩")
                dlg.addConfirmButton()
                dlg._confirmAction = {
                    dlg.remove()
                    let pep = OutfitExplainPanel()
                    pep.create()
                    Data.instance.stage.addPanelDefault(p: pep)
                }
            } else if 12 == pos && !stage._dialogExist {
                let img = Data.instance.pictureEvil.getCell(7, 0)
                let dlg = stage.showDialog(img: img, text: "愿主神守护着你，冒险者。这个世界之所以存在，是依赖于诸神在创世之初所创造的魔法秩序，主神眷顾子民，将创世秩序刻蚀在一张张卷轴中，流传后世，这就是我们世界中法术的来源。", name: "主教萨拉瓦拉")
                dlg.addConfirmButton()
                dlg._confirmAction = {
                    dlg.remove()
                    let pep = SpellExplainPanel()
                    pep.create()
                    Data.instance.stage.addPanelDefault(p: pep)
                }
            }
        } else {
            if 1 == pos {
                let west = WestOfNewComersVillage()
                stage.switchScene(next: west, afterCreation: {
                    west.setPos(pos:12)
                    stage._char.faceSouth()
                })
            }
        }
    }
//    override func triggerEvent(pos: Int) {
//        let stage = Data.instance.stage!
//        if stage.isUpperPoint {
//
////            if 1 == pos {
////                let km = KnightMaster()
////                km.showInfoDialog()
////            } else if 4 == pos {
////                let c = ArchMage()
////                c.showInfoDialog()
////            } else if 6 == pos {
////                let c = ArchBishop()
////                c.showInfoDialog()
////            } else if 8 == pos {
////                let c = SealMaster()
////                c.showInfoDialog()
////            } else if 10 == pos {
////                let c = TheBurglar()
////                c.showInfoDialog()
////            } else if 12 == pos {
////                let c = MonkMaster()
////                c.showInfoDialog()
////            }
//        } else {
//            if 3 == pos {
//                let west = WestOfNewComersVillage()
//                stage.switchScene(next: west, afterCreation: {
//                    west.setPos(pos: 22)
//                    stage._char.faceSouth()
//                })
//            }
//        }
//    }
}

class CareerMaster:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var _text = ""
    var _img:SKTexture!
    var _careerName = ""
    var _name = ""
    func setCharTo() {
        let char = Data.instance._char!
        for m in char._minions {
            m._seat = BUnit.STAND_BY
        }
        
        char._spells = char._spells + char._spellsInuse
        char._spellsInuse = Array<Spell>()
    }
    
    func showInfoDialog() {
        let stage = Data.instance.stage!
        if stage._dialogExist {
            return
        }
        let char = Data.instance._char!
        let dlg = stage.showDialog(img: _img, text: _text, name: _name)
        if char._level > 10 || char._name != "冒险者" {
            return
        }
        
        dlg.addNextButton()
        let this = self
        dlg._nextAction = {
            stage.removeDialog(dlg: dlg)
            let c = stage.showDialog(img: this._img, text: "你确定要成为\(this._careerName)吗？", name: this._name)
            c.addConfirmButton()
            c._confirmAction = {
                showMsg(text: "恭喜，你成为了\(this._careerName)！")
                this.setCharTo()
                stage.removeDialog(dlg: c)
            }
        }
    }
    
    
}

class KnightMaster:CareerMaster {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _img = Data.instance.pictureCollabo8_1.getCell(7, 0)
////        setTexture(_img)
//        let shadow = SKSpriteNode(texture: SKTexture(imageNamed: "select.png").getCell(3, 0))
//        shadow.position.y = -cellSize * 0.25
//        let inode = SKSpriteNode(texture: _img)
//        inode.addChild(shadow)
//        addChild(inode)
//        inode.position.x = cellSize * 0.5
//        shadow.position.x = inode.position.x
//
        _careerName = "骑士"
        _name = "骑士长艾伊诺"
        _text = "成为一名骑士，你将会获得：6点属性成长、2个技能位、1个随从位，并且可以装备武器、护身符、项链、盾牌、灵魂石和左右法戒。"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setCharTo() {
        let char = Data.instance._char!
        char._name = _careerName
        char.hasShield = true
        char.hasWeapon = true
        char.hasMark = false
        char.hasEarring = false
        char._levelPoint = 6
        char._minionsCount = 1
        char._spellCount = 2
        
        if char._magicMark.hasInitialized {
            char.addProp(p: char._magicMark)
            char._magicMark.off()
            char._magicMark = MagicMark()
        }
        
        if char._earRing.hasInitialized {
            char.addProp(p: char._earRing)
            char._earRing.off()
            char._earRing = EarRing()
        }
        
        super.setCharTo()
    }
    
}

class SealMaster:CareerMaster {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _img = Data.instance.pictureAll.getCell(4, 4)
//        let shadow = SKSpriteNode(texture: SKTexture(imageNamed: "select.png").getCell(3, 0))
//        shadow.position.y = -cellSize * 0.25
//        addChild(shadow)
//        let inode = SKSpriteNode(texture: _img)
//        addChild(inode)

        _careerName = "封印师"
        _name = "封印师伊凡兹"
        _text = "成为一名封印师，你将会获得：4点属性成长、2个技能位、3个随从位，并且可以装备武器、护身符、项链、灵魂石和左右法戒。"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setCharTo() {
        let char = Data.instance._char!
        char._name = _careerName
        char.hasShield = false
        char.hasWeapon = true
        char.hasMark = false
        char.hasEarring = false
        char._levelPoint = 4
        char._minionsCount = 3
        char._spellCount = 2
        
        if char._magicMark.hasInitialized {
            char.addProp(p: char._magicMark)
            char._magicMark.off()
            char._magicMark = MagicMark()
        }
        
        if char._earRing.hasInitialized {
            char.addProp(p: char._earRing)
            char._earRing.off()
            char._earRing = EarRing()
        }
        
        if char._shield.hasInitialized {
            char.addProp(p: char._shield)
            char._shield.off()
            char._shield = Shield()
        }
        
        super.setCharTo()
    }
    
}

class ArchBishop:CareerMaster {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _img = Data.instance.picturePeople2.getCell(7, 0)
//        let shadow = SKSpriteNode(texture: SKTexture(imageNamed: "select.png").getCell(3, 0))
//        shadow.position.y = -cellSize * 0.25
//        addChild(shadow)
//        let inode = SKSpriteNode(texture: _img)
//        addChild(inode)

        _careerName = "牧师"
        _name = "大主教梅森·维德"
        _text = "成为一名牧师，你将会获得：4点属性成长、3个技能位、2个随从位，并且可以装备武器、护身符、项链、耳环、魔印、灵魂石和左右法戒。"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setCharTo() {
        let char = Data.instance._char!
        char._name = _careerName
        char.hasShield = false
        char.hasWeapon = true
        char.hasMark = true
        char.hasEarring = true
        char._levelPoint = 4
        char._minionsCount = 2
        char._spellCount = 3
        
        if char._shield.hasInitialized {
            char.addProp(p: char._shield)
            char._shield.off()
            char._shield = Shield()
        }
        
        super.setCharTo()
    }
    
}

class ArchMage:CareerMaster {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _img = Data.instance.pictureAll2.getCell(7, 4)
//        let shadow = SKSpriteNode(texture: SKTexture(imageNamed: "select.png").getCell(3, 0))
//        shadow.position.y = -cellSize * 0.25
//        addChild(shadow)
//        let inode = SKSpriteNode(texture: _img)
//        addChild(inode)
        _careerName = "法师"
        _name = "大法师艾兰德"
        _text = "成为一名法师，你将会获得：5点属性成长、3个技能位、1个随从位，并且可以装备武器、护身符、项链、耳环、魔印、灵魂石和左右法戒。"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setCharTo() {
        let char = Data.instance._char!
        char._name = _careerName
        char.hasShield = false
        char.hasWeapon = true
        char.hasMark = true
        char.hasEarring = true
        char._levelPoint = 5
        char._minionsCount = 1
        char._spellCount = 3

        if char._shield.hasInitialized {
            char.addProp(p: char._shield)
            char._shield.off()
            char._shield = Shield()
        }
        
        super.setCharTo()
    }
    
}

class TheBurglar:CareerMaster {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _img = Data.instance.pictureActor1.getCell(1, 4)
//        let shadow = SKSpriteNode(texture: SKTexture(imageNamed: "select.png").getCell(3, 0))
//        shadow.position.y = -cellSize * 0.25
//        addChild(shadow)
//        let inode = SKSpriteNode(texture: _img)
//        addChild(inode)
        _careerName = "盗贼"
        _name = "维拉斯"
        _text = "成为一名盗贼，你将会获得：7点属性成长、1个技能位、1个随从位，并且可以装备武器、护身符、项链、灵魂石和左右法戒。"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setCharTo() {
        let char = Data.instance._char!
        char._name = _careerName
        char.hasShield = false
        char.hasWeapon = true
        char.hasMark = false
        char.hasEarring = false
        char._levelPoint = 7
        char._minionsCount = 1
        char._spellCount = 1
        
        if char._magicMark.hasInitialized {
            char.addProp(p: char._magicMark)
            char._magicMark.off()
            char._magicMark = MagicMark()
        }
        
        if char._earRing.hasInitialized {
            char.addProp(p: char._earRing)
            char._earRing.off()
            char._earRing = EarRing()
        }
        
        if char._shield.hasInitialized {
            char.addProp(p: char._shield)
            char._shield.off()
            char._shield = Shield()
        }
        
        super.setCharTo()
    }
    
}

class MonkMaster:CareerMaster {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _img = Data.instance.pictureAll.getCell(4, 0)
//        let shadow = SKSpriteNode(texture: SKTexture(imageNamed: "select.png").getCell(3, 0))
//        shadow.position.y = -cellSize * 0.25
//        addChild(shadow)
//        let inode = SKSpriteNode(texture: _img)
//        addChild(inode)
        _careerName = "武道家"
        _name = "武术大师李岚"
        _text = "成为一个武道家，你将会获得：6点属性成长、2个技能位、2个随从位，并且可以装备护身符、项链、耳环、灵魂石和左右法戒。"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setCharTo() {
        let char = Data.instance._char!
        char._name = _careerName
        char.hasShield = false
        char.hasWeapon = false
        char.hasMark = false
        char.hasEarring = true
        char._levelPoint = 6
        char._minionsCount = 2
        char._spellCount = 2
        
        if char._magicMark.hasInitialized {
            char.addProp(p: char._magicMark)
            char._magicMark.off()
            char._magicMark = MagicMark()
        }
        
        if char._weapon.hasInitialized {
            char.addProp(p: char._weapon)
            char._weapon.off()
            char._weapon = Weapon()
        }
        
        if char._shield.hasInitialized {
            char.addProp(p: char._shield)
            char._shield.off()
            char._shield = Shield()
        }
        
        super.setCharTo()
    }
    
}
class UnionsSecondFloor:UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.inside_a4
        _groundSets = GroundSets(ground: oa4.getCell(0, 7, 2, 2), wall: oa4.getCell(6, 14, 2, 2))
        _name = "冒险者工会二楼"
        _groundSize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 14
        hasInitialized = true
        
        createGround(start: 0, end: xSize.toInt())
        createTopWall()
        let tile_innerTown = Data.instance.tile_innerTown
//        let inside_c = Data.instance.inside_c
//        let inside_b = Data.instance.inside_b
        addSingleCellItem(x: 0, line: 3, texture: tile_innerTown.getCell(9, 6, 1, 2))
        addSingleCellItem(x: 2, line: 3, texture: tile_innerTown.getCell(9, 6, 1, 2))
        
        addItem(x: 3, line: 4, item: HotelHouseDoor())
        addItem(x: 6, line: 4, item: HotelHouseDoor())
        addItem(x: 9, line: 4, item: HotelHouseDoor())
        addItem(x: 12, line: 4, item: HotelHouseDoor())
//        addItem(x: 9, line: 4, item: HotelHouseDoor())
//        addItem(x: 12, line: 4, item: HotelHouseDoor())
        
        let ia5 = Data.instance.inside_a5
        
        addSingleCellItem(x: 1, line: 3, texture: ia5.getCell(0, 8, 0.5, 1))
        addSingleCellItem(x: 1.5, line: 3, texture: ia5.getCell(2.5, 8, 0.5, 1))
        addSingleCellItem(x: 1, line: 2, texture: ia5.getCell(0, 8, 0.5, 1))
        addSingleCellItem(x: 1.5, line: 2, texture: ia5.getCell(2.5, 8, 0.5, 1))
        addSingleCellItem(x: 1, line: 4, texture: ia5.getCell(0, 8, 0.5, 1))
        addSingleCellItem(x: 1.5, line: 4, texture: ia5.getCell(2.5, 8, 0.5, 1))
        
//        let ia5 = Data.instance.inside_a5
//        addSingleCellItem(x: 1, line: 4, texture: Data.instance.tilee_outsidetown.getCell(1, 14, 1, 2))
        
        
    }
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
            if 1 == pos {
                let scene = UnionsThirdFloor()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 1)
                    stage._char.faceNorth()
                })
                return
            }
            if 3 == pos {
                let scene = KnightsRoom()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 3)
                    stage._char.faceNorth()
                })
                return
            }
            if 6 == pos {
                let scene = MagesRoom()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 3)
                    stage._char.faceNorth()
                })
                return
            }
            if 9 == pos {
                let scene = BishopsRoom()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 3)
                    stage._char.faceNorth()
                })
                return
            }
            if 12 == pos {
                let scene = SealersRoom()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 3)
                    stage._char.faceNorth()
                })
                return
            }
        } else {
            if 1 == pos {
                let west = AdventurersUnionInside()
                stage.switchScene(next: west, afterCreation: {
                    west.setPos(pos: 1)
                    stage._char.faceSouth()
                })
            }
        }
    }
}
class UnionsThirdFloor:UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.inside_a4
        _groundSets = GroundSets(ground: oa4.getCell(0, 7, 2, 2), wall: oa4.getCell(6, 14, 2, 2))
        _name = "冒险者工会三楼"
        _groundSize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 14
        hasInitialized = true
        
        createGround(start: 0, end: xSize.toInt())
        createTopWall()
        let tile_innerTown = Data.instance.tile_innerTown
        //        let inside_c = Data.instance.inside_c
        //        let inside_b = Data.instance.inside_b
//        addSingleCellItem(x: 1, line: 3, texture: tile_innerTown.getCell(10, 6, 1, 2))
//        addSingleCellItem(x: 2, line: 3, texture: tile_innerTown.getCell(10, 6, 1, 2))
        
        addItem(x: 0, line: 4, item: HotelHouseDoor())
        addSingleCellItem(x: 1, line: 3, texture: tile_innerTown.getCell(10, 6, 1, 2))
        addItem(x: 3, line: 4, item: HotelHouseDoor())
        addSingleCellItem(x: 4, line: 3, texture: tile_innerTown.getCell(10, 6, 1, 2))
        addItem(x: 6, line: 4, item: HotelHouseDoor())
        addSingleCellItem(x: 7, line: 3, texture: tile_innerTown.getCell(10, 6, 1, 2))
        addItem(x: 9, line: 4, item: HotelHouseDoor())
        addSingleCellItem(x: 10, line: 3, texture: tile_innerTown.getCell(10, 6, 1, 2))
        addItem(x: 12, line: 4, item: HotelHouseDoor())
        addSingleCellItem(x: 13, line: 3, texture: tile_innerTown.getCell(10, 6, 1, 2))
        //        addItem(x: 9, line: 4, item: HotelHouseDoor())
        //        addItem(x: 12, line: 4, item: HotelHouseDoor())
        
//        let ia5 = Data.instance.inside_a5
        
//        addSingleCellItem(x: 1, line: 3, texture: ia5.getCell(0, 8, 0.5, 1))
//        addSingleCellItem(x: 1.5, line: 3, texture: ia5.getCell(2.5, 8, 0.5, 1))
//        addSingleCellItem(x: 1, line: 2, texture: ia5.getCell(0, 8, 0.5, 1))
//        addSingleCellItem(x: 1.5, line: 2, texture: ia5.getCell(2.5, 8, 0.5, 1))
//        addSingleCellItem(x: 1, line: 4, texture: ia5.getCell(0, 8, 0.5, 1))
//        addSingleCellItem(x: 1.5, line: 4, texture: ia5.getCell(2.5, 8, 0.5, 1))
        
        //        let ia5 = Data.instance.inside_a5
        //        addSingleCellItem(x: 1, line: 4, texture: Data.instance.tilee_outsidetown.getCell(1, 14, 1, 2))
        
        
    }
    
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
//            if 0 == pos {
//                let scene = UnionsThirdFloor()
//                stage.switchScene(next: scene, afterCreation: {
//                    scene.setPos(pos: 1)
//                    stage._char.faceNorth()
//                })
//                return
//            }
//            if 3 == pos {
//                let scene = KnightsRoom()
//                stage.switchScene(next: scene, afterCreation: {
//                    scene.setPos(pos: 3)
//                    stage._char.faceNorth()
//                })
//                return
//            }
//            if 6 == pos {
//                let scene = MagesRoom()
//                stage.switchScene(next: scene, afterCreation: {
//                    scene.setPos(pos: 3)
//                    stage._char.faceNorth()
//                })
//                return
//            }
            if 9 == pos {
                let scene = BurglarsRoom()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 3)
                    stage._char.faceNorth()
                })
                return
            }
            if 12 == pos {
                let scene = MonksRoom()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 3)
                    stage._char.faceNorth()
                })
                return
            }
        } else {
            if 1 == pos {
                let west = UnionsSecondFloor()
                stage.switchScene(next: west, afterCreation: {
                    west.setPos(pos: 1)
                    stage._char.faceSouth()
                })
            }
        }
    }
}
class HotelHouseDoor:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.tilee_outsidetown.getCell(1, 14, 1, 1.25)
//        let node = SKSpriteNode(texture: Data.instance.outside_b.getCell(7, 1))
//        node.position.y = -36
//        node.anchorPoint = CGPoint(x: 0.5, y: 0)
//        addChild(node)
//        node.zPosition = UIStage.UILAYER + 3
//        rn.position.y = 12
//        rn.fontSize = 16
//        rn.align = "left"
//        setTexture(item)
        let node = SKSpriteNode(texture: item)
        node.size = CGSize(width: cellSize, height: cellSize * 1.5)
        node.anchorPoint = CGPoint(x: 0, y: 1)
        node.position.y = -cellSize * 0.5
        addChild(node)
//        self.size = CGSize(width: cellSize, height: cellSize * 2)
        _xSize = 1
        _ySize = 2
    }
    private var rn = Label()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setRoomNumber(rn:Int) -> UIItem {
        return self
    }
    
//    init(rn:Int) {
////        self.init(texture: nil, color: UIColor.white, size: nil)
//    }
}
class SingleRoom:UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.inside_a4
        _groundSets = GroundSets(ground: oa4.getCell(0, 7, 2, 2), wall: oa4.getCell(0, 9, 2, 2))
        _name = "客房"
        _groundSize = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 7
        hasInitialized = true
        
        createGround(start: 0, end: xSize.toInt())
        createTopWall()
        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
        addSingleCellItem(x: 4, line: 1.95, texture: shadow)
        
        let inside_b = Data.instance.inside_b
        let inside_c = Data.instance.inside_c
        addSingleCellItem(x: 6, line: 3.5, texture: inside_b.getCell(0, 11, 1, 2))
        addSingleCellItem(x: 5, line: 3.5, texture: inside_c.getCell(2, 11, 1, 1))
        addSingleCellItem(x: 0, line: 4, texture: inside_b.getCell(2, 7, 2, 2))
        addSingleCellItem(x: 0, line: 4, texture: inside_b.getCell(2, 7, 2, 2))
        addSingleCellItem(x: 2.5, line: 5, texture: inside_b.getCell(12, 4, 2, 1))
        
        let to = Data.instance.tilee_outsidetown
        addSingleCellItem(x: 2, line: 3, texture: to.getCell(6, 8, 2, 2))
        
        //        let ia5 = Data.instance.inside_a5
        //        addSingleCellItem(x: 1, line: 4, texture: Data.instance.tilee_outsidetown.getCell(1, 14, 1, 2))
        
        
    }
}

class KnightsRoom:SingleRoom {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        super.create()
        addSingleCellItem(x: 4, line: 2.25, texture: Data.instance.pictureCollabo8_1.getCell(7, 0), z:UIStage.LAYER2 + 2)
//        addItem(x: 5, line: 2, item: KnightMaster())
    }
    
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
            if 4 == pos {
                let node = KnightMaster()
                node.showInfoDialog()
            }
        } else {
            if 3 == pos {
                let scene = UnionsSecondFloor()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 3)
                    stage._char.faceSouth()
                })
            }
        }
    }
    
}
class MagesRoom:SingleRoom {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        super.create()
        addSingleCellItem(x: 4, line: 2.25, texture: Data.instance.pictureAll2.getCell(7, 4), z:UIStage.LAYER2 + 2)
        addItem(x: 5, line: 2.75, item: Apprentice(), z:UIStage.LAYER2 + 2)
        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
        addSingleCellItem(x: 5, line: 2.45, texture: shadow)
    }
    
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
            if 5 == pos {
                let node = getItemByName(name: "item5\(Int(2.45))")
                node.speak(text: "跟随我的导师！")
                return
            }
            if 4 == pos {
                let node = ArchMage()
                node.showInfoDialog()
            }
        } else {
            if 3 == pos {
                let scene = UnionsSecondFloor()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 6)
                    stage._char.faceSouth()
                })
            }
        }
    }
    
}
class BishopsRoom:SingleRoom {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        super.create()
        addSingleCellItem(x: 4, line: 2.25, texture: Data.instance.picturePeople2.getCell(7, 0), z:UIStage.LAYER2 + 2)
        //        addItem(x: 5, line: 2, item: KnightMaster())
    }
    
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
            if 4 == pos {
                let node = ArchBishop()
                node.showInfoDialog()
            }
        } else {
            if 3 == pos {
                let scene = UnionsSecondFloor()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 9)
                    stage._char.faceSouth()
                })
            }
        }
    }
    
}

class SealersRoom:SingleRoom {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        super.create()
        addSingleCellItem(x: 4, line: 2.25, texture: Data.instance.pictureAll.getCell(4, 4), z:UIStage.LAYER2 + 2)
        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
        addSingleCellItem(x: 5, line: 1.95, texture: shadow)
//        addSingleCellItem(x: 5, line: 2.25, texture: Data.instance.pictureNature.getCell(1, 0), z:UIStage.LAYER2 + 2)
        addItem(x: 5, line: 2.25, item: BigHuang(), z:UIStage.LAYER2 + 2)
    }
    
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
            if 4 == pos {
                let node = SealMaster()
                node.showInfoDialog()
                return
            }
            if 5 == pos {
                let node = getItemByName(name: "item52") as! BigHuang
                node.speak(text: "汪～汪～！")
            }
        } else {
            if 3 == pos {
                let scene = UnionsSecondFloor()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 12)
                    stage._char.faceSouth()
                })
            }
        }
    }
}
class BigHuang:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let shadow = SKSpriteNode(texture: SKTexture(imageNamed: "select.png").getCell(3, 0))
//        shadow.position.y = -cellSize * 0.25
//        addChild(shadow)
//        let inode = SKSpriteNode(texture: Data.instance.pictureNature.getCell(1, 0))
//        addChild(inode)
//        inode.position.x = cellSize * 0.5
//        shadow.position.x = inode.position.x
        setTexture(Data.instance.pictureNature.getCell(1, 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BurglarsRoom:SingleRoom {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        super.create()
        addSingleCellItem(x: 4, line: 2.25, texture: Data.instance.pictureActor1.getCell(1, 4), z:UIStage.LAYER2 + 2)
//        addSingleCellItem(x: 4, line: 2.25, texture: Data.instance.pictureAll.getCell(4, 4), z:UIStage.LAYER2 + 2)
//        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
//        addSingleCellItem(x: 1, line: 1.95, texture: shadow)
//        //        addSingleCellItem(x: 5, line: 2.25, texture: Data.instance.pictureNature.getCell(1, 0), z:UIStage.LAYER2 + 2)
//        addItem(x: 5, line: 2.25, item: BigHuang(), z:UIStage.LAYER2 + 2)
    }
    
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
            if 4 == pos {
                let node = TheBurglar()
                node.showInfoDialog()
                return
            }
        } else {
            if 3 == pos {
                let scene = UnionsThirdFloor()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 9)
                    stage._char.faceSouth()
                })
            }
        }
    }
}
class MonksRoom:SingleRoom {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        super.create()
        addSingleCellItem(x: 4, line: 2.25, texture: Data.instance.pictureAll.getCell(4, 0), z:UIStage.LAYER2 + 2)
        //        addSingleCellItem(x: 4, line: 2.25, texture: Data.instance.pictureAll.getCell(4, 4), z:UIStage.LAYER2 + 2)
//        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
//        addSingleCellItem(x: 5, line: 1.95, texture: shadow)
        //        //        addSingleCellItem(x: 5, line: 2.25, texture: Data.instance.pictureNature.getCell(1, 0), z:UIStage.LAYER2 + 2)
        //        addItem(x: 5, line: 2.25, item: BigHuang(), z:UIStage.LAYER2 + 2)
    }
    
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        if stage.isUpperPoint {
            if 4 == pos {
                let node = MonkMaster()
                node.showInfoDialog()
                return
            }
        } else {
            if 3 == pos {
                let scene = UnionsThirdFloor()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 12)
                    stage._char.faceSouth()
                })
            }
        }
    }
}
class Apprentice:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.picturePeople1.getCell(10, 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
