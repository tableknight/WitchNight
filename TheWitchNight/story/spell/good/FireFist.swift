//
//  FireFist.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireFist: Physical {
    override init() {
        super.init()
        isClose = true
        _name = "火焰掌"
        _description = "对目标造成120%攻击力的火焰伤害，需要空手"
        isFire = true
        _rate = 1.2
        _quality = Quality.GOOD
        _cooldown = 1
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
        //        let role = c._unit
        let fireRate = (c.getFirePower() - t.getFireResistance()) * 0.01 + 1
        _damageValue = physicalDamage(t) * fireRate
        let damage = _damageValue
        if hadSpecialAction(t:t, completion: completion) {
            
        } else {
            if !hasMissed(target: t, completion: completion) {
                t.actionAttacked(defend: t.isDefend) {
                    t.hpChange(value: damage)
                    t.showValue(value: damage) {
                        completion()
                    }
                }
            }
        }
    }
    
    override func selectable() -> Bool {
        let w = _battle._curRole._unit._weapon
        if w.hasInitialized {
//            if w is Fist {
//                return true
//            } else {
//            }
            return false
        } else {
            return true
        }
    }
}
