//
//  Mummy.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/28.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
class Mummy: Rizen {
    override init() {
        super.init()
        _stars.strength = 2.0
        _stars.stamina = 2.0
        _stars.agility = 1.0
        _stars.intellect = 1.0
        _name = EvilName.Mummy
        _race = EvilType.RISEN
        _img = SKTexture(imageNamed: EvilImage.Mummy)
        _moveSpeed = 8
        _spellSlot = SpellSlot(max: 1, min: 0)
//        _spells = [FeignAttack()]
    }
}
