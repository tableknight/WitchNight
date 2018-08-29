//
//  SacredBow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/31.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Hawkeye:Bow {
    override init() {
        super.init()
        _name = "鹰眼"
        _description = "攻击无法被闪避"
        _level = 45
        _chance = 50
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class Boreas:Bow {
    override init() {
        super.init()
        _name = "北风之神"
        _description = "使你的攻击力翻倍"
        _level = 55
        _chance = 100
    }
    override func createQuality() {
        sacredAttrCount()
        _attackSpeed = seed(min: 5, max: 9).toFloat() * 0.1
    }
}
class Skylark:Bow {
    override init() {
        super.init()
        _name = "云雀"
        _description = "射出的箭发出一种云雀的叫声"
        _level = 31
        _chance = 100
    }
    override func createQuality() {
        sacredAttrCount()
        _attackSpeed = 1.5
    }
}

class SoundOfWind:Bow {
    override init() {
        super.init()
        _name = "风声"
        _description = "闪避 +40"
        _level = 66
        removeAttrId(id: AVOID)
        _chance = 80
    }
    override func createQuality() {
        sacredAttrCount()
    }
    override func on() {
        super.on()
        Data.instance._char._extensions.avoid += 40
    }
    override func off() {
        super.off()
        Data.instance._char._extensions.avoid -= 40
    }
}
