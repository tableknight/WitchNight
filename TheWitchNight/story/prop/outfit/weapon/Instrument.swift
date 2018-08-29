//
//  Instrument.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Instrument: Weapon {
    override init() {
        super.init()
        _name = "法器"
        _outfitName = "法器"
        _attackSpeed = 1.0
        _selfAttrs = [SPIRIT]
    }
    override func create(level: CGFloat) {
        _level = level
        createQuality()
        createSelfAttrs()
        hasInitialized = true
    
        _attrs[0]._value *= 2
        var spellAttay = Array<Int>()
        let l = Loot()
        if _quality == Quality.NORMAL {
            spellAttay = l._normalSpellArray
            _spell = l.getNormalSpell(id: spellAttay.one())
        } else if _quality == Quality.GOOD {
            spellAttay = l._goodSpellArray
            _spell = l.getGoodSpell(id: spellAttay.one())
        } else if _quality == Quality.RARE {
            spellAttay = l._rareSpellArray
            _spell = l.getRareSpell(id: spellAttay.one())
        } else {
            spellAttay = l._sacredSpellArray
            _spell = l.getSacredSpell(id: spellAttay.one())
        }
//        if _level < _spell._level {
//            _level = _spell._level
//        }
        _description = "[" + _spell._name + "]"
        createPrice()
        _price *= 4
        _sellingPrice *= 4
        
    }
    private func getName() -> String {
        let names = ["颌骨","水晶","灵珠","魔首"]
        return names.one()
    }
    var _spellAppended = false
    var _spell = Spell()
    override func on() {
        let char = Data.instance._char
        if !(char?.hasSpell(spell: _spell))! {
            char?._spells.append(_spell)
            _spellAppended = true
        }
    }
    override func off() {
        if _spellAppended {
            let char = Data.instance._char
            char?.removeSpell(spell: _spell)
            _spellAppended = false
        }
    }
}
