//
//  Firelord.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Firelord: Passive {
    
    override init() {
        super.init()
        _name = "火焰领主"
        _description = "提升全队20点火焰抗性和20点火焰伤害"
        _quality = Quality.RARE
        
    }
    override func beforeBattle(t:BUnit) {
        let status = Status()
        status._type = Status.FIRE_LORD
        status._timeleft = 9999
        t.addStatus(status: status)
    }
}
