//
//  IceGuard.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/19.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class IceGuard: Magical {
    override init() {
        super.init()
        _tear = 1
        _quality = Quality.RARE
        _name = "寒冰护盾"
        _description = "对己方单位释放护盾，提升100%防御，有一定几率降低攻击者10点速度"
        isTargetEmemy = false
    }
    override func cast(completion:@escaping () -> Void) {
        //        let r = _battle._curRole
        let t = _battle._selectedTarget
        //        removeSpecialStatus(t:t)
        let status = Status()
        status._type = Status.ICE_GUARD
        status._timeleft = 5
        t.addStatus(status: status)
        
        let c = _battle._curRole
        c.actionCast {
            t.actionBuff {
                completion()
                t._extensions.defence += t._unit._extensions.defence
                status.afterTimesUp = {
                    t._extensions.defence -= t._unit._extensions.defence
                    
                }
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
