//
//  LastChance.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LastChance: Magical {
    override init() {
        super.init()
        _name = "殊死一搏"
        _description = "对目标造成攻击力350%的物理伤害，或者为目标恢复75%最大生命"
        _quality = Quality.GOOD
        _cooldown = 2
        _rate = 3.5
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget
        _damageValue = physicalDamage(t)
        let damage = _damageValue
        let this = self
        if hadSpecialAction(t:t, completion: completion) {
            
        } else {
            if !hasMissed(target: t, completion: completion) {
                if this.yon() {
                    t.actionAttacked(defend: t.isDefend, completion: {
                        t.hpChange(value: damage)
                        t.showValue(value: damage) {
                            completion()
                        }
                        c.hpChange(value: damage)
                        c.showValue(value: damage)
                    })
                } else {
                    let heal = t.getHealth() * 0.75
                    t.hpChange(value: heal)
                    t.showValue(value: heal) {
                        completion()
                    }
                }
            }
        }
    }
    
    
    
}
