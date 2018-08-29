//
//  Core.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
class Core:NSObject{
    override init() {
        super.init()
    }
    func seed(min:Int = 0, max:Int = 101) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    func yon() -> Bool {
        return seed() < 50
    }
    func lowThan(_ i:Int) -> Bool {
        let sed = seed()
        return sed < i
    }
    
    func aQuarter() -> Bool {
        return seed() < 25
    }
}
