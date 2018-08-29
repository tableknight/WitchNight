//
//  SoulLash.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SoulLash: Magical {
    override init() {
        super.init()
//        isWater = true
        _name = "灵魂鞭笞"
        _description = "对目标造成精神80%的魔法伤害，25%几率静默目标"
        _rate = 0.8
        _quality = Quality.SACRED
        _cooldown = 2
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
        let b = _battle
//        let c = _battle._curRole
        _damageValue = magicalDamage(t)
        let damage = _damageValue
        let this = self
        if hadSpecialAction(t:t, completion: completion) {
            
        } else {
            
            t.actionAttacked {
                t.hpChange(value: damage)
                t.showValue(value: damage) {
                    completion()
                    if this.seed() < 25 {
                        b?.silenceUnit(unit: t)
                        t.showText(text: "SILENCED")
                    }
                }
                
            }
        }
    }
    
}


