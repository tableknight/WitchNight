//
//  VampireBlood.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class VampireBlood: Passive {
    
    override init() {
        super.init()
        _name = "吸血鬼血统"
        _description = "回复普通攻击造成伤害的20%"
        _quality = Quality.SACRED
        
    }
}
