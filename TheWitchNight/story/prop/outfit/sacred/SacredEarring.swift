//
//  SacredEarring.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/8/13.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class VerdasTear: EarRing {
    override init() {
        super.init()
        _value = seed(min: 25, max: 31)
        _name = "维尔达之泪"
        _description = "提升\(_value)点法术抵抗"
        _level = 30
        _chance = 80
    }
    override func createQuality() {
        sacredAttrCount()
    }
    private var _value:Int = 0
    override func on() {
        super.on()
        Data.instance._char._magical.resistance += _value.toFloat()
    }
    override func off() {
        super.off()
        Data.instance._char._magical.resistance -= _value.toFloat()
    }
}

class DeepSeaPearl: EarRing {
    override init() {
        super.init()
        _value = seed(min: 10, max: 16)
        _name = "深海珍珠"
        _description = "提升\(_value)点法术伤害"
        _level = 15
        _chance = 100
    }
    override func createQuality() {
        sacredAttrCount()
    }
    private var _value:Int = 0
    override func on() {
        super.on()
        Data.instance._char._magical.damage += _value.toFloat()
    }
    override func off() {
        super.off()
        Data.instance._char._magical.damage -= _value.toFloat()
    }
}

class EyeOfDius: EarRing {
    override init() {
        super.init()
        _value = seed(min: 8, max: 12)
        _name = "迪乌斯之眼"
        _description = "提升\(_value)%最大生命"
        _level = 32
        _chance = 30
    }
    override func createQuality() {
        sacredAttrCount()
    }
    private var _value:Int = 0
    private var _plus:CGFloat = 0
    override func on() {
        super.on()
        let char = Data.instance._char!
        _plus = char._extensions.health * _value.toFloat() * 0.01
        char._extensions.health += _plus
    }
    override func off() {
        super.off()
        let char = Data.instance._char!
        char._extensions.health -= _plus
        if char._extensions.hp > char._extensions.health {
            char._extensions.hp = char._extensions.health
        }
    }
}

class LavaCrystal: EarRing {
    override init() {
        super.init()
        _name = "熔岩结晶"
        _description = "提升50%单体火焰法术伤害"
        _level = 50
        _chance = 15
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
