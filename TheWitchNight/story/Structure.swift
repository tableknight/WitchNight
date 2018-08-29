//
//  Structure.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
struct Mains {
    var stamina:CGFloat = 0
    var strength:CGFloat = 0
    var agility:CGFloat = 0
    var intellect:CGFloat = 0
}
struct Extensions {
    var attack:CGFloat
    var defence:CGFloat
    var speed:CGFloat
    var accuracy:CGFloat
    var critical:CGFloat
    var avoid:CGFloat
    var spirit:CGFloat
    var hp:CGFloat
    var mp:CGFloat
    var health:CGFloat
    var mind:CGFloat
}
struct Elemental {
    var fire:CGFloat
    var water:CGFloat
    var thunder:CGFloat
}
struct Magic {
    var damage:CGFloat
    var resistance:CGFloat
}
struct Properties {
    var level:CGFloat
    var name:String
    var race:Int
    var exp:CGFloat
    var expNext:CGFloat
    var restPoint:CGFloat
}
struct SpellSlot {
    var max:Int
    var min:Int
}
struct Carrys {
    var slot:Int
}
