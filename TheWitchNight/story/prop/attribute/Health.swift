//
//  Health.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Health: Attribute {
    override init() {
        super.init()
        _name = "最大生命"
    }
    override func on(unit: Creature) {
        unit._extensions.health += _value
    }
    
    override func off(unit: Creature) {
        unit._extensions.health -= _value
        if unit._extensions.hp > unit._extensions.health {
            unit._extensions.hp = unit._extensions.health
        }
    }
    override func create(level: CGFloat) {
        _value = seed(min: level.toInt(), max: (level * 2).toInt()).toFloat()
    }
}
