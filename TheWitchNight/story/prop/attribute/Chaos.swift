//
//  Chaos.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/6/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Chaos: Attribute {
    override init() {
        super.init()
        _name = "抗混乱"
    }
    override func on(unit: Creature) {
        unit._chaos += _value
    }
    
    override func off(unit: Creature) {
        unit._chaos -= _value
    }
    override func create(level: CGFloat) {
        _value = seed(min: 1, max: 6).toFloat()
    }
}

