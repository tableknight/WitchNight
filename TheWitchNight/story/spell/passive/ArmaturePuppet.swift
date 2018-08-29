//
//  ArmaturePuppet.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ArmaturePuppet: Passive {
    
    override init() {
        super.init()
        _name = "针刺傀儡"
        _description = "无法行动，反弹100%近战物理攻击。"
        _quality = Quality.SACRED
        
    }
}
