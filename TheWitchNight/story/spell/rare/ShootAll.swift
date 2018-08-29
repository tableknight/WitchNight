//
//  ShootAll.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/5.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ShootAll: Physical {
    override init() {
        super.init()
        _name = "散射"
        _description = "对所有敌方单位造成攻击40%的物理伤害"
        isClose = false
        _rate = 0.4
        isAutoSelectTarget = true
        _quality = Quality.RARE
        _cooldown = 2
    }
    
    override func cast(completion: @escaping () -> Void) {
        let this = self
        _battle._curRole.actionShoot {
            var i = 0
            
            for t in this._battle._selectedTargets {
                if i == 0 {
                    this.attack(t: t, completion: completion)
                } else {
                    this.attack(t: t)
                }
                i += 1
            }
        }
    }
    
    private func attack(t:BUnit, completion:@escaping () -> Void = {}) {
        let damage = physicalDamage(t)
        
        if !hadSpecialAction(t: t, completion: completion) {
            if !hasMissed(target: t, completion: completion) {
                t.actionAttacked {
                    t.hpChange(value: damage)
                    t.showValue(value: damage, completion: completion)
                }
            }
        }
        
    }
    
    override func findTarget(inleft: Bool) {
        _battle._selectedTargets = _battle._rightRoles
    }
    
    override func selectable() -> Bool {
        let w = _battle._curRole._unit._weapon
        return w.hasInitialized && !w.isClose
    }
    
}
