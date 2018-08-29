//
//  InnInside.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/6/24.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class InnInside: UIScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.inside_a4
        _groundSets = GroundSets(ground: oa4.getCell(0, 7, 2, 2), wall: oa4.getCell(0, 9, 2, 2))
        _name = "酒馆"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 21
        hasInitialized = true
        createGround(start: 0, end: xSize.toInt())
        createTopWall()
        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
        //
        //         addSingleCellItem(x: 3, line: 2.15, texture: shadow)
        //
        //         addSingleCellItem(x: 5, line: 2.65, texture: shadow)
        //         addSingleCellItem(x: 6, line: 2.65, texture: shadow)
        //         addSingleCellItem(x: 7, line: 2.65, texture: shadow)
        //         addSingleCellItem(x: 7, line: 1.65, texture: shadow)
        
        
        addSingleCellItem(x: 8, line: 2.5, texture: shadow)
        addSingleCellItem(x: 8, line: 2.75, texture: SKTexture(imageNamed:"11000001.png").getCell(1, 0), z: UIStage.LAYER2 + 1)
        addSingleCellItem(x: 11, line: 2.75, texture: Data.instance.pictureBaldo.getCell(10, 0), z: UIStage.LAYER2 - 1)
        addSingleCellItem(x: 13, line: 2.75, texture: Data.instance.pictureEvil.getCell(1, 0), z: UIStage.LAYER2 - 1)
        addSingleCellItem(x: 16, line: 2.75, texture: Data.instance.pictureEvil.getCell(7, 0), z: UIStage.LAYER2 - 1)
        addSingleCellItem(x: 19, line: 2.75, texture: Data.instance.pictureEvil.getCell(10, 4), z: UIStage.LAYER2 - 1)
        
        let inside_c = Data.instance.inside_c
        let inside_b = Data.instance.inside_b
        let ti = Data.instance.tile_innerTown
        addSingleCellItem(x: 5, line: 4.5, texture: inside_b.getCell(8, 1, 3, 2))
        addSingleCellItem(x: 2, line: 5, texture: inside_b.getCell(12, 4, 2, 1))
        addSingleCellItem(x: 8, line: 5, texture: inside_b.getCell(14, 4, 2, 1))
        addSingleCellItem(x: 10, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 11, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 12, line: 5, texture: inside_b.getCell(9, 3, 1, 2))
        addSingleCellItem(x: 13, line: 5, texture: inside_b.getCell(12, 5, 1, 1))
        addSingleCellItem(x: 16, line: 5, texture: inside_b.getCell(13, 5, 1, 1))
        addSingleCellItem(x: 19, line: 5, texture: inside_b.getCell(14, 5, 1, 1))
        addSingleCellItem(x: 0, line: 4, texture: inside_b.getCell(5, 13, 3, 2))
        addSingleCellItem(x: 3, line: 4, texture: ti.getCell(8, 6, 1, 2))
        addSingleCellItem(x: 4, line: 4, texture: ti.getCell(9, 6, 1, 2))
        addSingleCellItem(x: 5, line: 2.5, texture: inside_b.getCell(1, 13))
        addSingleCellItem(x: 7, line: 2.5, texture: inside_b.getCell(1, 13))
        addSingleCellItem(x: 1, line: 2, texture: inside_b.getCell(2, 13))
        addSingleCellItem(x: 8, line: 4, texture: ti.getCell(10, 6, 1, 2))
        addSingleCellItem(x: 9, line: 4, texture: ti.getCell(11, 6, 1, 2))
//        addSingleCellItem(x: 9, line: 3, texture: ti.getCell(11, 6, 1, 2))
        addSingleCellItem(x: 10, line: 2.5, texture: ti.getCell(8, 8, 6, 2), z: UIStage.LAYER2 + 1)
