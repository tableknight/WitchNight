//
//  Focus.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Focus: Passive {
    
    override init() {
        super.init()
        _name = "精神集中"
        _description = "提升全队20点命中"
        _quality = Quality.NORMAL
        
    }
}
