//
//  Spirit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Spirit: Attribute {
    override init() {
        super.init()
        _name = "精神"
    }
    override func on(unit: Creature) {
        unit._extensions.spirit += _value
    }
    
    override func off(unit: Creature) {
        unit._extensions.spirit -= _value
    }
    override func create(level: CGFloat) {
        upperAttrValue(level: level)
    }
}
