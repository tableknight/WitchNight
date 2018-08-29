//
//  Energetic.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Energetic: Passive {
    
    override init() {
        super.init()
        _name = "精力充沛"
        _description = "提升20%进精神"
        _quality = Quality.NORMAL
        
    }
}
