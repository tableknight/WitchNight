//
//  Heal.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Heal: Magical {
    override init() {
        super.init()
        _quality = Quality.NORMAL
        isTargetEmemy = false
        _name = "治疗"
        _cooldown = 2
        _description = "恢复己方目标最大生命50%的生命值"
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget
        let h = _battle._curRole.getHealth() * 0.5
        let c = _battle._curRole
//        _timeleft = _cooldown
        c.actionCast {
            t.actionHealed {
                t.hpChange(value: h)
                t.showValue(value: h) {
                    completion()
                }
            }
        }
    }
    
    override func findTarget(inleft:Bool = false) {
        findHpLowestUnit(inleft: _battle._curRole.inleft)
    }
    
}
