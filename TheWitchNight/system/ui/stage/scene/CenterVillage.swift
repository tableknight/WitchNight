//
//  CenterVillage.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class CenterVillage: UIScene {
    static var VILLAGE_NAME = "贝拉姆村"
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.dungeon_a4
//        _groundSets = GroundSets(ground: oa4.getCell(8, 12, 2, 2), wall: oa4.getCell(8, 14, 2, 2))
        _groundSets = GroundSets(ground: oa4.getCell(0, 2, 2, 2), wall: oa4.getCell(0, 4, 2, 2))
        _name = CenterVillage.VILLAGE_NAME
//        _speaking = [
//            "",
//        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        xSize = 23
        hasInitialized = true
        let shadow = SKTexture(imageNamed: "select.png").getCell(3, 0)
        
        addSingleCellItem(x: 6, line: 2.05, texture: shadow, z: UIStage.LAYER2)
        addSingleCellItem(x: 14, line: 2.25, texture: shadow, z: UIStage.LAYER2)
        
        createGround(start: 0, end: xSize.toInt())
        let ob = Data.instance.outside_b
        addSingleCellItem(x: 0, line: 2, texture: Data.instance.outside_b.getCell(8, 7))
//        addSingleCellItem(x: 0, line: 3, texture: Data.instance.outside_b.getCell(8, 7))
//        addSingleCellItem(x: 1, line: 2, texture: Data.instance.outside_b.getCell(8, 7))
        addItem(x: 1, item: DoubleTrees())
        addItem(x: 2, item: TallTree())
//        addSingleCellItem(x: 6, line: 4, texture: Data.instance.outside_b.getCell(5, 12, 1, 2))
//        addSingleCellItem(x: 7, line: 4, texture: Data.instance.outside_b.getCell(5, 12, 1, 2))
        addSingleCellItem(x: 3, line: 3.5, texture: Data.instance.outside_c.getCell(2, 7, 3, 2))
        addSingleCellItem(x: 6, line: 2.35, texture: Data.instance.pictureActor3.getCell(7, 4), z: UIStage.LAYER2 + 2)
        addSingleCellItem(x: 6, line: 4, texture: ob.getCell(5, 12, 1, 2))
        addItem(x: 7, item: DoubleTrees())
        addItem(x: 8, item: FlowerRoad())
        addItem(x: 9, item: DoubleTrees())
        addSingleCellItem(x: 10, line: 2.25, texture: ob.getCell(1, 9, 1, 1))
        addSingleCellItem(x: 11, line: 3.25, texture: Data.instance.sf_outside_c.getCell(0, 3, 3, 2))
        let vh = VillageHead()
//        vh.name = "pos14"
        vh.speak(text: "咳。咳。。！", autoRemove: false)
        addItem(x: 14, line: 2.5, item: vh, z: UIStage.LAYER2 + 2)
//        addSingleCellItem(x: 14, line: 2.5, texture: Data.instance.picturePeople1.getCell(7, 4), z: UIStage.LAYER2 + 1)
        addSingleCellItem(x: 14, line: 3, texture: Data.instance.sf_outside_c.getCell(3, 2, 2, 1))
        addSingleCellItem(x: 16, line: 4.25, texture: ob.getCell(11, 12, 1, 3))
//        addSingleCellItem(x: 16, line: 4, texture: ob.getCell(5, 12, 1, 2))
        addItem(x: 17, item: MudRoad())
        addItem(x: 18, item: VillageTrees())
        addSingleCellItem(x: 21, line: 2.25, texture: ob.getCell(5, 9))
//        addSingleCellItem(x: 21, line: 2.5, texture: ob.getCell(7, 12))
        
        
//        addItem(x: 5, item: DungeonPortal())
//        addItem(x: 10, item: DoubleTrees())
//        addItem(x: 11, item: TallTree())
        //        addSingleCellItem(x: 29, line: 1, texture: ob.getCell(14, 10))
//        addSingleCellItem(x: 12, line: 2, texture: Data.instance.fullHouse.getCell(11, 9))
//        addSingleCellItem(x: 12, line: 4, texture: Data.instance.outside_b.getCell(5, 12, 1, 2))
//        addItem(x: 13, item: Spring())
//        addItem(x: 16, item: VillageHead())
//        addSingleCellItem(x: 18, line: 3, texture: Data.instance.outside_b.getCell(5, 12, 1, 2))
//
////        addSingleCellItem(x: 16, line: 3, texture: Data.instance.fullHouse.getCell(7, 13))
//
////        addItem(x: 19, item: DoubleTrees())
////        addItem(x: 21, item: TallTree())
//        addItem(x: 23, item: DoubleTrees())
////        addItem(x: 23, item: Stump())
        addSingleCellItem(x: 0, line: 1.1, texture: ob.getCell(15, 10))
        addSingleCellItem(x: xSize - 1, line: 1.1, texture: ob.getCell(14, 10))
