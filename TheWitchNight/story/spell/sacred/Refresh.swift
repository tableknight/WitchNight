//
//  Refresh.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Refresh: Passive {
    
    override init() {
        super.init()
        _name = "回溯"
        _description = "刷新其他技能的冷却时间"
        _quality = Quality.SACRED
        _tear = 3
    }
    override func cast(completion: @escaping () -> Void) {
        let ss = _battle._curRole._unit._spellsInuse
        for s in ss {
            if s != self {
                s._timeleft = 0
            }
        }
        completion()
    }
}
