//
//  ThunderArray.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ThunderArray:Magical {
    private var _times = 0
    override init() {
        super.init()
        _quality = Quality.RARE
        _name = "雷击阵"
        _cooldown = 3
        _description = "随机造成2-4次雷电伤害，单次伤害为精神的35%"
        isThunder = true
        isAutoSelectTarget = true
        _rate = 0.35
    }
    private var _step = 0
    override func cast(completion: @escaping () -> Void) {
        let c = _battle._curRole
        let this = self
        let times = seed(min: 1, max: 4)
//        let times = 5;
        debug("雷电次数 \(times + 1)")
        let timeSpace:CGFloat = 0.5
        _step = times
        c.actionCast {
            for i in 0...times {
//                let wait = SKAction.wait(forDuration: TimeInterval(i.toFloat() * timeSpace))
                c.actionWait(ti:i.toFloat() * timeSpace) {
                    this.attack(completion: {
//                        debug("闪电step = \(this._step)")
//                        if this._step < 1 {
//                            completion()
//                        }
//                        this._step -= 1
                    })
                    
                }
            }
            let delay = times.toFloat() * timeSpace + 1.5
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: {
//                completion()
//            })
            setTimeout(delay: delay, completion: completion)
        }
//        let wait = SKAction.wait(forDuration: )
////        let node = SKSpriteNode()
//        _battle.run(wait) {
//            completion()
//        }
        
    }
    
    private func attack(completion: @escaping () -> Void) {
        let ts = _battle._selectedTargets
        debug("敌人数量 \(ts.count)")
        if ts.count < 1 {
            debug("雷电阵 失去目标")
            completion()
            return
        }
        let t = ts[seed(max: ts.count)]
        _damageValue = thunderDamage(t)
        let damage = _damageValue
//        let this = self
        if hadSpecialAction(t: t, completion: completion) {
            
        } else {
            t.actionAttacked {
                t.hpChange(value: damage)
                t.showValue(value: damage) {
                    completion()
                }
            }
        }
    }
    
    override func findTarget(inleft:Bool = false) {
        let c = _battle._curRole
        var ts = _battle._leftRoles
        if c.inleft {
            ts = _battle._rightRoles
        }
        _battle._selectedTargets = ts
    }
}
