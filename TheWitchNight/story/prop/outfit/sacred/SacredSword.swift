//
//  DragonSlayer.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class NewSwordPlus: Sword {
    override init() {
        super.init()
        _attackSpeed = 1.1
        _name = "冒险之剑(改)"
        _description = "冒险者最梦寐以求的武器。"
        hasInitialized = true
        price = 10
        
        _chance = 100
    }
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        let atk = AttackAttribute()
        atk._value = 10
        _attrs.append(atk)
        
        let str = Strength()
        str._value = 10
        _attrs.append(str)
        
        let sta = Stamina()
        sta._value = 10
        _attrs.append(sta)
        
        let agl = Agility()
        agl._value = 10
        _attrs.append(agl)
        
        let int = Intellect()
        int._value = 10
        _attrs.append(int)
        createPrice()
    }
}
class NewSword: Sword {
    override init() {
        super.init()
        _attackSpeed = 1.1
        _name = "冒险之剑"
        _description = "冒险者最梦寐以求的武器。"
        hasInitialized = true
        price = 1
        _chance = 100
    }
    override func create(level:CGFloat) {
        _quality = Quality.NORMAL
        let atk = AttackAttribute()
        atk._value = 2
        _attrs.append(atk)
        
        let str = Strength()
        str._value = 2
        _attrs.append(str)
        
        let sta = Stamina()
        sta._value = 2
        _attrs.append(sta)
        
        let agl = Agility()
        agl._value = 2
        _attrs.append(agl)
        
        let int = Intellect()
        int._value = 2
        _attrs.append(int)
        createPrice()
    }
}
class DragonSlayer: Sword {
    override init() {
        super.init()
        _name = "屠龙者"
        _description = "对龙类造成的全伤害提升100%。"
        _level = 65
        _chance = 15
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class DragonSaliva: Sword {
    override init() {
        super.init()
        _name = "龙涎剑"
        _description = "普通攻击附带30%的火焰伤害。"
        _level = 81
        _chance = 10
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class TheExorcist:Sword {
    override init() {
        super.init()
        _name = "驱魔剑"
        _description = "攻击亡灵时有一定几率直接杀死"
        _level = 43
        _chance = 35
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class BloodBlade:Sword {
    override init() {
        super.init()
        _name = "血刃"
        _description = "生命值越低，攻击力越高"
        _level = 61
        _chance = 25
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class ElementalSword:Sword {
    override init() {
        super.init()
        _name = "元素剑"
        _description = "提升所有元素伤害"
        _level = 33
        _chance = 65
    }
    override func createQuality() {
        sacredAttrCount()
    }
}