//        _curX = 6
        
 
//        _ground = SKSpriteNode(imageNamed: "centerOfVillage.png")
//        _ground.size = CGSize(width: xSize * cellSize, height: 6 * cellSize)
//        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
//        _ground.position.x = -cellSize * 0.5
//        _ground.position.y = cellSize
//        _ground.zPosition = UIStage.LAYER1
//        addChild(_ground)
        
        setPos(pos: 12)
        
        
    }

    override func firstCellEvent() {
        let wv = WestOfNewComersVillage()
//        wv.create()
        Data.instance.stage.switchScene(next: wv)
    }
    override func lastCellEvent() {
        let ev = EastOfNewComersVillage()
//        ev.create()
        Data.instance.stage.switchScene(next: ev)
    }
    private var panelExist = false
    override func triggerEvent(pos: Int) {
        let stage = Data.instance.stage!
        let char = Data.instance._char!
        if !stage.isUpperPoint {
            return
        }
        if 21 == pos {
            stage._char.speak(text: "什么也没有～～")
            return
        }
        if 4 == pos {
            if panelExist {
                return
            }
            stage._char.speak(text: "嘛尼嘛尼哄，芝麻开门～～")
            panelExist = true
//            let item = SKSpriteNode(texture: Data.instance.outside_c.getCell(5, 7, 3, 2))
            let item = setItem(x: 3, line: 3.5, texture: Data.instance.outside_c.getCell(5, 7, 3, 2))
            item.alpha = 0
//            item.position.y = cellSize * 2
            item.zPosition = UIStage.LAYER2 + 1
            let fin = SKAction.fadeIn(withDuration: TimeInterval(0.5))
            let fout = SKAction.fadeOut(withDuration: TimeInterval(0.5))
            let q = SKAction.sequence([fin, fout])
            let this = self
            item.run(q) {
                stage._char.removeSpeak()
                this.panelExist = false
                item.removeFromParent()
                let dlp = DungeonListPanel()
                dlp.create()
                Data.instance.stage.addPanelDefault(p: dlp)
            }
        } else if 6 == pos {
            stage.showDialog(img: Data.instance.pictureActor3.getCell(7, 4),
                             text: "你好，这是远古石碑，是前往无尽深渊的唯一入口！触摸石碑的中心，与石碑产生共鸣。",
                             name: "神官苏维亚")
        } else if 10 == pos {
            showRoadMessage()
        } else if 12 == pos {
            
            char._extensions.hp = char._extensions.health
            for m in char._minions {
                m._extensions.hp = m._extensions.health
            }
            
 
            stage._char.actionHealed {
                showMsg(text: "生命状态已恢复！")
                stage.reloadCharUI()
            }
        } else if 14 == pos && !stage._dialogExist {
            getItemByName(name: "item142").removeSpeak()
            if char._name != "冒险者" || char._level > 10 {
                let text = "嗨，你好啊，\(char._name)！"
                stage.showDialog(img: Data.instance.picturePeople1.getCell(7, 4), text: text, name: "村长维拉")
                return
            }
            let text = "嚯！新的冒险者，欢迎来到\(CenterVillage.VILLAGE_NAME)，我是村长，还没有决定做什么事情呢吧，总之，你可以先去村子西边的冒险者工会去看看。"
            let dlg = stage.showDialog(img: Data.instance.picturePeople1.getCell(7, 4), text: text, name: "村长维拉奇")
            
            if Data.instance._char._event.contains(1) {
                return
            }
            
            dlg.addNextButton()
            dlg._nextAction = {
                dlg.text = "哦，对了，对了，这里是几个[传送卷轴]，拿去用吧，不管是在野外，还是身处战斗中，都可以使用[传送卷轴]安全的回到村子哦。"
                dlg._nextAction = {
                    let ts = TownScroll()
                    ts._count = 5
                    Data.instance._char.addProp(p: ts)
                    showMsg(text: "你获得了[传送卷轴]x5。")
                    Data.instance._char._event.append(1)
//                    dlg.remove()
                    dlg.text = "去找下旅店的药剂师莫莫伊吧，他会送给每一位新人礼物的。别忘了还有宠物之家的封印大师艾里。"
                    dlg._nextAction = {
                        dlg.remove()
                        stage._char.speak(text: "谢谢～～")
                    }
                }
            }
        } else if 8 == pos {
            let scene = NorthOfNewComersVillage()
            stage.switchScene(next: scene, afterCreation: {
                stage._char.faceNorth()
                scene.setPos(pos: 13)
            })
        } else if 17 == pos {
            let scene = WitheredLane()
            stage.switchScene(next: scene, afterCreation: {
                stage._char.faceNorth()
                scene.setPos(pos: 11)
            })
        }
    }
    override func stopedPointEvent(pos: Int) {
        let stage = Data.instance.stage!
        if seed() > 50 {
            return
        }
        let this = self
        if 4 == pos {
            setTimeout(delay: 1, completion: {
                if this.getCurX().toInt() == pos {
                    stage._char.faceNorth()
                    stage._char.speak(text: "就是从这里去传说中的远古神殿啊！")
                }
            })
            return
        }
        if pos == 14 {
            setTimeout(delay: 1, completion: {
                if this.getCurX().toInt() == pos {
                    stage._char.faceNorth()
                    stage._char.speak(text: "村长大爷好！")
                }
            })
            return
        }
    }
    private func showRoadMessage() {
        let rmp = RoadMessagePanel()
        rmp.create()
        Data.instance.stage.addPanelDefault(p: rmp)
    }
