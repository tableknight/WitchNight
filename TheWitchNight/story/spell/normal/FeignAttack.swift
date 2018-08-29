//
//  FeignAttack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class FeignAttack: Physical {
    override init() {
        super.init()
        isClose = true
        _quality = Quality.NORMAL
        _cooldown = 1
        _name = "佯攻"
        _rate = 2
        _description = "对目标相邻随机单位造成攻击200%的物理伤害"
    }
    override func cast(completion:@escaping () -> Void) {
        var t = _battle._selectedTarget
        let c = _battle._curRole
        let b = _battle!
        let this = self
        b.roleMove(from: c, to: t, completion: {
            c.actionAttack {
                let seat = t._seat
                let seats = [this.getUnitBeyondTarget(seat: seat), this.getUnitUnderTarget(seat: seat), this.getUnitInTheLeftOfTarget(seat: seat), this.getUnitInTheRightOfTarget(seat: seat)]
                let ts = this.getTargetsBySeats(seats: seats)
                if ts.count > 0 {
                    t = ts[this.seed(max: ts.count)]
                    this._damageValue = this.physicalDamage(t)
                    let damage = this._damageValue
                    t.actionAttacked(defend: t.isDefend) {
                        t.hpChange(value: damage)
                        t.showValue(value: damage) {
                            b.moveBack(unit: c, completion: {
                                completion()
                            })
                        }
                    }
                } else {
                    t.actionWait {
                        //                t.hpChange(value: damage)
                        //                t.showValue(value: damage)
                        b.moveBack(unit: c, completion: {
                            completion()
                        })
                    }
                }
            }
        })
        
        
        
        
    }
    
    
    
}
