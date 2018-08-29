//
//  SoulStone.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/28.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SoulStone: Armor {
    override init() {
        super.init()
        _name = "灵魂石"
        _outfitName = "灵魂石"
    }
    var _race = EvilType.MAN
//    var _backup = EvilType.MAN
    override func create() {
        _quality = Quality.NORMAL
        _race = seed(min: 1, max: 6)
        _description = "将种族转换为\(EvilType.getTypeLabel(type: _race))。"
        hasInitialized = true
        createPrice()
    }
    override func on() {
        super.on()
//        _backup = Data.instance._char._race
        Data.instance._char._race = _race
    }
    
    override func off() {
        super.off()
        let c = Data.instance._char!
//        c._race = _backup
        if c._leftRing is RingOfDead || c._rightRing is RingOfDead {
            c._race = EvilType.RISEN
        } else {
            c._race = EvilType.MAN
        }
    }
}

