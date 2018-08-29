//
//  Immune.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/22.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Immune: Magical {
    override init() {
        super.init()
        _tear = 1
        _name = "免疫"
        _description = "目标在本回合内，免疫所有控制和诅咒"
        isTargetAll = true
        _quality = Quality.SACRED
    }
    override func cast(completion:@escaping () -> Void) {
        let c = _battle._curRole
        let t = _battle._selectedTarget
        let status = Status()
        status._type = Status.IMMUNE
        status._timeleft = 2
        status.inEndOfRound = {
            t.removeStatus(type: Status.IMMUNE)
        }
        t.addStatus(status: status)
        c.actionCast {
            t.actionBuff {
                completion()
            }
        }
    }
    
}

