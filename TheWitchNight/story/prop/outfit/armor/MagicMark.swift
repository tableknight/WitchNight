//
//  MagicMark.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MagicMark: Armor {
    override init() {
        super.init()
        _name = "魔印"
        _outfitName = "魔印"
        _level = 1
    }
    var _spell:Spell = Spell()
    override func create(level: CGFloat) {
        _level = level
        createQuality()
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
//        _description = _spell._description
//        _level = _spell._level
        
        hasInitialized = true
        createPrice()
    }
    private var _spellAppended = false
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
    override func createPrice() {
        super.createPrice()
        price = _price * 4
    }
}
