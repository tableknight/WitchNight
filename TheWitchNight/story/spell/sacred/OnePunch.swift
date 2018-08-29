//
//  OnePunch.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class OnePunch: Passive {
    
    override init() {
        super.init()
        _name = "玻璃大炮"
        _description = "将防御算作攻击力"
        _quality = Quality.SACRED
        
    }
    override func beforeBattle(t:BUnit) {
        let status = Status()
        status._type = Status.ONE_PUNCH
        status._timeleft = 9999
        t.addStatus(status: status)
    }
}
