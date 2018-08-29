//
//  UIStage.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIStage:SKSpriteNode {
    private var _destX:CGFloat = 0
    private var loaded = true
//    private var _direction:Int = 1
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !loaded {
            debug("scene is loading!")
            return
        }
        
        let touchPoint = touches.first?.location(in: self)
        //        let view = touches.first?.view
        //        let pos = getPosition(touchX!, touchY!)
        
        if _messageNode.contains(touchPoint!) {
            _messageNode.removeFromParent()
            _messageNode = SKSpriteNode()
            return
        }
        
        if _minionButton.contains(touchPoint!) && !_minionButton.isHidden {
            let c = Data.instance._char
            if (c?._minions.count)! < 1 {
                return
            }
            let ml = MinionsList()
            ml.zPosition = UIStage.PANEL_LAYER
            ml.create(minions: (c?._minions)!)
//            addChild(ml)
            showMinionsListPanel(panel: ml)
            return
        } else if _spellButton.contains(touchPoint!) && !_spellButton.isHidden {
            let sp = SpellPanel()
            sp.create(role: Data.instance._char)
            showSpellPanel(panel: sp)
            return
        } else if _charButton.contains(touchPoint!) && !_charButton.isHidden {
            let ci = RoleInfoPanel()
            ci.create(char: Data.instance._char)
            showCharPanel(panel: ci)
            return
        } else if _itemButton.contains(touchPoint!) && !_itemButton.isHidden {
            let ap = ItemPanel()
            ap.create()
            showItemPanel(panel:ap)
            return
        }
        _destX = (touchPoint?.x)!
        _step = round(abs(_destX) / cellSize).toInt()
        _curStep = 0
        if _moving {
//            debug("moving!")
            return
        }
        
        let destY = (touchPoint?.y)!
//        debug("_dextX \(_destX)")
        
        if abs(_destX) <= cellSize * 0.5 {
            if destY > 0 {
                _char.faceNorth()
                isUpperPoint = true
            } else {
                _char.faceSouth()
                isUpperPoint = false
            }
            let x = round(abs(_curScene.position.x) / cellSize).toInt()
            if _curScene is UIRandomScene {
                let item = _curScene.getItemByX(x: x)
                item.triggerEvent()
                if item is UIEvil {
                    _lastBattleItem = item as! UIEvil
                }
            } else {
                _curScene.triggerEvent(pos: x)
            }
            return
        }
        
        _moving = true
        