//        addSingleCellItem(x: 16, line: 2, texture: inside_b.getCell(3, 13, 1, 1))
        addSingleCellItem(x: 16, line: 2.5, texture: ti.getCell(9, 8, 5, 2), z: UIStage.LAYER2 + 1)
        setPos(pos: 6)
        
    }
  
    override func firstCellEvent() {
    }
    override func lastCellEvent() {
    }
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        let char = Data.instance._char!
        let this = self
        if stage.isUpperPoint {
            if 1 == pos {
                stage._char.speak(text: "吧啦～吧啦～")
                return
            }
            if 8 == pos && !stage._dialogExist {
                let img = SKTexture(imageNamed: "11000001.png").getCell(1, 0)
                let c = stage.showDialog(img: img, text: "你好，冒险者。", name: "金刚级冒险者莫莫伊")
                if char._event.contains(3) {
                    return
                }
                c.addNextButton()
                c._nextAction = {
                    c.text = "这是见面礼，祝你好运！"
                    c._nextAction = {
                        showMsg(text: "你获得了[治疗药水]x5。")
                        let p = Potion()
                        p._count = 5
                        char.addProp(p: p)
                        c.remove()
                        char._event.append(3)
                        stage._char.speak(text: "谢谢你～～")
                    }
                }
            } else if 11 == pos && !stage._dialogExist {
                let img = Data.instance.pictureBaldo.getCell(10, 0)
                let dlg = stage.showDialog(img: img, text: "欢迎！战斗中，属性是最基础的战斗数值，比如攻击，防御，精神。是否需要详细的了解一下属性说明？", name: "哥布林讨伐者洛肯")
                dlg.addConfirmButton()
                dlg._confirmAction = {
                    dlg.remove()
                    let pep = PropertiesExplainPanel()
                    pep.create()
                    Data.instance.stage.addPanelDefault(p: pep)
                }
            } else if 13 == pos && !stage._dialogExist {
                let img = Data.instance.pictureEvil.getCell(1, 0)
                let dlg = stage.showDialog(img: img, text: "你好，旅行者。装备是一个人战斗力的体现，我这里有详细的装备介绍，你是否需要了解一下？", name: "匕首协会首领施普恩")
                dlg.addConfirmButton()
                dlg._confirmAction = {
                    dlg.remove()
                    let pep = OutfitExplainPanel()
                    pep.create()
                    Data.instance.stage.addPanelDefault(p: pep)
                }
            } else if 16 == pos && !stage._dialogExist {
                let img = Data.instance.pictureEvil.getCell(7, 0)
                let dlg = stage.showDialog(img: img, text: "愿主神守护着你，冒险者。这个世界之所以存在，是依赖于诸神在创世之初所创造的魔法秩序，主神眷顾子民，将创世秩序刻蚀在一张张卷轴中，流传后世，这就是我们世界中法术的来源。", name: "主教萨拉瓦拉")
                dlg.addConfirmButton()
                dlg._confirmAction = {
                    dlg.remove()
                    let pep = SpellExplainPanel()
                    pep.create()
                    Data.instance.stage.addPanelDefault(p: pep)
                }
            } else if 19 == pos && !stage._dialogExist {
                let img = Data.instance.pictureEvil.getCell(10, 4)
                let dlg = stage.showDialog(img: img, text: "南无。。。", name: "阿三")
                
            }
        } else {
            if 6 == pos {
                let scene = WestOfNewComersVillage()
                stage.switchScene(next: scene, afterCreation: {
                    scene.setPos(pos: 5)
                    stage._char.faceSouth()
                })
            }
        }
    }
}
class PropertiesExplainPanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first
        let touchPoint = first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Data.instance.stage.removePanelDefault(p: self)
            return
        }
        
        if _nextButton.contains(touchPoint!) {
            if _curPage == 4 {
                return
            }
            
            _curPage += 1
            showPage()
            return
        }
        
        if _prevButton.contains(touchPoint!) {
            if _curPage == 1 {
                return
            }
            
            _curPage -= 1
            showPage()
            return
        }
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        addChild(_page1)
        addChild(_page2)
        addChild(_page3)
        addChild(_page4)
        _page2.isHidden = true
        _page3.isHidden = true
        _page4.isHidden = true
        //        let startX = -cellSize * 5
        let gap:CGFloat = 26
        //        let west = Label()
        //        west.fontSize = 16
        //        west.position.x = -cellSize * 5
        //        west.position.y = cellSize * 2
        //        west.align = "left"
        //        west.text = "西："
        //        west.zPosition = _bg.zPosition + 1
        //        addChild(west)
        var next = createLabel(y: cellSize * 2, text: "主属性：")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "耐力：影响攻击、防御、精神（减少）、生命")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "力量：影响攻击、速度、命中、必杀、精神（减少）、生命")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "敏捷：影响攻击、防御、速度、命中、闪避、必杀、生命")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "智力：影响攻击（减少）、防御、速度、闪避、精神、生命")
        _page1.addChild(next)
        
        next = createLabel(y: cellSize * 2, text: "副属性：")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "攻击：影响物理伤害")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "防御：抵挡物理伤害")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "速度：影响行动顺序")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "精神：影响法术伤害和抵挡法术伤害")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "必杀：影响物理攻击暴击几率")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "闪避：影响近战攻击闪避几率")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "命中：影响物理攻击命中几率")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "生命：影响生命上限")
        _page2.addChild(next)
        
        next = createLabel(y: cellSize * 2, text: "扩展属性：")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "幸运：影响道具掉落几率")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "念力：影响特效命中几率")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "破甲：影响防御")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "复仇：影响闪避后反击几率")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "律动：影响行动后立即再次行动几率")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "抗混乱：抵抗行动顺序混乱的几率")
        _page3.addChild(next)
        
        next = createLabel(y: cellSize * 2, text: "元素属性：")
        _page4.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "火焰伤害：影响物理和魔法的火焰元素伤害")
        _page4.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "雷电伤害：影响物理和魔法的雷电元素伤害")
        _page4.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "冰冷伤害：影响物理和魔法的冰冷元素伤害")
        _page4.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "火焰抗性：降低物理和魔法的火焰元素伤害")
        _page4.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "雷电抗性：降低物理和魔法的泪点元素伤害")
        _page4.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "冰冷抗性：降低物理和魔法的冰冷元素伤害")
        _page4.addChild(next)
        
