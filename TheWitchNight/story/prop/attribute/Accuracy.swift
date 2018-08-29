//
//  Accuracy.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Accuracy: Attribute {
    override init() {
        super.init()
        _name = "命中"
    }
    override func on(unit: Creature) {
        unit._extensions.accuracy += _value
    }
    
    override func off(unit: Creature) {
        unit._extensions.accuracy -= _value
    }
    override func create(level: CGFloat) {
        lowerAttrValue(level: level)
    }
}
