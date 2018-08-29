//
//  MagicSword.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MagicSword: Passive {
    
    override init() {
        super.init()
        _name = "魔剑术"
        _description = "用精神替代攻击力"
        _quality = Quality.SACRED
        
    }
    override func beforeBattle(t:BUnit) {
        let status = Status()
        status._type = Status.MAGIC_SWORD
        status._timeleft = 9999
        t.addStatus(status: status)
    }
}
