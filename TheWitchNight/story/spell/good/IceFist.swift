//
//  IceFist.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/16.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class IceFist: Physical {
    override init() {
        super.init()
        isClose = true
        _name = "寒冰掌"
        _description = "对目标造成60%攻击力的伤害，附加当前生命15%的寒冰伤害，需要空手"
//        isFire = true
        isWater = true
        _rate = 0.6
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
        _damageValue = physicalDamage(t)
        let damage = _damageValue
        if hadSpecialAction(t:t, completion: completion) {
            
        } else {
            if !hasMissed(target: t, completion: completion) {
                let attechment = c.getHp() * -0.15
                t.actionAttacked(defend: t.isDefend) {
                    t.hpChange(value: damage)
                    t.showValue(value: damage) {
//                        completion()
                    }
                    let waterRate = (c.getWaterPower() - t.getWaterResistance()) * 0.01 + 1
                    let waterDamage:CGFloat = attechment * waterRate
                    setTimeout(delay: 0.5, completion: {
                        t.hpChange(value: waterDamage)
                        t.showValue(value: waterDamage, isCritical: false, textColor: ElementColor.getColor(Element.WATER), completion: completion)
                    })
                }
                c.hpChange(value: attechment)
                c.showValue(value: attechment)
                
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

