//
//  SacredBlunt.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class IberisThignbone:Blunt {
    override init() {
        super.init()
        _name = "伊比利斯的大腿骨"
        _critical = seed(min: 40, max: 51).toFloat()
        _description = "提升\(_critical)点暴击"
        removeAttrId(id: CRITICAL)
        _chance = 90
    }
    var _critical:CGFloat = 0
    override func createQuality() {
        sacredAttrCount()
    }
    override func on() {
        super.on()
        Data.instance._char._extensions.critical += _critical
    }
    override func off() {
        super.off()
        Data.instance._char._extensions.critical -= _critical
    }
}
class GiantFang:Blunt {
    override init() {
        super.init()
        _name = "巨牙"
        _description = "攻击吸血"
        _level = 42
        _chance = 60
    }
    override func createQuality() {
        sacredAttrCount()
    }
}

class ThorsHammer:Blunt {
    override init() {
        super.init()
        _name = "雷神之锤"
        _description = "提升闪电伤害100%"
        _level = 48
        _chance = 30
    }
    override func createQuality() {
        sacredAttrCount()
    }
}

class HolyPower:Blunt {
    override init() {
        super.init()
        _name = "神圣力量"
        _description = "对亡灵的伤害提升100%"
        _level = 65
        _chance = 35
    }
    override func createQuality() {
        sacredAttrCount()
    }
}

class IdyllssHand:Blunt {
    override init() {
        super.init()
        _name = "埃迪斯之手"
        _description = "攻击之后有一定几率再次攻击"
        _level = 71
        _chance = 5
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
