//
//  SpringOfHeal.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FlowerOfHeal: SummonUnit {
    override init() {
        super.init()
        _stars.strength = 2.0
        _stars.stamina = 2.0
        _stars.agility = 1.0
        _stars.intellect = 1.0
        _name = "治疗之花"
        _img = SKTexture(imageNamed: "13000013.png")
        _spellsInuse = [HealOfFlower()]
        _race = EvilType.NATURE
        _last = 5
        hasAction = false
    }
    override func create(level: CGFloat) {
        _level = level
//        createQuality()
//        _growth.stamina = _stars.stamina + extraProperty(value: _stars.stamina)
//        _growth.strength = _stars.strength + extraProperty(value: _stars.strength)
//        _growth.agility = _stars.agility + extraProperty(value: _stars.agility)
//        _growth.intellect = _stars.intellect + extraProperty(value: _stars.intellect)
//        protectNew()
        levelTo(level: level)
        _extensions.hp = _extensions.health
//        _slot = seed(min: _spellSlot.min, max: _spellSlot.max + 1)
//        _spellCount = _slot
    }
}
class HealOfFlower: Passive {
    override init() {
        super.init()
        _quality = Quality.SACRED
        _name = "花之治疗"
        _description = "行动结束后恢复相邻单位15%最大生命。"
        hasAfterMoveAction = true
    }
    override func afterMove(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let this = self
        var rate:CGFloat = 0.15
        if Data.instance._char._magicMark is MarkOfVitality {
            rate = 0.3
        }
        c.actionCast {
            
            let ts = this.getAdajcentUnits(from: c)
            for u in ts {
                u.actionHealed {
                    let value = u.getHealth() * rate
                    u.hpChange(value: value)
                    u.showValue(value: value)
                    
                }
            }
            
            
            
            setTimeout(delay: 1, completion: {
                let su = c._unit as! SummonUnit
                if su._last < 1 {
                    c.actionDead {
                        c.removeFromBattle()
                        c.removeFromParent()
                    }
                } else {
                    su._last -= 1
                }
                completion()
            })
        }
        
    }
}
