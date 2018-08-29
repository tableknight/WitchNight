//
//  Break.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Break: Attribute {
    override init() {
        super.init()
        _name = "破甲"
    }
    override func on(unit: Creature) {
        unit._break += _value
    }
    
    override func off(unit: Creature) {
        unit._break -= _value
    }
    override func create(level: CGFloat) {
        _value = seed(min: 1, max: 11).toFloat()
    }
}
