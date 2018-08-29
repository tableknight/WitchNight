//
//  SacredSoulStone.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/5.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class HeartOfSwamp: SoulStone {
    override init() {
        super.init()
        _name = "沼泽之心"
        _description = "种族转换为生灵。"
        _level = 50
        _selfAttrs = [MIND]
        _race = EvilType.NATURE
        _chance = 30
    }
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
//        _race = EvilType.NATURE
        createSelfAttrs()
        _attrs[0]._value = 25
        hasInitialized = true
        createPrice()
    }
}
class PandoraHearts:SoulStone {
    override init() {
        super.init()
        _name = "潘多拉之心"
        _description = "随机获取一个未获得的神之技"
        _level = 55
        _race = EvilType.DEMON
        _chance = 0
    }
    var _spell = Spell()
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        hasInitialized = true
        let unSavedSpells = Array<Spell>()
        _spell = unSavedSpells.one()
        createPrice()
    }
    override func on() {
        super.on()
        Data.instance._char._spells.append(_spell)
    }
    override func off() {
        super.off()
        Data.instance._char.removeSpell(spell: _spell)
    }
}
class HeartOfTarrasque:SoulStone {
    override init() {
        super.init()
        _name = "魔龙之心"
        _description = "提升重生的治疗效果100%"
        _level = 58
        _race = EvilType.NATURE
        _chance = 40
    }
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        hasInitialized = true
        createPrice()
    }
}

