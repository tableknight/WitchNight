//
//  ThunderPower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ThunderPower: Attribute {
    override init() {
        super.init()
        _name = "雷电伤害"
    }
    override func on(unit: Creature) {
        unit._ElementalPower.thunder += _value
    }
    
    override func off(unit: Creature) {
        unit._ElementalPower.thunder -= _value
    }
    override func create(level: CGFloat) {
        elementalAttrValue(level: level)
    }
}
