//
//  Lighting.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Lighting: Passive {
    
    override init() {
        super.init()
        _name = "落雷"
        isMagical = true
        isThunder = true
        _quality = Quality.RARE
        _description = "行动结束时对随机敌方目标造成雷击,雷击造成精神50%的雷电伤害"
        _rate = 0.5
        hasAfterMoveAction = true
    }
    override func afterMove(completion:@escaping () -> Void) {
        let c = _battle._curRole
        if c._unit._weapon is ThorsHammer {
            _rate = 1
        }
        let this = self
        _battle._curRole.showText(text: _name) {
            this.findTarget()
            let t = this._battle._selectedTarget
            this._damageValue = this.thunderDamage(t)
            let damage = this._damageValue
            if this.hadSpecialAction(t:t, completion: completion) {
                
            } else {
                
                t.actionAttacked {
                    t.hpChange(value: damage)
                    t.showValue(value: damage) {
                        completion()
                    }
                    //                this.setFrozen(target: t, completion: completion)
                }
            }
        }
        
        
    }
    
    override func findTarget(inleft:Bool = false) {
        findSingleTargetNotBlocked(inleft: _battle._curRole.inleft)
    }
}

