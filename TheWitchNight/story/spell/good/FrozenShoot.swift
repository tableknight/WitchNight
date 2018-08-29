//
//  FrozenShoot.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FrozenShoot: Magical {
    override init() {
        super.init()
        _quality = Quality.GOOD
        isWater = true
        _name = "寒冰射击"
        _cooldown = 2
        _rate = 0.6
        _description = "对目标造成精神60%的冰冷伤害，有一定几率冻结目标"
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget
        let c = _battle._curRole
        _damageValue = waterDamage(t)
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
                    this.setFrozen(target: t, completion: {})
                    //                completion()
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
