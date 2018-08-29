//
//  TruePower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/21.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TruePower: Passive {
    
    override init() {
        super.init()
        _name = "全力以赴"
        _description = "提升30%普通攻击伤害"
        _quality = Quality.RARE
        
    }

}
