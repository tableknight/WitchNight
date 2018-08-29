//
//  Strength.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Strength: Attribute {
    override init() {
        super.init()
        _name = "力量"
    }
    override func on(unit: Creature) {
//        unit._mains.strength += _value
        unit.strengthChange(value: _value)
    }
    
    override func off(unit: Creature) {
//        unit._mains.strength -= _value
        unit.strengthChange(value: -_value)
    }
    
    override func create(level: CGFloat) {
        midAttrValue(level: level)
    }
}
