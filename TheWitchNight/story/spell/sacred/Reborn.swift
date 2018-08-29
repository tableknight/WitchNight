//
//  Reborn.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Reborn: Passive {
    
    override init() {
        super.init()
        _quality = Quality.SACRED
        _name = "重生"
        _description = "行动结束后恢复5%最大生命"
        hasAfterMoveAction = true
    }
    override func afterMove(completion: @escaping () -> Void) {
        let c = _battle._curRole
        _rate = 0.05
        if c._unit is Character {
            let char = c._unit as! Character
            if char._soulStone is HeartOfTarrasque {
                _rate = 0.1
            }
        }
        let h = c.getHealth() * _rate
        c.hpChange(value: h)
        c.showValue(value: h) {
            completion()
        }
    
    }
}
