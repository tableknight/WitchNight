//
//  SacredDagger.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class NightBlade: Dagger {
    override init() {
        super.init()
        _name = "夜刃"
        _level = 42
        _description = "对亡灵造成的全伤害提升25%。"
        _chance = 100
    }
    
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        _attrCount = 5
        createSelfAttrs()
        createAttrs()
        hasInitialized = true
        let attr = _attrs[0]
        attr._value = attr._value * 0.5
        createPrice()
    }
}
class LazesPedicureKnife:Dagger {
    override init() {
        super.init()
        _name = "拉兹的修脚刀"
        _description = "普通攻击有几率获得一点敏捷"
        _level = 21
        _chance = 100
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
