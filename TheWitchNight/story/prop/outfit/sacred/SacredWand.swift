//
//  SacredWand.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LightingRod:Wand {
    override init() {
        super.init()
        _name = "避雷针"
        _description = "降低50点雷电抗性，提升50点雷电伤害"
        _level = 31
        removeAttrId(id: THUNDERPOWER)
        removeAttrId(id: THUNDERRESISTANCE)
        _chance = 80
    }
    override func createQuality() {
        sacredAttrCount()
        
    }
    override func on() {
        super.on()
        Data.instance._char._ElementalPower.thunder += 50
        Data.instance._char._ElementalResistance.thunder -= 50
    }
    override func off() {
        super.off()
        Data.instance._char._ElementalPower.thunder -= 50
        Data.instance._char._ElementalResistance.thunder += 50
    }
}
class FireMaster:Wand {
    override init() {
        super.init()
        _name = "驭火者"
        _description = "降低所有火系法术1的冷却回合"
        _level = 51
        _chance = 15
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class WitchWand:Wand {
    override init() {
        super.init()
        _name = "巫毒法杖"
        _description = "诅咒不再有冷却时间"
        _level = 63
        _chance = 35
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class PuppetMaster:Wand {
    override init() {
        super.init()
        _name = "大傀儡师"
        _description = "增加一个可作战的傀儡单位"
        _level = 76
        _chance = 5
    }
    override func createQuality() {
        sacredAttrCount()
    }
    override func on() {
        super.on()
        Data.instance._char._minionsCount += 1
    }
    override func off() {
        super.off()
        let char =  Data.instance._char!
        char._minionsCount -= 1
        let minions = char.getReadyMinions()
        if minions.count > char._minionsCount {
            minions[0]._seat = BUnit.STAND_BY
        }
    }
}
