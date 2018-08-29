//
//  UIItem.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIItem:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func setTexture(_ texture:SKTexture) {
        self.texture = texture
        self.size = texture.size()
    }
    
    var _xSize:Int = 1
    var _ySize:Int = 1
    var _items = Array<Int>()
    
    func triggerEvent() {
        
    }
    
    private var _speakNode = SKSpriteNode()
    func speak(text:String, autoRemove:Bool = true, duration:CGFloat = 3) {
        let node = SKSpriteNode()
        _speakNode.removeFromParent()
        var width = cellSize * 2.25
        if text.count >= 6 {
            width = width + ((text.count - 6) * 11).toFloat()
        }
        let rect = CGRect(x: -width * 0.5, y: -cellSize * 0.375, width: width, height: cellSize * 0.75)
        let bg = SKShapeNode(rect: rect, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.alpha = 0.65
        node.addChild(bg)
        
        let border = SKShapeNode(rect: rect, cornerRadius: 4)
        border.lineWidth = 2
        node.addChild(border)
        
        let l = Label()
        l.fontSize = 14
        l.fontColor = UIColor.white
        l.position.y = -7
        l.text = text
        node.addChild(l)
        
        node.zPosition = UIStage.LAYER2 + 3
        node.position.y = cellSize * 0.5
        addChild(node)
        if autoRemove {
            setTimeout(delay: duration, completion: {
                node.removeFromParent()
            })
        }
        _speakNode = node
    }
    
    func removeSpeak() {
        _speakNode.removeFromParent()
    }
}

class PortalNext:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.inside_b.getCell(3, 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func triggerEvent() {
//        let stage = Data.instance.stage!
//        let index = stage._curScene._index
//        let nextIndex = index + 1
//        var nextScene = UIScene()
//        var exist = false
//        for scn in stage._scenes {
//            if scn._index == nextIndex {
//                nextScene = scn
//                exist = true
//                break
//            }
//        }
//        if !exist {
//            nextScene = stage.getSceneById(id: stage._curScene._id)
//            nextScene.create()
//            nextScene._index = nextIndex
//            stage._scenes.append(nextScene)
//        }
//        stage.switchScene(next: nextScene)
    }
}
class PortalPrev:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.inside_b.getCell(4, 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func triggerEvent() {
    }
}

class Gate:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.tiled_dungeons.getCell(11, 9, 3, 2))
        _xSize = 3
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func triggerEvent() {
        let stage = Data.instance.stage!
//        let next = stage.getSceneById(id: seed(max: stage._sceneSize))
//        next._level = stage._curScene._level + 1
//        stage._scenes = [next]
//        stage.switchScene(next: next)
        let sc = stage._curScene
        
        let b = Battle()
        
        var evs = Array<Creature>()
        var max = 6
        if Data.instance._char._dungeonLevel < 10 {
            max = 4
        }
        for _ in 1...max {
            let e = sc.getEvilById(seed(min: 0, max: 4))
            e.create(level: sc._level.toFloat())
            evs.append(e)
        }
        b.setEvils(evils: evs)
        let char = Data.instance._char!
        let roles = [char] + char.getReadyMinions()
        
        b.setRoles(roles: roles)
        b.zPosition = UIStage.LAYER6
        b.battleStart()
        b.afterBatteAction = {
            if b.victory {
                let nextLevel = sc._level + 1
                let nextScene = stage.getSceneById(id: nextLevel)
                nextScene._level = nextLevel
                stage._scenes = [nextScene]
                stage.switchScene(next: nextScene)
                showMsg(text: "进入地下城第\(nextLevel)层。。")
                if char._dungeonLevel < nextLevel {
                    char._dungeonLevel = nextLevel
                }
            }
        }
        Data.instance.stage.addChild(b)
        
        Data.instance.stage.hideUI()
        Data.instance.stage.hideScene()
    }
}
