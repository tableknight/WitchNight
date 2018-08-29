
//
//  Slime.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/28.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
class Slime: Rizen {
    override init() {
        super.init()
        _stars.stamina = 2.8
        _stars.strength = 1.5
        _stars.agility = 0.8
        _stars.intellect = 0.8
        _name = EvilName.Slime
        _img = SKTexture(imageNamed: EvilImage.Slime)
        _moveSpeed = 12
        _spellSlot = SpellSlot(max: 1, min: 0)
        
    }

}
