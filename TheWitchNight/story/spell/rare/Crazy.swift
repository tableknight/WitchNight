//
//  Crazy.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Crazy: Passive {
    
    override init() {
        super.init()
        _quality = Quality.RARE
        _name = "疯狂"
        _description = "角色不受控制，行动开始对随机目标造成攻击200%的物理伤害"
    }

}
