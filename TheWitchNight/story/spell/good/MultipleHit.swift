//
//  MultipleHit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MultipleHit: Physical {
    override init() {
        super.init()
        isClose = true
        _quality = Quality.GOOD
        _cooldown = 2
        _name = "连击"
        _description = "对同一目标造成2-4次伤害，每次造成攻击45%的物理伤害"
    }
    override func cast(completion:@escaping () -> Void) {
        let times = seed(min: 2, max: 5)
        _rate = 0.45
        let c = _battle._curRole
        let t = _battle._selectedTarget
        let this = self
        _battle.roleMove(from: c, to: t, completion: {
            this.atrack(times: times, completion: {
                this._battle.moveBack(unit: c, completion: completion)
            })
        })
        
    }
    
    private func atrack(times:Int, completion:@escaping () -> Void) {
        var t = _battle._selectedTarget
        let c = _battle._curRole
        if t.isDead() {
            var roles = _battle._leftRoles
            if c.inleft {
                roles = _battle._rightRoles
            }
            if roles.count < 1 {
                completion()
                return
            }
            findTarget()
            t = _battle._selectedTarget
        }
        if times < 1 {
            completion()
            return
        }
        _damageValue = physicalDamage(t)
        let damage = _damageValue
        let this = self
        c.actionAttack {
            
            if this.hadSpecialAction(t:t, completion: {
                this.atrack(times: times - 1, completion: {
                    completion()
                })
            }) {
                
            } else {
                t.actionAttacked {
                    t.hpChange(value: damage)
                    t.showValue(value: damage, isCritical: this.beCritical) {
                        this.atrack(times: times - 1, completion: {
                            completion()
                        })
                    }
                    
                }
            }
        }
        
        
    }

}
