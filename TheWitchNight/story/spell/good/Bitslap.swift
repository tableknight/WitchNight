//
//  Bitslap.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Bitslap: Physical {
    override init() {
        super.init()
        _quality = Quality.GOOD
        isTargetEmemy = false
        _name = "一击必中"
        _cooldown = 1
        _description = "造成攻击力90%的物理伤害，本次攻击必定命中"
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget
        let c = b._curRole
        //        let role = c._unit
        let this = self
        b.roleMove(from: c, to: t, completion: {
            c.actionAttack {
                this.attack {
                    b.moveBack(unit: c) {
                        completion()
                    }
                }
            }
        })
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget
        let c = b._curRole
        _damageValue = physicalDamage(t)
        let damage = _damageValue
        if hadSpecialAction(t:t, completion: completion) {
            
        } else {
            t.actionAttacked(defend: t.isDefend, completion: {
                t.hpChange(value: damage)
                t.showValue(value: damage) {
                    completion()
                }
            })
        }
    }
    
}