//        next = createLabel(y: next.position.y - gap, text: "北：")
//        next = createLabel(y: next.position.y - gap, text: "杂货店，武器店，礼品屋")
//        next = createLabel(y: next.position.y - gap, text: "东北：")
//        next = createLabel(y: next.position.y - gap, text: "枯萎小径：四方阵、十二魔宫")
        
        //        let westBlock = Label()
        //        westBlock.position.x = startX
        //        westBlock.position.y = west.position.y + gap
        //        westBlock.align = "left"
        //        westBlock.text = "酒馆，饲养师之家，冒险者工会"
        //        westBlock.zPosition = self.zPosition + 1
        //        addChild(westBlock)
    }
    
    private func createLabel(y:CGFloat, text:String) -> Label {
        let l = Label()
        l.position.x = -cellSize * 5
        l.position.y = y
        l.fontSize = 18
        l.text = text
        l.align = "left"
        l.zPosition = _bg.zPosition + 1
//        addChild(l)
        
        return l
    }
    
    private func showPage() {
        _page1.isHidden = true
        _page2.isHidden = true
        _page3.isHidden = true
        _page4.isHidden = true
        
        if _curPage == 1 {
            _page1.isHidden = false
        } else if _curPage == 2 {
            _page2.isHidden = false
        } else if _curPage == 3 {
            _page3.isHidden = false
        } else if _curPage == 4 {
            _page4.isHidden = false
        }
    }
    
    private var _page1 = SKSpriteNode()
    private var _page2 = SKSpriteNode()
    private var _page3 = SKSpriteNode()
    private var _page4 = SKSpriteNode()
    
    private var _curPage = 1
}

class OutfitExplainPanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first
        let touchPoint = first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Data.instance.stage.removePanelDefault(p: self)
            return
        }
        
        if _nextButton.contains(touchPoint!) {
            if _curPage == 2 {
                return
            }
            
            _curPage += 1
            showPage()
            return
        }
        
        if _prevButton.contains(touchPoint!) {
            if _curPage == 1 {
                return
            }
            
            _curPage -= 1
            showPage()
            return
        }
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        addChild(_page1)
        addChild(_page2)
        addChild(_page3)
        addChild(_page4)
        _page2.isHidden = true
        _page3.isHidden = true
        _page4.isHidden = true
        //        let startX = -cellSize * 5
        let gap:CGFloat = 26
        //        let west = Label()
        //        west.fontSize = 16
        //        west.position.x = -cellSize * 5
        //        west.position.y = cellSize * 2
        //        west.align = "left"
        //        west.text = "西："
        //        west.zPosition = _bg.zPosition + 1
        //        addChild(west)
        var next = createLabel(y: cellSize * 2, text: "武器：")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "剑：近战，提供速度加成，攻速较快")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "法杖：远程。提供精神加成，攻速较慢")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "匕首：近战，提供闪避加成，攻速很快")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "钝器：近战，提供必杀加成，攻速较慢")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "拳套：近战，提供破甲加成，攻速较快")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "法器：无普通攻击，提供精神加成和一栏法术")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "弓：远程，提供敏捷加成，攻速较快")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "PS：武器攻速影响行动顺序")
        _page1.addChild(next)
        
        next = createLabel(y: cellSize * 2, text: "装备：")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "护身符：提供生命加成，可以佩戴一枚")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "戒指：可以佩戴一对")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "魔印：提供一栏法术，可以刻印一枚")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "盾牌：提供防御加成，可以装备一块")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "耳环：可以佩戴一只")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "灵魂石：提供种族属性，可以携带一块")
        _page2.addChild(next)

        
     
        
        //        next = createLabel(y: next.position.y - gap, text: "北：")
        //        next = createLabel(y: next.position.y - gap, text: "杂货店，武器店，礼品屋")
        //        next = createLabel(y: next.position.y - gap, text: "东北：")
        //        next = createLabel(y: next.position.y - gap, text: "枯萎小径：四方阵、十二魔宫")
        
        //        let westBlock = Label()
        //        westBlock.position.x = startX
        //        westBlock.position.y = west.position.y + gap
        //        westBlock.align = "left"
        //        westBlock.text = "酒馆，饲养师之家，冒险者工会"
        //        westBlock.zPosition = self.zPosition + 1
        //        addChild(westBlock)
    }
    
    private func createLabel(y:CGFloat, text:String) -> Label {
        let l = Label()
        l.position.x = -cellSize * 5
        l.position.y = y
        l.fontSize = 18
        l.text = text
        l.align = "left"
        l.zPosition = _bg.zPosition + 1
        //        addChild(l)
        
        return l
    }
    
    private func showPage() {
        _page1.isHidden = true
        _page2.isHidden = true
        _page3.isHidden = true
        _page4.isHidden = true
        
        if _curPage == 1 {
            _page1.isHidden = false
        } else if _curPage == 2 {
            _page2.isHidden = false
        } else if _curPage == 3 {
            _page3.isHidden = false
        } else if _curPage == 4 {
            _page4.isHidden = false
        }
    }
    
    private var _page1 = SKSpriteNode()
    private var _page2 = SKSpriteNode()
    private var _page3 = SKSpriteNode()
    private var _page4 = SKSpriteNode()
    
    private var _curPage = 1
}
class SpellExplainPanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first
        let touchPoint = first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Data.instance.stage.removePanelDefault(p: self)
            return
        }
        
        if _nextButton.contains(touchPoint!) {
            if _curPage == 3 {
                return
            }
            
            _curPage += 1
            showPage()
            return
        }
        
        if _prevButton.contains(touchPoint!) {
            if _curPage == 1 {
                return
            }
            
            _curPage -= 1
            showPage()
            return
        }
        
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        addChild(_page1)
        addChild(_page2)
        addChild(_page3)
        addChild(_page4)
        _page2.isHidden = true
        _page3.isHidden = true
        _page4.isHidden = true
        //        let startX = -cellSize * 5
        let gap:CGFloat = 26
        //        let west = Label()
        //        west.fontSize = 16
        //        west.position.x = -cellSize * 5
        //        west.position.y = cellSize * 2
        //        west.align = "left"
        //        west.text = "西："
        //        west.zPosition = _bg.zPosition + 1
        //        addChild(west)
        var next = createLabel(y: cellSize * 2, text: "按法术类型：")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "主动法术：有冷却时间限制，需要主动施放的法术")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "被动法术：影响携带者的法术，无需使用，自动生效")
        _page1.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "光环法术：影响一方全体单位的被动法术")
        _page1.addChild(next)
        
        next = createLabel(y: cellSize * 2, text: "按法术效果：")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "攻击性法术：造成物理魔法或者元素伤害的")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "状态类法术：对己方单位或目标释放提供某种状态")
        _page2.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "恢复类法术：恢复状态或者生命")
        _page2.addChild(next)
        
        next = createLabel(y: cellSize * 2, text: "按法术等级：")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "低级法术：法术种类众多，易于创造，易于使用，白色标识")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "特定法术：一般是由著名法师创造，流传民间，绿色标识")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "高阶法术：具有特殊种族血统的高阶大魔法师创造，一般人")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "无缘得见，蓝色标识")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "神之技：创世之时就已经存在的法术，一般只有远古法师或")
        _page3.addChild(next)
        next = createLabel(y: next.position.y - gap, text: "者是龙族使用，红色标识")
        _page3.addChild(next)
        
        
        //        next = createLabel(y: next.position.y - gap, text: "北：")
        //        next = createLabel(y: next.position.y - gap, text: "杂货店，武器店，礼品屋")
        //        next = createLabel(y: next.position.y - gap, text: "东北：")
        //        next = createLabel(y: next.position.y - gap, text: "枯萎小径：四方阵、十二魔宫")
        
        //        let westBlock = Label()
        //        westBlock.position.x = startX
        //        westBlock.position.y = west.position.y + gap
        //        westBlock.align = "left"
        //        westBlock.text = "酒馆，饲养师之家，冒险者工会"
        //        westBlock.zPosition = self.zPosition + 1
        //        addChild(westBlock)
    }
    
    private func createLabel(y:CGFloat, text:String) -> Label {
        let l = Label()
        l.position.x = -cellSize * 5
        l.position.y = y
        l.fontSize = 18
        l.text = text
        l.align = "left"
        l.zPosition = _bg.zPosition + 1
        //        addChild(l)
        
        return l
    }
    
    private func showPage() {
        _page1.isHidden = true
        _page2.isHidden = true
        _page3.isHidden = true
        _page4.isHidden = true
        
        if _curPage == 1 {
            _page1.isHidden = false
        } else if _curPage == 2 {
            _page2.isHidden = false
        } else if _curPage == 3 {
            _page3.isHidden = false
        } else if _curPage == 4 {
            _page4.isHidden = false
        }
    }
    
    private var _page1 = SKSpriteNode()
    private var _page2 = SKSpriteNode()
    private var _page3 = SKSpriteNode()
    private var _page4 = SKSpriteNode()
    
    private var _curPage = 1
}
