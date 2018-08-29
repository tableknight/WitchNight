//
//  Weapon.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Weapon:Outfit {
    override init() {
        super.init()
        _type = Prop.WEAPON
    }
    var isClose = true
    var _attackSpeed:CGFloat = 1
    func getAttack() -> CGFloat {
        for a in _attrs {
            if a is AttackAttribute {
                return a._value
            }
        }
        return 0
    }
}
