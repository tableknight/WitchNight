//
//  Status.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Status:Core {
    override init() {
        super.init()
    }
    var _timeleft:Int = 0
    var _type:String = ""
    var _name = ""
    var _description = ""
    var _img = SKTexture()
    var _source = BUnit()
    var afterTimesUp = {}
    var inEndOfRound = {}
    static let TURN_ATTACK = "turn_status"
    static let ATTACK_RETURN_BACK = "attack_return_back"
    static let FREEZING = "freezing"
    static let FRAGILE = "fragile"
    static let TAUNTED = "taunted"
    static let VAMPIRE_BLOOD = "vampire_blood"
    static let CRAZY = "crazy"
    static let DANCING_ON_ICE = "dancing_on_ice"
    static let BARGE_ABOUTR = "barge_about"
    static let BLOOD_THIRSTY = "blood_thirsty"
    static let ARMATURE_PUPPET = "armature_puppet"
    static let MIGHT_OF_OAKS = "might_of_oaks"
    static let BELLICOSE = "bellicose"
    static let CRUEL = "cruel"
    static let REBORN = "reborn"
    static let RACE_SUPERIORITY = "race_superiorty"
    static let PROTECT_FROM_GOD = "protect_from_god"
    static let FIRE_LORD = "fire_lord"
    static let FOCUS = "focus"
    static let ONE_PUNCH = "one_punch"
    static let MAGIC_SWORD = "magic_sword"
    static let EYE_TO_EYE = "eye_to_eye"
    static let TURN_MAGIC = "turn_magic"
    static let DEATH_STRIKE_UP = "death_strike_up"
    static let DEATH_STRIKE_DOWN = "death_strike_down"
    static let DISAPPEAR = "disappear"
    static let ICE_SHIELD = "ice_shield"
    static let ICE_GUARD = "ice_guard"
    static let LOST_SEPPD = "lost_speed"
    static let IMMUNE = "immune"
    static let DOMINATE = "dominate"
    
    static let FIRE_ENERGE = "fire_energe"
    static let WATER_ENERGE = "water_energe"
    static let THUNDER_ENERGE = "thunder_energe"
    static let TIME_REDUCE = "time_reduce"
    static let PHYSICAL_POWER = "physical_power"
    static let MAGICAL_POWER = "magical_power"
    static let ATTACK_POWER = "attack_power"
    static let DEFENCE_POWER = "defence_power"
    static let MIND_POWER = "mind_power"
    static let LUCKY_POWER = "lucky_power"
    static let SPEED_POWER = "speed_power"
    
}

class FireEnerge:Status {
    override init() {
        super.init()
        _type = Status.FIRE_ENERGE
        _name = "火源守护"
        _description = "提升50点火焰伤害和50点火焰抗性"
    }
}
class WaterEnerge:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "寒冰守护"
        _description = "提升50点冰冷伤害和50点冰冷抗性。"
    }
}
class ThunderEnerge:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "雷鸣守护"
        _description = "提升50点雷电伤害和50点雷电抗性。"
    }
}
class TimeReduce:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "时空扭转"
        _description = "减少所有技能1回合冷却时间。"
    }
}
class PhysicalPower:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "无坚不摧之力"
        _description = "提升50%造成物理伤害。"
    }
}
class MagicalPower:Status {
    override init() {
        super.init()
        _type = Status.WATER_ENERGE
        _name = "黑暗降临"
        _description = "提升50%造成法术伤害。"
    }
}
class AttackPower:Status {
    override init() {
        super.init()
        _type = Status.THUNDER_ENERGE
        _name = "战争之神"
        _description = "提升50点攻击力和25点必杀。"
    }
}
class DefencePower:Status {
    override init() {
        super.init()
        _type = Status.DEFENCE_POWER
        _name = "守护之神"
        _description = "提升50点防御和25点闪避。"
    }
}
class MindPower:Status {
    override init() {
        super.init()
        _type = Status.MIND_POWER
        _name = "智慧之神"
        _description = "提升25点念力。"
    }
}
class LuckyPower:Status {
    override init() {
        super.init()
        _type = Status.LUCKY_POWER
        _name = "幸运之神"
        _description = "提升25点幸运。"
    }
}
class SpeedPower:Status {
    override init() {
        super.init()
        _type = Status.SPEED_POWER
        _name = "光影之神"
        _description = "提升50点速度和25点命中。"
    }
}

class LostSpeed:Status {
    override init() {
        super.init()
        _type = Status.LOST_SEPPD
        let this = self
        afterTimesUp = {
            this._source._extensions.speed += 10
            debug("速度恢复")
        }
    }
}
