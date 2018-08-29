//
//  TurnAttack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class TurnAttack: Magical {
    override init() {
        super.init()
        _tear = 1
        _quality = Quality.SACRED
        _name = "攻击吸收"
        _description = "对己方单位释放护盾，将下一次物理伤害转化为生命回复"
        isTargetEmemy = false
    }
    override func cast(completion:@escaping () -> Void) {
//        let r = _battle._curRole
        _timeleft = 2
        let t = _battle._selectedTarget
        removeSpecialStatus(t:t)
        let status = Status()
        status._type = Status.TURN_ATTACK
        status._timeleft = 2
        t.addStatus(status: status)
        
        let c = _battle._curRole
        c.actionCast {
            t.actionBuff {
                completion()
            }
        }
        
    }
    override func findTarget(inleft: Bool = false) {
        let b = _battle!
        if b._curRole.inleft {
            b._selectedTarget = b._leftRoles[seed(max: b._leftRoles.count)]
        } else {
            b._selectedTarget = b._rightRoles[seed(max: b._rightRoles.count)]
        }
//        b._selectedTarget = b._curRole
    }
}
