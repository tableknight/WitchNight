//
//  Dagger.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/27.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Dagger: Weapon {
    override init() {
        super.init()
        _name = "匕首"
        _outfitName = "匕首"
        _attackSpeed = seed(min: 12, max: 15).toFloat() * 0.1
        _selfAttrs = [ATTACK, AVOID]
        removeAttrId(id: AVOID)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        let attr = _attrs[0]
        attr._value = attr._value * 0.5
    }
}
