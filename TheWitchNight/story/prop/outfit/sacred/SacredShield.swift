//
//  SacredShield.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Faceless:Shield {
    override init() {
        super.init()
        _name = "无面者"
        _description = "每三个回合释放一次法术反射。"
        _level = 30
        _chance = 30
    }
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        _attrCount = 4
        createSelfAttrs()
        createAttrs()
        hasInitialized = true
        createPrice()
    }
}
class Accident:Shield {
    override init() {
        super.init()
        _name = "无妄之灾"
        _description = "将所有受到的法术伤害转移给队友"
        _level = 42
        _chance = 40
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class FrancisFace:Shield {
    override init() {
        super.init()
        _name = "佛朗西斯的面容"
        _description = "受到伤害时有一定几率获得+5暴击"
        _level = 40
        _chance = 25
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class EvilExpel:Shield {
    override init() {
        super.init()
        _name = "辟邪"
        _description = "有一定几率低挡来自恶魔的伤害"
        _level = 63
        _chance = 50
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
