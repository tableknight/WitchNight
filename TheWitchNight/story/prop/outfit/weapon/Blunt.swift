//
//  Blunt.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Blunt: Weapon {
    override init() {
        super.init()
        _name = "钝器"
        _outfitName = "钝器"
        _attackSpeed = seed(min: 8, max: 11).toFloat() * 0.1
        _selfAttrs = [ATTACK, CRITICAL]
        removeAttrId(id: CRITICAL)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        let attr = _attrs[0]
        attr._value = attr._value * 2
    }
}
