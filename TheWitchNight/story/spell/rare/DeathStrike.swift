//
//  DeathStrike.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class DeathStrike: Magical {
    override init() {
        super.init()
        _quality = Quality.RARE
        _name = "死亡冲击"
        _cooldown = 2
        _rate = 0.8
        _description = "对目标造成精神80%的魔法伤害，每次偷取目标10点精神"
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget
        let c = _battle._curRole
        _damageValue = magicalDamage(t)
        let damage = _damageValue
        let this = self
        c.actionCast {
            if this.hadSpecialAction(t:t, completion: completion) {
                
            } else {
                t.actionAttacked {
                    t.hpChange(value: damage)
                    t.showValue(value: damage) {
                        completion()
                    }
                    let up = Status()
                    up._type = Status.DEATH_STRIKE_UP
                    c.addStatus(status: up)
                    let down = Status()
                    down._type = Status.DEATH_STRIKE_DOWN
                    t.addStatus(status: down)
                }
            }
        }
    }
    override func findTarget(inleft: Bool = false) {
        if _battle._curRole.inleft {
            _battle._selectedTarget = _battle._rightRoles[seed(max: _battle._rightRoles.count)]
        } else {
            _battle._selectedTarget = _battle._leftRoles[seed(max: _battle._leftRoles.count)]
        }
    }
}
