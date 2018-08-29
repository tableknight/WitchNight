//
//  IUnit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
protocol IUnit {
    func getMains() -> Mains
    func getExts() -> Extensions
    func getPpties() -> Properties
    func getQuality() -> Int
    func getSpells() -> Array<Spell>
    func getCarrys() -> Carrys
}
