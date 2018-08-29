//
//  ThunderResistance.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ThunderResistance: Attribute {
    override init() {
        super.init()
        _name = "雷电抗性"
    }
    override func on(unit: Creature) {
        unit._ElementalResistance.thunder += _value
    }
    
    override func off(unit: Creature) {
        unit._ElementalResistance.thunder -= _value
    }
    override func create(level: CGFloat) {
        elementalAttrValue(level: level)
    }
}
