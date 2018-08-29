//
//  SacredInstrument.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TheMonatNotes:Instrument {
    override init() {
        super.init()
        _name = "莫纳手记"
        _description = "该法器提供的技能可以被两个角色使用"
        _level = 52
        _chance = 30
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class NoPants:Instrument {
    override init() {
        super.init()
        _name = "真空"
        _description = "施法时有一定几率走光"
        _level = 12
        _chance = 100
    }
    override func createQuality() {
        sacredAttrCount()
    }
}

