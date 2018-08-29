//
//  FireBreath.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireBreath: Magical {
    override init() {
        super.init()
        isWater = true
        _name = "火焰呼吸"
        _description = "对目标造成精神80%的火焰伤害"
        _rate = 0.8
        _quality = Quality.NORMAL
//        _cooldown = 1
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let this = self
        c.actionCast {
            this.attack {
                completion()
            }
        }
    }
    
    func attack(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget
        _damageValue = fireDamage(t)
        let damage = _damageValue
        if hadSpecialAction(t:t, completion: completion) {
            
        } else {
            
            t.actionAttacked {
                t.hpChange(value: damage)
                t.showValue(value: damage) {
                    completion()
                }
            }
        }
    }
    override func findTarget(inleft: Bool = false) {
        findSingleTargetNotBlocked(inleft: _battle._curRole.inleft)
    }
}
