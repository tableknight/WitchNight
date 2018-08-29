//
//  Attribute.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Attribute: Core {
    var _name = ""
    var _value:CGFloat = 0
    func on(unit:Creature) -> Void {
        
    }
    func off(unit:Creature) -> Void {
        
    }
    func create(level:CGFloat) {
        
    }
    func getText() -> String {
        if _value < 0 {
            return "\(_name) \(_value.toInt())"
        } else {
            return "\(_name) +\(_value.toInt())"
        }
    }
     func midAttrValue(level:CGFloat) {
        var min = (level * 0.4).toInt()
        if min < 1 {
            min = 1
        }
        var max = (level * 0.8).toInt()
        if max < 1 {
            max = 1
        }
        _value = seed(min: min, max: max).toFloat()
    }
     func upperAttrValue(level:CGFloat) {
        var min = (level * 0.8).toInt()
        if min < 1 {
            min = 1
        }
        var max = (level * 1.2).toInt()
        if max < 1 {
            max = 1
        }
        _value = seed(min: min, max: max).toFloat()
    }
    
     func elementalAttrValue(level:CGFloat) {
        _value = seed(min: 5, max: 11).toFloat()
    }
     func lowerAttrValue(level:CGFloat) {
        var min = (level * 0.2).toInt()
        if min < 1 {
            min = 1
        }
        var max = (level * 0.4).toInt()
        if max < 1 {
            max = 1
        }
        _value = seed(min: min, max: max).toFloat()
    }
}
