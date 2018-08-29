//
//  BloodThirty.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BloodThirsty: Passive {
    
    override init() {
        super.init()
        _name = "嗜血"
        _description = "附加当前等级数值的必杀"
        _quality = Quality.GOOD
        
    }
}
