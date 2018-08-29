//
//  Creature.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
class Creature: Unit {
    
    
    override init() {
        super.init()
    }
    var _quality:Int = Quality.NORMAL
    
    var _stars:Mains = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _growth:Mains = Mains(stamina: 0, strength: 0, agility: 0, intellect: 0)
    var _spellSlot:SpellSlot = SpellSlot(max: 0, min: 0)
    var _spellCount = 2
    var _moveSpeed:CGFloat = 0

    func beMore() -> Bool {
        let sed = seed(max: 100)
        if _quality >= Int(sed / 25) {
            return true
        }
        
        return false
    }
    func extraProperty(value: CGFloat) -> CGFloat {
        let size = seed(max: Int(value * 10))
        let value = CGFloat(size) * 0.01
        if beMore() {
            return value
        } else {
            return -value
        }
    }
    func createQuality() {
        let sed = seed()
        if sed < 50 {
            _quality = Quality.NORMAL
        } else if sed < 80 {
            _quality = Quality.GOOD
        } else if sed < 96 {
            _quality = Quality.RARE
        } else {
            _quality = Quality.SACRED
        }
    }
    func create(level:CGFloat) {
        _level = level
        createQuality()
        _growth.stamina = _stars.stamina + extraProperty(value: _stars.stamina)
        _growth.strength = _stars.strength + extraProperty(value: _stars.strength)
        _growth.agility = _stars.agility + extraProperty(value: _stars.agility)
        _growth.intellect = _stars.intellect + extraProperty(value: _stars.intellect)
        protectNew()
        levelTo(level: level)
        _extensions.hp = _extensions.health
        _slot = seed(min: _spellSlot.min, max: _spellSlot.max + 1)
        _spellCount = _slot
    }
    func protectNew() {
        if _level < 10 {
            let initMax:CGFloat = 1.2
            if _growth.stamina > initMax {
                _growth.stamina = initMax
            }
            if _growth.strength > initMax {
                _growth.strength = initMax
            }
            if _growth.agility > initMax {
                _growth.agility = initMax
            }
            if _growth.intellect > initMax {
                _growth.intellect = initMax
            }
        }
    }
    func levelTo(level:CGFloat) {
        staminaChange(value: (level + 10) * _growth.stamina)
        strengthChange(value: (level + 10) * _growth.strength)
        agilityChange(value: (level + 10) * _growth.agility)
        intellectChange(value: (level + 10) * _growth.intellect)
        _level = level
        for _ in 1...level.toInt() {
            let sd = seed()
            if sd < 25 {
                staminaChange(value: 1)
            } else if sd < 50 {
                strengthChange(value: 1)
            } else if sd < 75 {
                agilityChange(value: 1)
            } else {
                intellectChange(value: 1)
            }
        }
    }
    
    func levelup() {
        staminaChange(value: _growth.stamina)
        strengthChange(value: _growth.strength)
        agilityChange(value: _growth.agility)
        intellectChange(value: _growth.intellect)
        _level += 1
        _leftPoint += 1
        _extensions.hp = _extensions.health
    }
    
    func expUp(up:CGFloat) {
        _exp += up
        let en = expNext()
        if _exp >= en {
            levelup()
            _exp = 0
        }
    }
    var _sensitive = 33
    var _weapon:Weapon = Weapon()
    var _seat = BUnit.STAND_BY
    var isMainChar = false
    //矩阵图第三行和第四行特殊
    var specialUnit = false
    var hasAction = true
}
