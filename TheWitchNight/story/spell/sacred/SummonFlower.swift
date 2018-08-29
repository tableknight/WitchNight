//
//  SummonFlower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SummonFlower: Magical {
    override init() {
        super.init()
        isWater = true
        _name = "生命之花"
        _description = "召唤生命之花，生命之花会在行动结束后治疗相邻单位，恢复其15%最大生命，持续5回合"
        _rate = 0.8
        _quality = Quality.SACRED
        _cooldown = 5
    }
    override func cast(completion:@escaping () -> Void) {
        
    }
    
    
    
}
