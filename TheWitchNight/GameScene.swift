//
//  GameScene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
//    var node : Stage!
//    var texture : SKTexture?
//    var mask : SKCropNode?
//    var step:CGFloat = 1
//    var _char:Character!
    override func didMove(to view: SKView) {
        Data.instance.scene = self
//        for i in 0...UIFont.familyNames.count - 1 {
//            print("\(i) \(UIFont.familyNames[i])")
//        }
        let e = Emily()
        e.create(level: 1)
//        e._level = 100
        e._leftPoint = 5
        e._dungeonLevel = 100
        let char = BUnit()
        char.setUnit(unit: e)
        char.createForStage()
        for _ in 0...65 {
            e.levelup()
            for m in e._minions {
                m.levelup()
            }
        }
        e._spellsInuse = [SwapHealth(), IceFist(), Interchange(), SummonFlower()]
//        char.hp
        Data.instance._char = e
//        e._dungeonLevel = 52
//        e._rhythm = 100
//        e._spellsInuse = [Heal(), ShootAll(), EyeToEye()]
//        e._spells = [OnePunch(),Lighting(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout(),BargeAbout()]
//        let i = Instrument()
//        i.create(level: 1)
//        e._weapon = i
//        let sb = SpellBook()
//        sb.spell = Lighting()
//        e.addProp(p: sb)
//        let sb1 = SpellBook()
//        sb1.spell = Lighting()
//        e.addProp(p: sb1)
//        e._money = 200
//        let po = Potion()
//        po._count = 5
//        e.addProp(p: po)
        
//        let b = SpellBook()
//        b.spell = Reborn()
//        e.addProp(p: b)
//
//        let t = TheWitchsTear()
//        t._count = 200
//        e.addProp(p: t)
//
        let ts = TownScroll()
        ts._count = 5
        e.addProp(p: ts)
        e.addMoney(num: 1000)
//        let ss = SealScroll()
//                ss._count = 5
//        e.addProp(p: ss)
        
        let stage = UIStage()
        stage.setChar(char)
        addChild(stage)
        
        let loot = Loot()
        for _ in 0...30 {
            let outfit = loot.getSacred()
            if nil != outfit {
                e.addProp(p: outfit!)
            }
        }
        
        let l = Loot()
        
        for i in l._normalSpellArray {
            e._spells.append(l.getNormalSpell(id: i))
        }
        for i in l._goodSpellArray {
            e._spells.append(l.getGoodSpell(id: i))
        }
        for i in l._rareSpellArray {
            e._spells.append(l.getRareSpell(id: i))
        }
        for i in l._sacredSpellArray {
            e._spells.append(l.getSacredSpell(id: i))
        }
      
//        let rsp = RoleSelectPanel()
//        rsp._chars = [e] + e._minions
//        rsp.create()
//        addChild(rsp)
//        let si = CreationFlow()
//        addChild(si)
    }
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//        let origin = texture!.textureRect().origin
//        step += 1
//        let start = step.truncatingRemainder(dividingBy: 3) / 3
//        print(start)
//        let rect = CGRect(x: start, y: (2 / 4), width: (1 / 3), height: 0.25)
//        let aas = SKTexture(rect: rect, in: texture!)
//        sprite?.texture = aas
//        moveleft()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


