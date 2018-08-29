//
//  ProtectFromGod.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ProtectFromGod: Passive {
    
    override init() {
        super.init()
        _quality = Quality.RARE
        _name = "神之庇护"
        _description = "免疫中毒和流血"
    }
    override func beforeBattle(t:BUnit) {
        let status = Status()
        status._type = Status.PROTECT_FROM_GOD
        status._timeleft = 9999
        t.addStatus(status: status)
    }
}
