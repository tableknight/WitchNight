//
//  Wand.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Wand: Weapon {
    override init() {
        super.init()
        isClose = false
        _name = "法杖"
        _outfitName = "法杖"
        _attackSpeed = seed(min: 9, max: 12).toFloat() * 0.1
        _selfAttrs = [ATTACK, SPIRIT]
        removeAttrId(id: SPIRIT)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        let attr = _attrs[1]
        attr._value = attr._value * 1.4
    }
}
