//
//  DarkCrow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class DarkCrow: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.8
        _stars.stamina = 1.9
        _stars.agility = 1.0
        _stars.intellect = 0.6
        _name = "大黄"
        _race = EvilType.NATURE
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Data.instance.pictureNature.getCell(0, 3, 3, 4)
        _spellsInuse = []
    }
    override func createQuality() {
        _quality = Quality.NORMAL
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        _spellCount = 1
    }
    override func protectNew() {
        
    }
}
