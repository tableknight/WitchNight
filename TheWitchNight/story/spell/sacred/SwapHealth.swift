//
//  SwapHealth.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/16.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SwapHealth: Magical {
    override init() {
        super.init()
        _name = "换血"
        _description = "和己方单位交换生命值"
        _quality = Quality.SACRED
        _tear = 1
        isTargetEmemy = false
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget
        c.actionCast {
            let thp = t.getHp()
            t._unit._extensions.hp = 0
            t.hpChange(value: c.getHp())
            c._unit._extensions.hp = 0
            c.hpChange(value: thp)
            completion()
        }
    }
    
    
    
}
