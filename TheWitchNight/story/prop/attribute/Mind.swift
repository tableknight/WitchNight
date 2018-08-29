//
//  Resistance.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Mind: Attribute {
    override init() {
        super.init()
        _name = "念力"
    }
    override func on(unit: Creature) {
        unit._extensions.mind += _value
    }
    
    override func off(unit: Creature) {
        unit._extensions.mind -= _value
    }
    override func create(level: CGFloat) {
        lowerAttrValue(level: level)
    }
}
