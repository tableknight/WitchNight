//
//  Outfit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Outfit:Prop {
    override init() {
        super.init()
        
        _all = [STAMINA,
                STRENGTH,
                AGILITY,
                INTELLECT,
                DEFENCE,
                SPEED,
                SPIRIT,
                ACCURACY,
                AVOID,
                CRITICAL,
                HEALTH,
                MIND,
                FIREPOWER,
                FIRERESISTANCE,
                WATERPOWER,
                WATERRESISTANCE,
                THUNDERPOWER,
                THUNDERRESISTANCE,
                ELEMENTALPOWER,
                ELEMENTALRESISTANCE,
                LUCKY,
                BREAK,
                REVENGE,
                RHYTHM
        ]
        _type = Prop.OUTFIT
    }

    internal var _attrCount:Int = 0
    func create(level:CGFloat) {
        _level = level
        createQuality()
        createSelfAttrs()
        createAttrs()
        hasInitialized = true
        createPrice()
    }
    
    func sacredAttrCount() {
        _quality = Quality.SACRED
        _attrCount = seed(min: 3, max: 6)
    }
    
    func createPrice() {
        _price = seed(min: 1, max: _level.toInt() + 1) * _quality
        _sellingPrice = _price * 4
    }
    
    func createQuality() {
        let _seed = seed()
        if _seed < 70 {
            _quality = Quality.NORMAL
            _attrCount = seed(min: 1, max: 3)
        } else if _seed < 90 {
            _quality = Quality.GOOD
            _attrCount = seed(min: 2, max: 4)
        } else {
            _quality = Quality.RARE
            _attrCount = seed(min: 3, max: 6)
        }
    }
    internal var _selfAttrs:Array<Int> = []
    func createSelfAttrs() {
        for id in _selfAttrs {
            let a = getAttrById(id: id)
            let index = _all.index(of: id)
            if nil != index {
                _all.remove(at: index!)
            }
            a.create(level: self._level)
            _attrs.append(a)
        }
    }
    func createAttrs() {
        if _attrCount < 1 {
            return
        }
        for _ in 0..._attrCount - 1 {
            let index = seed(max: _all.count)
            let attr = getAttrById(id: _all[index])
            attr.create(level: _level)
            _attrs.append(attr)
            _all.remove(at: index)
        }
    }
    var _attrs = Array<Attribute>()
    internal var _all = Array<Int>()
    var STAMINA = 0
    var STRENGTH = 1
    var AGILITY = 2
    var INTELLECT = 3
    var ATTACK = 4
    var DEFENCE = 5
    var SPEED = 6
    var SPIRIT = 7
    var ACCURACY = 8
    var AVOID = 9
    var CRITICAL = 10
    var MIND = 11
    var HEALTH = 12
    var FIREPOWER = 13
    var WATERPOWER = 14
    var THUNDERPOWER = 15
    var FIRERESISTANCE = 16
    var WATERRESISTANCE = 17
    var THUNDERRESISTANCE = 18
    var ELEMENTALPOWER = 19
    var ELEMENTALRESISTANCE = 20
    var LUCKY = 21
    var BREAK = 22
    var REVENGE = 23
    var RHYTHM = 23
    var CHAOS = 23
    internal func getAttrById(id:Int) -> Attribute {
        switch id {
        case STAMINA:
            return Stamina()
        case STRENGTH:
            return Strength()
        case AGILITY:
            return Agility()
        case INTELLECT:
            return Intellect()
        case ATTACK:
            return AttackAttribute()
        case DEFENCE:
            return Defence()
        case SPEED:
            return Speed()
        case SPIRIT:
            return Spirit()
        case ACCURACY:
            return Accuracy()
        case AVOID:
            return Avoid()
        case MIND:
            return Mind()
        case CRITICAL:
            return Critical()
        case HEALTH:
            return Health()
        case LUCKY:
            return Lucky()
        case FIREPOWER:
            return FirePower()
        case WATERPOWER:
            return WaterPower()
        case THUNDERPOWER:
            return ThunderPower()
        case FIRERESISTANCE:
            return FireResistance()
        case WATERRESISTANCE:
            return WaterResistance()
        case THUNDERRESISTANCE:
            return ThunderResistance()
        case ELEMENTALPOWER:
            return ElementalPower()
        case ELEMENTALRESISTANCE:
            return ElementalResistance()
        case BREAK:
            return Break()
        case REVENGE:
            return Revenge()
        case RHYTHM:
            return Rhythm()
        case CHAOS:
            return Chaos()
        default:
            return Attribute()
        }
    }
    internal func removeAttrId(id:Int) {
        let index = _all.index(of: id)
        if nil != index {
            _all.remove(at: index!)
        }
    }
    func on() {
        for a in _attrs {
            a.on(unit: Data.instance._char)
        }
    }
    func off() {
        for a in _attrs {
            a.off(unit: Data.instance._char)
        }
    }
    
    var isRandom = false
    var _chance:Int = 0
    var _outfitName = ""
}
