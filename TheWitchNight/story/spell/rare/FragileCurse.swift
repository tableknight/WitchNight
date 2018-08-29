//
//  FragileCurse.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FragileCurse: Magical {
    override init() {
        super.init()
        _name = "虚弱诅咒"
        _description = "65%几率降低目标50%防御"
        _quality = Quality.RARE
        _cooldown = 2
    }
    override func cast(completion:@escaping () -> Void) {
        let t = _battle._selectedTarget
        let c = _battle._curRole
        let this = self
        c.actionCast {
            if !this.statusMissed(baseline: 65, target: t, completion: completion) {
                t.actionCursed {
                    let s = Status()
                    s._timeleft = this.getTimeleft()
                    s._type = Status.FRAGILE
                    t.addStatus(status: s)
                    completion()
                }
            }
        }
    }
    
    override func findTarget(inleft:Bool = false) {
        findSingleTargetNotBlocked(inleft: _battle._curRole.inleft)
    }
}
