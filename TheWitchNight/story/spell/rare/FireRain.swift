//
//  FireRain.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FireRain: Magical {
    override init() {
        super.init()
        isFire = true
        _name = "火雨"
        isAutoSelectTarget = true
        _description = "对所有敌方目标造成精神35%的火焰伤害"
        _quality = Quality.RARE
        _rate = 0.35
        _cooldown = 3
    }
    override func cast(completion:@escaping () -> Void) {
        
//        let t = _battle._selectedTarget
        let c = _battle._curRole
        let this = self
        c.actionCast {
            this.attack {
                completion()
            }
        }
    }
    
    func attack(completion:@escaping () -> Void) {
        let ts = _battle._selectedTargets
        let t = ts[0]
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
        if ts.count > 1 {
            for i in 1...ts.count - 1 {
                let t = ts[i]
                _damageValue = fireDamage(t)
                let damage = _damageValue
                if hadSpecialAction(t:t, completion: completion) {
                    
                } else {
                    
                    t.actionAttacked {
                        t.hpChange(value: damage)
                        t.showValue(value: damage)
                        //                        completion()
                    }
                }
            }
        }
    }
    
    override func findTarget(inleft:Bool = false) {
        let c = _battle._curRole
        if c.inleft {
            _battle._selectedTargets = _battle._rightRoles
        } else {
            _battle._selectedTargets = _battle._leftRoles
        }
    }
}
