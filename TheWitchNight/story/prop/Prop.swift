//
//  Prop.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Prop:Core {
    var _name:String = ""
    var _description:String = ""
    var _level:CGFloat = 1
    var _img = SKTexture()
    var _price = 0
    var _sellingPrice = 0
    var _type = ""
    var _count = 1
    var _quality = Quality.NORMAL
    static var OUTFIT = "outfit"
    static var ARMOR = "outfit"
    static var WEAPON = "outfit"
//    static var AMULET = "outfit"
//    static var OUTFIT = "outfit"
//    static var OUTFIT = "outfit"
//    static var OUTFIT = "outfit"
    var hasInitialized = false
    func create() {
        hasInitialized = true
    }
    var sellingPrice:Int {
        set {
            _sellingPrice = newValue
            _price = newValue / 4
        }
        get {
            return _sellingPrice
        }
    }
    var price:Int {
        set {
            _price = newValue
            _sellingPrice = newValue * 4
        }
        get {
            return _price
        }
    }
}