//        _step = seed(min: 1, max: 7)
        move()
    }
    private var _lastBattleItem = UIEvil()
    private var _lastBattleX = -1
    var isUpperPoint = false
    private func isItemTouched() -> Bool {
        
        return false
    }

    private var _curStep = 0
    private func move() {
//        debug("_destX : \(_destX)")
        let curX = _curScene.getCurX()
        if isThisEvent(x: curX) {
            stop()
            _curScene.triggerEvent(pos: curX.toInt())
            return
        }
        if isNextEvil(x:curX) && _destX > 0 {
            stop()
            let pos = (curX + 1).toInt()
            let evil = _curScene._ground.childNode(withName: "evil\(pos)")
            let node =  evil as! UIEvil
            node.triggerEvent()
            _lastBattleItem = node
//            scene?.addChild(Battle())
//            createBattle(evils:evil._evils)
            return
        }
        //第一个格子
        if _destX < 0 && curX <= 0 {
            stop()
            return
        }
        //最后一个格子
        if _destX > 0 && curX >= _curScene.xSize - 1 {
            stop()
            return
        }
        let mv = SKAction.moveBy(x: _destX > 0 ? -cellSize : cellSize, y: 0, duration: TimeInterval(Data.instance.frameSize * 2))
        let this = self
        _curScene.run(mv, completion: {
            this._curStep += 1
            let curX = this._curScene.getCurX()
            if this._curStep < this._step {
                this.move()
            } else {
                this.stop()
                
            }
            if curX <= 0 {
                this._curScene.firstCellEvent()
            }
            if curX >= this._curScene.xSize - 1 {
                this._curScene.lastCellEvent()
            }
            
        })
        if _destX > 0 {
            
            _char.moveEast()
        } else {
            _char.moveWest()
        }
    }
    
    private func isNextEvil(x:CGFloat) -> Bool {
        if _curScene.evilIn.contains(x.toInt() + 1) {
            return true
        }
        return false
    }
    
    private func isThisEvent(x:CGFloat) -> Bool {
        if _curScene.eventIn.contains(x.toInt()) {
            return true
        }
        return false
    }
    
    private func stop() {
        _moving = false
        _curStep = 0
//        if _curScene.position.x <= -(Data.instance.screenWidth * 0.5) - cellSize * 0.5 {
//            _curScene.position.x = -(Data.instance.screenWidth * 0.5) - cellSize * 0.5
//        }
//        _curScene.clean()
//        //        print("1-------------------------------")
//        _curScene.createGround(start: _curScene.curX, end: _curScene.curX + _curScene.MIN_X_SIZE)
        _curScene.stopedPointEvent(pos: _curScene.getCurX().toInt())
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        createMenu()
        createActor()
        createSceneChangeMask()
        _nameLabel.fontSize = 18
        _nameLabel.align = "left"
        _nameLabel.position.x = -cellSize * 7.5
        _nameLabel.position.y = cellSize * 4 - 10
        _nameLabel.zPosition = UIStage.UILAYER
        addChild(_nameLabel)
        Data.instance.stage = self
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setChar(_ char:BUnit) {
        _char = char
        _char.zPosition = UIStage.LAYER4
        _char.position.y = cellSize * 0.75
        _char.faceEast()
        addChild(_char)
        loadScene()
    }
    
    func setSceneXPos(x:CGFloat) {
        _curScene.position.x = x * -cellSize - cellSize * 0.5
    }
    
    func loadScene() {
//        let oa4 = Data.instance.outside_a4
//        let gs = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
//        let groundStart = SKSpriteNode(texture:gs.groundStart())
//        groundStart.position.y = cellSize * 0.5
//        addChild(groundStart)
//        let wallStart = SKSpriteNode(texture: gs.wallStart())
//        wallStart.position.y = -cellSize * 1.5
//        addChild(wallStart)
//        let ob = Data.instance.outside_b
//
//        let gc = SKSpriteNode(texture: gs.groundConnect())
//        gc.position.x = cellSize
//        gc.position.y = cellSize * 0.5
//        addChild(gc)
//        let wallStart1 = SKSpriteNode(texture: gs.wallConnect())
//        wallStart1.position.y = -cellSize * 1.5
//        wallStart1.position.x = cellSize
//        addChild(wallStart1)
//        let sha = SKSpriteNode(texture: SKTexture(imageNamed: "wall_deep.png"))
//        sha.position.y = -cellSize * 1.5
//        sha.zPosition = UIStage.LAYER4
//        sha.alpha = 0.45
//        addChild(sha)
//        let tree = SKSpriteNode(texture: ob.getCell(5, 12, 1, 2))
//        tree.position.y = cellSize * 1.5
//        tree.zPosition = UIStage.LAYER2
//        addChild(tree)
        let meadow = CenterVillage()
//        let meadow = WitheredLane()
//        _scenes.append(meadow)
        meadow.zPosition = UIStage.LAYER2
        meadow.create()
        addChild(meadow)
        _curScene = meadow
        _nameLabel.text = meadow._name
//        let this = self
        setTimeout(delay: 10, completion: generalSpeaking)
//        generalSpeaking()
    }
    //传入的uiscene是未初始化的，并且没有加入到stage的scene列表，需要手动添加
    func switchScene(next:UIScene, afterCreation:@escaping () -> Void = {},  completion:@escaping () -> Void = {}) {
        showSceneMask()
        loaded = false
//        return
        let this = self
        setTimeout(delay: 1, completion: {
            
//            let wait = SKAction.wait(forDuration: TimeInterval(1))
            let out = SKAction.fadeOut(withDuration: TimeInterval(1))
            if !next.hasInitialized {
                next.create()
                afterCreation()
            }
            //        return
//            let go = SKAction.sequence([wait, out])
            this._curScene.removeFromParent()
            this.addChild(next)
            this._curScene = next
            next.zPosition = UIStage.LAYER2
            
            this._sceneChangeMask.run(out) {
                completion()
                this.loaded = true
            }
            if next is UIRandomScene {
                this._nameLabel.text = "远古地下城第\(next._level)层-\(next._name)\(next._index)"
            } else {
                this._nameLabel.text = next._name
            }
        })
    }
    
    func maskFadeOut(completion:@escaping () -> Void = {}) {
        let out = SKAction.fadeOut(withDuration: TimeInterval(1))
        _sceneChangeMask.run(out) {
            completion()
        }
    }
    
    static let LAYER1:CGFloat = 0
    static let LAYER2:CGFloat = 10
    static let LAYER3:CGFloat = 20
    static let LAYER4:CGFloat = 30
    static let LAYER5:CGFloat = 40
    static let LAYER6:CGFloat = 50
    static let UILAYER:CGFloat = 90
    static let PANEL_LAYER:CGFloat = 100
    static let TOP_LAYER:CGFloat = 200
    var _char = BUnit()
    var _curScene  = UIScene()
    private var _step = 0
    var _moving = false
    private var _nameLabel = Label()
    var _scenes = Array<UIScene>()
//    private var _currentX:CGFloat = 0
    private var _charButton:MenuButton!
    private var _minionButton:MenuButton!
    private var _spellButton:MenuButton!
    private var _itemButton:MenuButton!
    private var _outfitButton:MenuButton!
    func createMenu() {
        let startX = Data.instance.screenWidth * 0.5 - cellSize * 0.5
        let y = -Data.instance.screenHeight * 0.5 + cellSize * 0.5 - 5
        _charButton = MenuButton()
        _charButton.position.x = startX
        _charButton.position.y = y
        _charButton.setText(text: "角色")
        addChild(_charButton)
        _uis.append(_charButton)
        _itemButton = MenuButton()
        _itemButton.position.x = startX - cellSize
        _itemButton.position.y = y
        _itemButton.setText(text: "物品")
        addChild(_itemButton)
        _uis.append(_itemButton)
        _spellButton = MenuButton()
        _spellButton.position.x = startX - cellSize * 2
        _spellButton.position.y = y
        _spellButton.setText(text: "法术")
        addChild(_spellButton)
        _uis.append(_spellButton)
        _minionButton = MenuButton()
        _minionButton.position.x = startX - cellSize * 3
        _minionButton.position.y = y
        _minionButton.setText(text: "随从")
        addChild(_minionButton)
        _uis.append(_minionButton)
        
//        _outfitButton = MenuButton()
//        _outfitButton.position.x = startX - cellSize * 4
//        _outfitButton.position.y = y
//        _outfitButton.setText(text: "装备")
//        addChild(_outfitButton)
//        _uis.append(_outfitButton)
    }
    private var _actor:Actor!
    private var _hpbar:HBar!
    private var _expbar:HBar!
    private var _levelLabel:Label!
    func createActor() {
        let x = -cellSize * 7
        let y = -Data.instance.screenHeight * 0.5 + cellSize * 0.5
        _actor = Actor()
//        _actor.anchorPoint = CGPoint(x: 0, y: 1)
        _actor.setActor()
        _actor.position.x = x
        _actor.position.y = y + cellSize * 0.5
        addChild(_actor)
        _uis.append(_actor)
        _hpbar = HBar()
        _hpbar._color = UIColor.red
//        _hpbar.setBar()
        _hpbar.position.x = _actor.position.x - cellSize * 0.5
        _hpbar.position.y = y - 10
        addChild(_hpbar)
        _uis.append(_hpbar)
        _expbar = HBar()
        _expbar._color = UIColor.green
//        _expbar.setBar()
        _expbar.position.x = _hpbar.position.x
        _expbar.position.y = y - 20
        addChild(_expbar)
        _uis.append(_expbar)
        _levelLabel = Label()
        _levelLabel.position.x = _actor.position.x + cellSize * 0.5 + 2
        _levelLabel.fontSize = 16
        _levelLabel.position.y = y
        _levelLabel.align = "left"
//        _levelLabel.text = "Lv.1"
        _levelLabel.fontColor = UIColor.white
        addChild(_levelLabel)
        
        let c = Data.instance._char!
        _hpbar.setBar(value: c._extensions.hp / c._extensions.health)
        _expbar.setBar(value: c._exp / c.expNext())
        _levelLabel.text = "Lv.\(c._level.toInt())"
        
//        _uis.append(_levelLabel)
    }
    private func generalSpeaking() {
        let this = self
        setTimeout(delay: 15, completion: {
            this.generalSpeaking()
        })
        if _moving || seed() > 50 {
            return
        }
        _char.speak(text: _curScene._speaking.one())
    }
    private var _uis = Array<SKSpriteNode>()
    func hideUI() {
        for s in _uis {
            s.isHidden = true
        }
        _nameLabel.isHidden = true
        _levelLabel.isHidden = true
    }
    func showUI() {
        for s in _uis {
            s.isHidden = false
        }
        _nameLabel.isHidden = false
        _levelLabel.isHidden = false
        reloadCharUI()
    }
    
    func reloadCharUI() {
        let c = Data.instance._char!
        _hpbar.setBar(value: c._extensions.hp / c._extensions.health)
        _expbar.setBar(value: c._exp / c.expNext())
        _levelLabel.text = "Lv.\(c._level.toInt())"
    }
    
    func hideScene() {
        _curScene.isHidden = true
        _char.isHidden = true
    }
    func showScene() {
        _curScene.isHidden = false
        _char.isHidden = false
    }
    
    func showSpellPanel(panel:SpellPanel) {
        hideUI()
        hideScene()
        addChild(panel)
    }
    func closeSpellPanel(panel:SpellPanel) {
        showUI()
        showScene()
        panel.removeFromParent()
    }
    func closeCharPanel(panel:RoleInfoPanel) {
        showUI()
        showScene()
        panel.removeFromParent()
    }
    func showCharPanel(panel:RoleInfoPanel) {
        hideUI()
        hideScene()
        addChild(panel)
    }
    func closeMinionsListPanel(panel:MinionsList) {
        showUI()
        showScene()
        panel.removeFromParent()
    }
    func showMinionsListPanel(panel:MinionsList) {
        hideUI()
        hideScene()
        addChild(panel)
    }
    func showMinionPanel(panel:MinionPanel) {
        hideUI()
        hideScene()
        addChild(panel)
    }
    func closeMinionPanel(panel:MinionPanel) {
        showUI()
        showScene()
        panel.removeFromParent()
    }
    func showItemPanel(panel:ItemPanel) {
        hideUI()
        hideScene()
        addChild(panel)
    }
    func removeItemPanel(panel:ItemPanel) {
        showUI()
        showScene()
        panel.removeFromParent()
    }
    func addBattle(b:Battle) {
        if nil != childNode(withName: "battle") {
            return
        }
        hideUI()
        hideScene()
        addChild(b)
        _moving = false
    }
    func addPanelDefault(p:SKSpriteNode) {
        addChild(p)
    }
    func removePanelDefault(p:SKSpriteNode) {
        p.removeFromParent()
    }
    func removeBattle(b:Battle) {
        showUI()
        showScene()
        b.removeFromParent()
        if b.victory {
            _lastBattleItem.removeFromParent()
            let x = round(abs(_curScene.position.x) / cellSize).toInt() + 1
            if _curScene.evilIn.contains(x) {
                let index = _curScene.evilIn.index(of: x)
                if nil != index {
                    _curScene.evilIn.remove(at: index!)
                }
            }
        }
        _moving = false
    }
    var _sceneSize = 2
    func getSceneById(id:Int) -> UIScene {
        switch id {
        case 0:
            return Meadow()
        case 1:
            return DeadEarth()
        case 2:
            return LostForest()
        case 3:
            return FrozenLand()
        case 4:
            return BloodSquare()
        default:
            return getSceneById(id:seed(min: 0, max: 5))
        }
    }
    private var _sceneChangeMask = SKSpriteNode()
    private func createSceneChangeMask() {
        let rect = CGRect(x: -cellSize * 8, y: -cellSize * 5, width: cellSize * 16, height: cellSize * 10)
        let cover = SKShapeNode(rect: rect)
        cover.fillColor = UIColor.black
        _sceneChangeMask.addChild(cover)
        _sceneChangeMask.isHidden = true
        _sceneChangeMask.zPosition = UIStage.TOP_LAYER
        addChild(_sceneChangeMask)
    }
    func showSceneMask() {
        _sceneChangeMask.isHidden = false
        _sceneChangeMask.alpha = 1
    }
    
    private func hideSceneMask() {
        _sceneChangeMask.isHidden = true
    }
    
    func hasTowerStatus(status:Status) -> Bool {
        for scn in _scenes {
            for s in scn._status {
                if s._type == status._type {
                    return true
                }
            }
        }
        return false
    }
    func addStatus(status:Status) {
        _curScene._status.append(status)
    }
    
    var _dialogExist = false
    func showDialog(img:SKTexture, text:String, name:String) -> Dialog {
        _dialogExist = true
        hideUI()
        _char.removeSpeak()
        let dlg = Dialog()
        dlg._name = name
        dlg.create(img: img)
        dlg.text = text
        addChild(dlg)
        
        return dlg
    }
    
    func removeDialog(dlg:Dialog) {
        _dialogExist = false
        dlg.removeFromParent()
        showUI()
    }
    
    func saveScene(scene:UIScene) {
        _scenes.append(scene)
    }
    
    
    
    var _messageNode = SKSpriteNode()
}
