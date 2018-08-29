//
//  ElementalPowe.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ElementalPower: Attribute {
    override init() {
        super.init()
        _name = "元素伤害"
    }
    override func on(unit: Creature) {
        unit._ElementalPower.fire += _value
        unit._ElementalPower.water += _value
        unit._ElementalPower.thunder += _value
    }
    
    override func off(unit: Creature) {
        unit._ElementalPower.fire -= _value
        unit._ElementalPower.water -= _value
        unit._ElementalPower.thunder -= _value
    }
    override func create(level: CGFloat) {
        elementalAttrValue(level: level)
    }
}
