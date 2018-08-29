//
//  Intellect.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Intellect: Attribute {
    override init() {
        super.init()
        _name = "智力"
    }
    override func on(unit: Creature) {
//        unit._mains.intellect += _value
        unit.intellectChange(value: _value)
    }
    
    override func off(unit: Creature) {
//        unit._mains.intellect -= _value
        unit.intellectChange(value: -_value)
    }
    override func create(level: CGFloat) {
        midAttrValue(level: level)
    }
}
