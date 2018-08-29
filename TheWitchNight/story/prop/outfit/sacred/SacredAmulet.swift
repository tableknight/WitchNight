//
//  SacredAmulet.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TrueLie: Amulet {
    override init() {
        super.init()
        _name = "真实的谎言"
        _description = "获得一个额外的技能栏"
        _level = 68
        _chance = 5
    }
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        _attrCount = 3
        createSelfAttrs()
        createAttrs()
        hasInitialized = true
        createPrice()
    }
    override func on() {
        super.on()
        Data.instance._char._spellCount += 1
    }
    
    override func off() {
        super.off()
        let c = Data.instance._char!
        if c._spellsInuse.count >= c._spellCount {
            let last = c._spellsInuse.popLast()
            c._spells.append(last!)
        }
        c._spellCount -= 1
    }
}

class MedalOfCourage:Amulet {
    override init() {
        super.init()
        _name = "勇气勋章"
        _level = 20
        _chance = 100
    }
    
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        _attrCount = 7
        createAttrs()
        hasInitialized = true
        createPrice()
    }
}

class FangOfVampire:Amulet {
    override init() {
        super.init()
        _name = "吸血鬼獠牙"
        _description = "提升所有攻击吸血效果100%。"
        _level = 35
        _chance = 75
    }
    
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        _attrCount = 3
        createSelfAttrs()
        createAttrs()
        hasInitialized = true
        createPrice()
    }
}
class MoonShadow:Amulet {
    override init() {
        super.init()
        _name = "月影"
        _agl = seed(min: 30, max: 36).toFloat()
        _level = 35
        _description = "提升\(_agl)点敏捷"
        removeAttrId(id: AGILITY)
        _chance = 60
    }
    var _agl:CGFloat = 0
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        hasInitialized = true
        _attrCount = seed(min: 3, max: 5)
        createSelfAttrs()
        createAttrs()
        createPrice()
    }
    override func on() {
        super.on()
        Data.instance._char.agilityChange(value: _agl)
    }
    override func off() {
        super.off()
        Data.instance._char.agilityChange(value: -_agl)
    }
}
class EternityNight:Amulet {
    override init() {
        super.init()
        _name = "永夜"
        _chaos = seed(min: 20, max: 26).toFloat()
        _level = 28
        _description = "提升\(_chaos)点混乱"
        removeAttrId(id: CHAOS)
        _chance = 80
    }
    var _chaos:CGFloat = 0
    override func createQuality() {
        sacredAttrCount()
    }
    override func on() {
        super.on()
        Data.instance._char._chaos += _chaos
    }
    override func off() {
        super.off()
        Data.instance._char._chaos -= _chaos
    }
}
class Sparkling:Amulet {
    override init() {
        super.init()
        _name = "群星闪耀"
        _value = seed(min: 20, max: 26).toFloat()
        _description = "提升\(_value)点幸运"
        _level = 25
        removeAttrId(id: LUCKY)
        _chance = 100
    }
    var _value:CGFloat = 0
    override func createQuality() {
        sacredAttrCount()
    }
    override func on() {
        super.on()
        Data.instance._char._lucky += _value
    }
    override func off() {
        super.off()
        Data.instance._char._lucky -= _value
    }
}
class MedalOfHero:Amulet {
    override init() {
        super.init()
        _name = "英雄勋章"
        _description = "战斗中低挡一次致命伤害"
        _level = 18
        _chance = 100
    }
    override func createQuality() {
        sacredAttrCount()
        _attrCount = 4
    }
}
class JadeHeart:Amulet {
    override init() {
        super.init()
        _name = "翡翠之心"
        _description = "降低来自首领的伤害"
        _level = 43
        _chance = 20
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