//    func createDungeonList() {
//        let b = UIScreen.main.bounds
//        let bg = SKShapeNode(rect: b)
//        bg.fillColor = UIColor.black
//        let label = Label()
//        label.fontColor = UIColor.white
//        label.text = "Dungeon Level 1"
//        label.setPos(0, 0)
//        addChild(bg)
//        zPosition = UIStage.LAYER5
//    }

}

class Spring:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let n = Data.instance.sf_outside_c.getCell(0, 3, 3, 2)
        setTexture(n)
        _xSize = 3
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class DungeonPortal:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let n = Data.instance.outside_c.getCell(2, 7, 3, 2)
        setTexture(n)
        _xSize = 3
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class DungeonPortalLight:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let n = Data.instance.outside_c.getCell(5, 7, 3, 2)
        setTexture(n)
        _xSize = 3
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class DungeonListPanel:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
        zPosition = UIStage.PANEL_LAYER
//
//        let s = Data.instance.stage
        let b = CGRect(x: -cellSize * 6, y: -cellSize * 3, width: cellSize * 12, height: cellSize * 6)
        let bg = SKShapeNode(rect: b, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.zPosition = self.zPosition + 2
        addChild(bg)
//        bg.position.x = -b.width * 0.5
//        bg.position.y = -b.height * 0.5
//        let gap = cellSize * 0.5
//        let startX = -b.width * 0.5 + 24
//        let startY = b.height * 0.5
//        let label = Label()
//        label.fontColor = UIColor.white
//        label.text = "Dungeon Level 1"
//        label.zPosition = UIStage.LAYER5
//        label.position.x = startX
//        label.position.y = startY - gap
//        let p = SKSpriteNode()
//        addChild(p)
//        p.addChild(bg)
//        p.addChild(label)
//        _label = label
    }
    private var _label:Label!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first
        let touchPoint = first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Data.instance.stage.removePanelDefault(p: self)
        } else if _nextButton.contains(touchPoint!) {
            let pages:CGFloat = _level.toFloat() / _pageSize.toFloat()
            if _curPage >= ceil(pages).toInt() {
                return
            }
            _curPage += 1
            pageReload()
        } else if _prevButton.contains(touchPoint!) {
            if _curPage <= 1 {
                return
            }
            _curPage -= 1
            pageReload()
        } else {
            for dc in _curPageItams {
                if dc.contains(touchPoint!) {
                    if dc == _lastSelectedItem {
                        createDungeon(l: dc._level)
                    } else {
                        _lastSelectedItem.selected = false
                        dc.selected = true
                        _lastSelectedItem = dc
                    }
                    break
                }
            }
        }
    }
    
    func create() {
//        let char = Data.instance._char!
        
        let _mask = Data.createMask()
        _mask.zPosition = self.zPosition + 1
        addChild(_mask)
        _closeButton.text = "关闭"
        _closeButton.position.y = cellSize * 3.5
        _closeButton.position.x = cellSize * 5
        _closeButton.zPosition = self.zPosition + 2
        addChild(_closeButton)
        
        _nextButton.text = "下一页"
        _nextButton.position.x = _closeButton.position.x
        _nextButton.position.y = -_closeButton.position.y
        _nextButton.zPosition = self.zPosition + 2
        addChild(_nextButton)
        
        _prevButton.text = "上一页"
        _prevButton.position.x = _nextButton.position.x - cellSize * 2.25
        _prevButton.position.y = _nextButton.position.y
        _prevButton.zPosition = self.zPosition + 2
        addChild(_prevButton)
        
        let t = Label()
        t.align = "left"
        t.fontSize = 16
        t.text = "传送：再次点击已选择的层数。"
        t.position.x = -cellSize * 6
        t.position.y = cellSize * 3 + 8
        t.zPosition = self.zPosition + 2
        addChild(t)
        
        addChild(_listBox)
        _level = Data.instance._char._dungeonLevel
        createList()
    }
    
    func pageReload() {
        _listBox.removeAllChildren()
        _curPageItams = Array<DungeonComponent>()
        
        createList()
    }
    
    func createList() {
        let startX = -cellSize * 5.5
        let startY = cellSize * 2
        let gapY = cellSize
        let gapX = cellSize * 4.5
        
        let start = (_curPage - 1) * _pageSize
        var last = _curPage * _pageSize
        if last >= _level {
            last = _level
        }
        
        if start >= last {
            return
        }
        
        for i in start...last - 1 {
            let y = i % 5
            let x = (i - start) / 5
            
            let dc = DungeonComponent()
            dc.text = "远古地下城第\(_level - i)层"
            dc._level = _level - i
            dc.position.x = startX + x.toFloat() * gapX
            dc.position.y = startY - y.toFloat() * gapY
            _listBox.addChild(dc)
            _curPageItams.append(dc)
        }
        
    }
    
    func createDungeon(l:Int) {
        let stage = Data.instance.stage!
        stage.removePanelDefault(p: self)
        let scene = stage.getSceneById(id: l - 1)
        stage.saveScene(scene: scene)
        scene._level = l
        stage.switchScene(next: scene)
    }
    
    private var _closeButton = Button()
    private var _prevButton = Button()
    private var _nextButton = Button()
    
    private var _curPage = 1
    private var _pageSize = 10
    private var _level = 0
    
    private var _listBox = SKSpriteNode()
    private var _curPageItams = Array<DungeonComponent>()
    private var _lastSelectedItem = DungeonComponent()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class DungeonComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _bg = SKShapeNode(rect: CGRect(x: 0, y: -cellSize * 0.375, width: cellSize * 4, height: cellSize * 0.75), cornerRadius: 2)
        _bg.strokeColor = UIColor.white
        _bg.lineWidth = 1
        addChild(_bg)
        self.zPosition = 210
    }
    var _level = 0
    var text:String {
        set {
            let t = Label()
            t.text = newValue
            t.align = "left"
            t.position.x = cellSize * 0.25
            t.position.y = -6
//            t.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
            t.fontSize = 14
            addChild(t)
        }
        get {
            return ""
        }
    }
    
    private var _select = false
    var selected:Bool {
        set {
            if newValue {
                _bg.strokeColor = Data.SELECTED_HIGHLIGH_COLOR
                _bg.lineWidth = 4
            } else {
                _bg.lineWidth = 1
                _bg.strokeColor = UIColor.white
            }
            _select = newValue
        }
        get {
            return _select
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _bg:SKShapeNode!
}
class FlowerRoad:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let n = Data.instance.tilee_outsidetown.getCell(14, 15, 1, 1)
        let node1 = SKSpriteNode(texture: n)
        node1.anchorPoint = CGPoint(x: 0.5, y: 0)
        let node2 = SKSpriteNode(texture: n)
        node2.anchorPoint = CGPoint(x: 0.5, y: 1)
        let node = SKSpriteNode()
        node.addChild(node1)
        node.addChild(node2)
        setTexture(node.toTexture())
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class MudRoad:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let n = Data.instance.outside_b.getCell(4, 9, 1, 1)
        let node1 = SKSpriteNode(texture: n)
        node1.anchorPoint = CGPoint(x: 0.5, y: 0)
        let node2 = SKSpriteNode(texture: n)
        node2.anchorPoint = CGPoint(x: 0.5, y: 1)
        let node = SKSpriteNode()
        node.addChild(node1)
        node.addChild(node2)
        setTexture(node.toTexture())
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class VillageHead:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.picturePeople1.getCell(7, 4))
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class RoadMessagePanel:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first
        let touchPoint = first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Data.instance.stage.removePanelDefault(p: self)
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
//        let startX = -cellSize * 5
        let gap:CGFloat = 24
//        let west = Label()
//        west.fontSize = 16
//        west.position.x = -cellSize * 5
//        west.position.y = cellSize * 2
//        west.align = "left"
//        west.text = "西："
//        west.zPosition = _bg.zPosition + 1
//        addChild(west)
        var next = createLabel(y: cellSize * 2, text: "西：")
        next = createLabel(y: next.position.y - gap, text: "封印师住所，冒险者工会")
        next = createLabel(y: next.position.y - gap, text: "东：")
        next = createLabel(y: next.position.y - gap, text: "魔法屋，民家")
        next = createLabel(y: next.position.y - gap, text: "北：")
        next = createLabel(y: next.position.y - gap, text: "杂货店，武器店，礼品屋")
        next = createLabel(y: next.position.y - gap, text: "东北：")
        next = createLabel(y: next.position.y - gap, text: "四方阵入口、十二魔宫入口")
        
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
        addChild(l)
        
        return l
    }
}
class DoubleGrass:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.tilee_outsidetown.getCell(7, 15, 2, 1)
        setTexture(item)
        _xSize = 2
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
