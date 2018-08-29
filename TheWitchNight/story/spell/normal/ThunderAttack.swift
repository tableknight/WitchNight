//
//  ThunderAttack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class ThunderAttack: Magical {
    override init() {
        super.init()
        isThunder = true
        _name = "雷击"
        _description = "对目标造成精神80%的雷电伤害，降低目标10点雷电抗性"
        _rate = 0.8
        _quality = Quality.NORMAL
        _cooldown = 1
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
        _damageValue = thunderDamage(t)
        let damage = _damageValue
        if hadSpecialAction(t:t, completion: completion) {
            
        } else {
            
            t.actionAttacked {
                t.hpChange(value: damage)
                t.showValue(value: damage) {
                    completion()
                    t.showText(text: "TR -10")
                    t._ElementalResistance.thunder -= 10
                }
            }
        }
    }
    override func findTarget(inleft: Bool = false) {
        findSingleTargetNotBlocked(inleft: _battle._curRole.inleft)
    }
}

