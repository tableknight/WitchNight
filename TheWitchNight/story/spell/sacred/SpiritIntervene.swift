//
//  SpiritIntervene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SpiritIntervene: Magical {
    override init() {
        super.init()
        _name = "精神干涉"
        _description = "使目标的精神变为随机的数字"
        _quality = Quality.SACRED
        _tear = 1
        isTargetAll = true
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget
        let this = self
        c.actionCast {
            let ro = Creature()
            ro.intellectChange(value: t._unit._level * 3)
            let change = this.seed(min: 0, max: ro._extensions.spirit.toInt()).toFloat()
            t._unit._extensions.spirit = change - t.getSpirit(t: c._unit)
            t.showText(text: "SPIRIT \(change)", color: Colors.STATUS_CHANGE, completion: completion)
        }
    }
    
    override func findTarget(inleft: Bool) {
        let all = _battle._leftRoles + _battle._rightRoles
        _battle._selectedTarget = all.one()
    }
    
}


