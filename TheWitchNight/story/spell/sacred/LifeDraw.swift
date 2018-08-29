//
//  LifeDraw.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LifeDraw: Magical {
    override init() {
        super.init()
        isWater = true
        _name = "生命吸取"
        _description = "对目标造成精神80%的魔法伤害，回复造成伤害的50%"
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
        let c = _battle._curRole
        _damageValue = magicalDamage(t)
        let damage = _damageValue
        if hadSpecialAction(t:t, completion: completion) {
            
        } else {
            
            t.actionAttacked {
                t.hpChange(value: damage)
                t.showValue(value: damage) {
                    completion()
                }
                var recoveryFactor:CGFloat = 0.5
                if c._unit.isMainChar {
                    let char = c._unit as! Character
                    if char._amulet is FangOfVampire {
                        recoveryFactor = 1
                    }
                }
                c.hpChange(value: -damage * recoveryFactor)
                c.showValue(value: -damage * recoveryFactor)
            }
        }
    }
    
}

