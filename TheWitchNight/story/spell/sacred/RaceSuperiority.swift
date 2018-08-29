//
//  RaceSuperiority.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class RaceSuperiority: Passive {
    
    override init() {
        super.init()
        _quality = Quality.SACRED
        _name = "种族优势"
        _description = "免疫冰冻、"
    }
    override func beforeBattle(t:BUnit) {
        let status = Status()
        status._type = Status.RACE_SUPERIORITY
        status._timeleft = 9999
        t.addStatus(status: status)
    }
}
