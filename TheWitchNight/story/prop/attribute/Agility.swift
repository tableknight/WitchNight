//
//  Agility.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Agility: Attribute {
    override init() {
        super.init()
        _name = "敏捷"
    }
    override func on(unit: Creature) {
//        unit._mains.agility += _value
        unit.agilityChange(value: _value)
    }
    
    override func off(unit: Creature) {
//        unit._mains.agility -= _value
        unit.agilityChange(value: -_value)
    }
    override func create(level: CGFloat) {
        midAttrValue(level: level)
    }
}
