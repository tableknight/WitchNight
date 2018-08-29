//
//  Shield.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Shield: Armor {
    override init() {
        super.init()
        _name = "盾牌"
        _outfitName = "盾牌"
        _selfAttrs = [DEFENCE]
        removeAttrId(id: DEFENCE)
    }
    override func sacredAttrCount() {
        _quality = Quality.SACRED
        _attrCount = seed(min: 3, max: 5)
    }
}

