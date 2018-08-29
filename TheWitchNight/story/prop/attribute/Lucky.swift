//
//  Lucky.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Lucky: Attribute {
    override init() {
        super.init()
        _name = "幸运"
    }
    override func on(unit: Creature) {
        unit._lucky += _value
    }
    
    override func off(unit: Creature) {
        unit._lucky -= _value
    }
    override func create(level: CGFloat) {
        _value = seed(min: 1, max: 11).toFloat()
    }
}
