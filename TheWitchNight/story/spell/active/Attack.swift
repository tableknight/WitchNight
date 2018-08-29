//
//  attack.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/18.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Attack: Physical {
    override init() {
        super.init()
        isClose = true
        isPhysical = true
    }
    override func cast(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget
        let c = b._curRole
        let role = c._unit
        let this = self
        if role._weapon.isClose {
            b.roleMove(from: c, to: t, completion: {
                c.actionAttack {
                    this.attack {
                        b.moveBack(unit: c) {
                            completion()
                        }
                    }
                }
            })
        } else {
            c.actionShoot {
                this.attack {
                    completion()
                }
            }
        }
        
        
        
    }
    
    private func attack(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget
        let c = b._curRole
//        let role = c._unit
        
        var rate:CGFloat = 1
        if c.hasStatus(type: Status.CRAZY) {
            rate = 2
        }
        _damageValue = physicalDamage(t) * rate
        
        if c.hasSpell(spell: TruePower()) {
            _damageValue *= 1.3
        }
        let this = self
        let damage = _damageValue
        if hadSpecialAction(t:t, completion: completion) {
            
        } else {
            if !hasMissed(target: t, completion: completion) {
                t.actionAttacked(defend: t.isDefend) {
                    t.hpChange(value: damage)
                    t.showValue(value: damage)
                    if c._unit._weapon is DragonSaliva {
                        setTimeout(delay: 0.5, completion: {
                            let rate = 1 + (c.getFirePower() - t.getFireResistance()) * 0.01
                            let fireDamage = damage * 0.3 * rate
                            
                            t.showValue(value: fireDamage, isCritical: false, textColor: ElementColor.getColor(Element.FIRE)) {
                                this.attackMore(completion: completion)
                            }
                        })
                    } else {
                        t.showValue(value: damage) {
                            this.attackMore(completion: completion)
                        }
                    }
                    
                    var isGiantFang = false
                    if c._unit._weapon is GiantFang {
                        isGiantFang = true
                    }
                    
                    if c.hasStatus(type: Status.VAMPIRE_BLOOD) || isGiantFang {
                        var recoveryFactor:CGFloat = 0.2
                        if isGiantFang {
                            recoveryFactor = 1
                        }
                        if c._unit.isMainChar {
                            let char = c._unit as! Character
                            if char._amulet is FangOfVampire {
                                recoveryFactor *= 2
                            }
                        }
                        let d = abs(damage * recoveryFactor)
                        c.hpChange(value: d)
                        c.showValue(value: d)
                    }
                    
                    if c._unit._weapon is LazesPedicureKnife {
                        if this.seed() < 15 {
                            setTimeout(delay: 1, completion: {
                                c.showText(text: "AGILITY +1")
                                c.agilityChange(value: 1)
                            })
                        }
                    }
                }
            }
        }
    }
    
    func attackMore(completion:@escaping () -> Void) {
        let b = _battle!
        let t = b._selectedTarget
        let c = b._curRole
        
        if !(c._unit._weapon is IdyllssHand) {
            completion()
            return
        }
        
        if t.isDead() {
            completion()
            return
        }
        
        if seed() < 15 {
            let this = self
            c.showText(text:"IDYLLS POWER")
            c.actionAttack {
                this.attack {
                    completion()
                }
            }
            return
        }
        
        completion()
    }
    
    override func findTarget(inleft:Bool = false) {
        if _battle._curRole._unit._weapon.isClose {
            super.findTarget(inleft: inleft)
        } else {
            findSingleTargetNotBlocked(inleft: inleft)
        }
    }

}
