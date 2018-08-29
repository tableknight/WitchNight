//
//  BargeAbout.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BargeAbout: Passive {
    
    override init() {
        super.init()
        _name = "横冲直撞"
        _description = "降低100点命中，提升100点必杀"
        _quality = Quality.NORMAL
        
    }
}
