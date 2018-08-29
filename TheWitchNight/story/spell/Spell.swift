//
//  Spell.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Spell:Core {
//    static var TARGET_EVIL = 0
    var isTargetEmemy = true
    var isTargetAll = false
    var canBeTargetSelf = false
    var isPhysical = false
    var isMagical = false
    var isFire = false
    var isCurse = false
    var isWater = false
    var isThunder = false
    var isPassive = false
    var isAuro = false
    var hasInitialized = false
    var isAutoSelectTarget = false
    var isMultiple = false
    var isClose = false
    var hasAfterMoveAction = false
    var _cooldown = 0
    var _timeleft = 0
    var _battle:Battle!
    var _name:String = ""
    var _description = ""
    var LEFT = "left"
    var RIGHT = "right"
    var _rate:CGFloat = 1
    var _quality = Quality.NORMAL
    var _level:CGFloat = 1
    var _tear = 0
    var _speakings = Array<String>()
    internal var beCritical = false
    override init() {
        super.init()
    }
    func beforeMove(completion:@escaping () -> Void) {
        completion()
    }
    func afterMove(completion:@escaping () -> Void) {
        completion()
    }
    func beforeBattle(t:BUnit) {
        
    }
    func cast(completion:@escaping () -> Void) {
        completion()
    }
//    func on(t:Creature) {}
//    func off(t:Creature) {}
    func physicalDamage(_ to:BUnit) -> CGFloat {
        let from = _battle._curRole
        return physicalDamage(from: from, to: to)
    }
    func getDefRate(from: BUnit, to:BUnit) -> CGFloat {
        let level = 1 + from._unit._level * 0.1
        let brk = from.getBreak()
        let odef = to.getDefence(t:from._unit) * (1 - brk * 0.01)
        var def = (odef / atan(level)) / (from._unit._level * 3)
        
        if to.hasSpell(spell: OnePunch()) || to.hasSpell(spell: DancingOnIce()) {
            def = 0
        }
        return def
    }
    func physicalDamage(from: BUnit, to:BUnit) -> CGFloat {
        let atk = from.getAttack(t:to._unit)
        
        let def = getDefRate(from: from, to:to)
        
        var  damage = atk * (1 - def)
        if damage < 5 {
            return -seed(min: 0, max: 5).toFloat()
        }
        if to.isDefend {
            damage = seed(min: 0, max: (damage * 0.6).toInt()).toFloat()
        }
        
        damage *= 1 + (from.getPhysicalDamage() - to.getPhysicalResistance()) * 0.01
        
        if _battle._curRole._unit.isMainChar && Data.instance.stage.hasTowerStatus(status: PhysicalPower()) {
            damage *= 1.5
        }
        damage = specialDamage(damage: damage, to: to, from: from)
        chargeCritical(to: to)
        if beCritical {
            damage *= CRITICAL
        }
        
        if to.hasStatus(type: Status.MIGHT_OF_OAKS) {
            damage *= 0.85
        }
        
        _damageValue = damageControl(damage)
        return -_damageValue
    }
    func magicalDamage(_ to:BUnit) -> CGFloat {
        let from = _battle._curRole
        let atk = from.getSpirit(t: to._unit)
        let def = to.getSpirit(t: from._unit)
        
        var damage = atk - def
        if damage < 5 {
            return -seed(min: 0, max: 5).toFloat()
        }
        damage *= 1 + (from.getMagicalDamage() - to.getMagicalResistance()) * 0.01
        
        if _battle._curRole._unit.isMainChar && Data.instance.stage.hasTowerStatus(status: MagicalPower()) {
            damage *= 1.5
        }
        damage = specialDamage(damage: damage, to: to, from: from)
        return -damageControl(damage)
    }
    func fireDamage(_ to:BUnit, isPhysical:Bool = false) -> CGFloat {
        let from = _battle._curRole
        var damage = from.getSpirit(t:to._unit)
        if isPhysical {
            damage = from.getAttack(t: to._unit)
        }
        if damage < 5 {
            return -seed(min: 0, max: 5).toFloat()
        }
//        let x = from.getFirePower() - to.getFireResistance()
        damage *= fireFactor(from: from, to: to)
        
        if !isMultiple && isFire {
            if from._unit is Character {
                let char = from._unit as! Character
                if char._earRing is LavaCrystal {
                    damage *= 1.5
                }
            }
        }
        
        damage = specialDamage(damage: damage, to: to, from: from)
        damage = elementalDamage(damage: damage, to: to, from: from)
        return -damageControl(damage)
    }
    internal func fireFactor(from:BUnit, to:BUnit) -> CGFloat {
        let x = from.getFirePower() - to.getFireResistance()
        return 1 + (x * 0.01)
    }
    internal func waterFactor(from:BUnit, to:BUnit) -> CGFloat {
        let x = from.getWaterPower() - to.getWaterResistance()
        return 1 + (x * 0.01)
    }
    internal func thunderFactor(from:BUnit, to:BUnit) -> CGFloat {
        let x = from.getThunderPower() - to.getThunderResistance()
        return 1 + (x * 0.01)
    }
    func waterDamage(_ to:BUnit, isPhysical:Bool = false) -> CGFloat {
        let from = _battle._curRole
        var damage = from.getSpirit(t:to._unit)
        if isPhysical {
            damage = from.getAttack(t: to._unit)
        }
        if damage < 5 {
            return -seed(min: 0, max: 5).toFloat()
        }
//        let x = from.getWaterPower() - to.getWaterResistance()
        damage *= waterFactor(from: from, to: to)
        damage = specialDamage(damage: damage, to: to, from: from)
        damage = elementalDamage(damage: damage, to: to, from: from)
        return -damageControl(damage)
    }
    func thunderDamage(_ to:BUnit, isPhysical:Bool = false) -> CGFloat {
        let from = _battle._curRole
        var damage = from.getSpirit(t:to._unit)
        if isPhysical {
            damage = from.getAttack(t: to._unit)
        }
        if damage < 5 {
            return -seed(min: 0, max: 5).toFloat()
        }
//        let x = from.getThunderPower() - to.getThunderResistance()
        damage *= thunderFactor(from: from, to: to)
        
        damage = specialDamage(damage: damage, to: to, from: from)
        damage = elementalDamage(damage: damage, to: to, from: from)
        return -damageControl(damage)
    }
    private func damageControl(_ d:CGFloat) -> CGFloat {
        var damage = d * _rate
        if damage < 5 {
            damage = seed(min:1, max: 5).toFloat()
        } else {
            damage = seed(min: (damage * 0.8).toInt(), max: (damage * 1.2).toInt()).toFloat()
        }
        
        
        
        return damage
    }
    private func specialDamage(damage:CGFloat, to:BUnit, from:BUnit) -> CGFloat {
        var d = damage
        if from._unit._weapon is NightBlade && to._unit._race == EvilType.RISEN {
            d *= 1.25
        }
        
        return d
    }
    internal func raceFactor(to:BUnit, from:BUnit) -> CGFloat {
        var factor:CGFloat = 1
        
        if to.getRace() == EvilType.FINAL {
            factor = 0.75
        }
        if from.getRace() == EvilType.FINAL {
            factor =  1.15
        }
        
        if to.getRace() - from.getRace() == 1 {
            factor =  0.75
        }
        
        if to.getRace() - from.getRace() == -1 {
            factor =  1.15
        }
        
        if to.getRace() == EvilType.RISEN && from.getRace() == EvilType.NATURE {
            factor =  1.15
        }
        
        if from.getRace() == EvilType.RISEN && to.getRace() == EvilType.NATURE {
            factor =  0.75
        }
        
        if from._unit._weapon is HolyPower && to.getRace() == EvilType.RISEN {
            factor *= 2
        }
        
        return factor
    }
    internal func elementalDamage(damage:CGFloat, to:BUnit, from:BUnit) -> CGFloat {
        var damage = damage
        if _battle._curRole._unit._weapon is ElementalSword {
            damage *= 1.3
        }
        
        return damage
    }
    //默认近战 查找被阻挡的单位
    func findTarget(inleft:Bool = false) {
        var ts = Array<BUnit>()
        let c = _battle._curRole
        if c.isBlocked() {
            if c.inleft {
                for u in _battle._rightRoles {
                    if !u.isBlocked() {
                        ts.append(u)
                    }
                }
            } else {
                for u in _battle._leftRoles {
                    if !u.isBlocked() {
                        ts.append(u)
                    }
                }
            }
        } else {
            if c.inleft {
                ts = _battle._rightRoles
            } else {
                ts = _battle._leftRoles
            }
        }
        _battle._selectedTarget = ts[seed(max: ts.count)]
    }
    var _damageValue:CGFloat = 0
    func isAttackReturnBack(t:BUnit, completion:@escaping () -> Void) -> Bool {
//        let t = _battle._selectedTarget
        let c = _battle._curRole
        if isClose && isPhysical && c._unit._weapon.isClose {
            let damage = _damageValue
            if t.hasStatus(type: Status.ATTACK_RETURN_BACK) {
                t.removeStatus(type: Status.ATTACK_RETURN_BACK)
                c.actionAttacked {
                    c.hpChange(value: damage)
                    c.showValue(value: damage) {
                        completion()
                    }
                }
                return true
            }
        } else if isMagical {
            let damage = _damageValue
            if t.hasStatus(type: Status.EYE_TO_EYE) {
                t.removeStatus(type: Status.EYE_TO_EYE)
                c.actionAttacked {
                    c.hpChange(value: damage)
                    c.showValue(value: damage) {
                        completion()
                    }
                }
                return true
            }
        }
        return false
    }
    
    func isAttackTurned(t:BUnit, completion:@escaping () -> Void) -> Bool {
        if isPhysical {
//            let t = _battle._selectedTarget
            let damage = _damageValue
            if t.hasStatus(type: Status.TURN_ATTACK) {
//                let c = _battle._curRole
                t.hpChange(value: -damage)
                t.showValue(value: -damage) {
                    completion()
                }
                t.removeStatus(type: Status.TURN_ATTACK)
//                t.actionHealed {
//                }
                return true
            }
        } else if isMagical {
            let damage = _damageValue
            if t.hasStatus(type: Status.TURN_MAGIC) {
                t.hpChange(value: -damage)
                t.showValue(value: -damage) {
                    completion()
                }
                t.removeStatus(type: Status.TURN_MAGIC)
                return true
            }
        }
        return false
    }
    func hasMissed(target:BUnit, completion:@escaping () -> Void) -> Bool {
        if target.isDefend {
            return false
        }
        let c = _battle._curRole
        if c._unit is Character {
            let char = c._unit as! Character
            if char._weapon is Hawkeye {
                return false
            }
        }
        let acc = c.getAccuracy(t:target._unit)
        let avd = target.getAvoid(t:_battle._curRole._unit)
        let sed = seed().toFloat()
        let this = self
        if sed > (acc - avd) {
            target.showText(text: "Miss") {
                if this.isClose && target._unit._weapon.isClose && this.seed() < target.getRevenge().toInt() {
                    let damage = this.physicalDamage(from: target, to: c)
                    target.actionAttack {
                        c.actionAttacked {
                            c.hpChange(value: damage)
                            c.showValue(value: damage) {
//                                if !this._battle.hasFinished() {
//                                    completion()
//                                }
                                completion()
                            }
                        }
                    }
                } else {
                    completion()
                }
            }
            target.actionAvoid {
            }
            return true
        }
        return false
    }
    internal var CRITICAL:CGFloat = 1.6
    func chargeCritical(to:BUnit) {
        let ctl = _battle._curRole.getCritical(t:to)
        if seed().toFloat() < ctl {
            beCritical = true
        }
        beCritical = false
    }
    
    func hadSpecialAction(t:BUnit, completion:@escaping () -> Void) -> Bool {
        if isAttackReturnBack(t:t, completion: completion) {
            return true
        } else if isAttackTurned(t:t, completion: completion) {
            return true
        }
        return false
    }
    
    func removeSpecialStatus(t:BUnit) {
//        let t = _battle._selectedTarget
        if t.hasStatus(type: Status.ATTACK_RETURN_BACK) {
            t.removeStatus(type: Status.ATTACK_RETURN_BACK)
        }
        if t.hasStatus(type: Status.TURN_ATTACK) {
            t.removeStatus(type: Status.TURN_ATTACK)
        }
        if t.hasStatus(type: Status.EYE_TO_EYE) {
            t.removeStatus(type: Status.EYE_TO_EYE)
        }
        if t.hasStatus(type: Status.TURN_MAGIC) {
            t.removeStatus(type: Status.TURN_MAGIC)
        }
    }
    
    func getUnitBeyondTarget(seat:String) -> String {
        switch seat {
        case "llm":
            return "llt"
        case "llb":
            return "llm"
        case "lrm":
            return "lrt"
        case "lrb":
            return "lrm"
        case "rlm":
            return "rlt"
        case "rlb":
            return "rlm"
        case "rrm":
            return "rrt"
        case "rrb":
            return "rrm"
        default:
            return ""
        }
    }
    func getUnitUnderTarget(seat:String) -> String {
        switch seat {
        case "llm":
            return "llb"
        case "llt":
            return "llm"
        case "lrm":
            return "lrb"
        case "lrt":
            return "lrm"
        case "rlm":
            return "rlb"
        case "rlt":
            return "rlm"
        case "rrm":
            return "rrb"
        case "rrt":
            return "rrm"
        default:
            return ""
        }
    }
    func getUnitsInRowOf(seat:String) -> Array<String> {
        var seats = Array<String>()
        switch seat {
        case BUnit.LLT, BUnit.LLM, BUnit.LLB:
            seats = [BUnit.LLT, BUnit.LLM, BUnit.LLB]
            break
        case BUnit.LRT, BUnit.LRM, BUnit.LRB:
            seats = [BUnit.LRT, BUnit.LRM, BUnit.LRB]
            break
        case BUnit.RLT, BUnit.RLM, BUnit.RLB:
            seats = [BUnit.RLT, BUnit.RLM, BUnit.RLB]
            break
        case BUnit.RRT, BUnit.RRM, BUnit.RRB:
            seats = [BUnit.RRT, BUnit.RRM, BUnit.RRB]
            break
        default:
            debug("error of unit seat in getUnitsInRowOf")
            break
        }
        return seats
    }
    func getUnitInTheLeftOfTarget(seat:String) -> String {
        switch seat {
        case "lrt":
            return "llt"
        case "lrm":
            return "llm"
        case "lrb":
            return "llb"
        case "rrt":
            return "rlt"
        case "rrm":
            return "rlm"
        case "rrb":
            return "rlb"
        default:
            return ""
        }
    }
    func getUnitInTheRightOfTarget(seat:String) -> String {
        switch seat {
        case "llt":
            return "lrt"
        case "llm":
            return "lrm"
        case "llb":
            return "lrb"
        case "rlt":
            return "rrt"
        case "rlm":
            return "rrm"
        case "rlb":
            return "rrb"
        default:
            return ""
        }
    }
    func getTargetsBySeats(seats:Array<String>) -> Array<BUnit> {
        var ts = Array<BUnit>()
        let l = _battle._left
        let r = _battle._right
        for seat in seats {
            if "" == seat {
                continue
            }
            if l.index(forKey: seat) != nil {
                ts.append(l[seat]!)
            } else if r.index(forKey: seat) != nil {
                ts.append(r[seat]!)
            }
        }
        
        return ts
    }
    func getAdajcentUnits(from:BUnit) -> Array<BUnit> {
//        var ts = Array<BUnit>()
        var seats = Array<String>()
        seats.append(getUnitBeyondTarget(seat: from._seat))
        seats.append(getUnitUnderTarget(seat: from._seat))
        seats.append(getUnitInTheLeftOfTarget(seat: from._seat))
        seats.append(getUnitInTheRightOfTarget(seat: from._seat))
        return getTargetsBySeats(seats: seats)
    }
    func setFrozen(target:BUnit, completion:@escaping () -> Void) {
        let sed = seed().toFloat()
        let c = _battle._curRole
        let fromMind = c.getMind(target: target._unit)
        let toMind = target.getMind(target: c._unit)
        let bound = 65 + fromMind - toMind
        if sed < bound {
            print("feeezing!")
            if !target.hasStatus(type: Status.FREEZING) {
                let status = Status()
                status._type = Status.FREEZING
                status._timeleft = 1
                target.addStatus(status: status)
                target.isDefend = false
                target.actionFrozen {}
            }
        }
    }
    
    internal func getTimeleft() -> Int {
        return seed(min: 1, max: 4)
    }
    
    internal func statusMissed(baseline:CGFloat, target:BUnit, completion:@escaping () -> Void) -> Bool {
        if target.hasStatus(type: Status.IMMUNE) {
            target.showText(text: "IMMUNE") {
                completion()
            }
            return true
        }
        let sed = seed().toFloat()
        let c = _battle._curRole
        let fromMind = c.getMind(target: target._unit)
        let toMind = target.getMind(target: c._unit)
        let rate:CGFloat = 1 + (fromMind - toMind) * 0.01
        let bound = baseline * rate
        if sed < bound {
            return false
        }
        target.showText(text: "MISS") {
            completion()
        }
        return true
    }
    //单体无遮挡 目标查找
    internal func findSingleTargetNotBlocked(inleft:Bool = false) {
        if !inleft {
            _battle._selectedTarget = getRandomLeftUnit()
        } else {
            _battle._selectedTarget = getRandomRightUnit()
        }
    }
    internal func getRandomLeftUnit() -> BUnit {
        return _battle._leftRoles[seed(max: _battle._leftRoles.count)]
    }
    internal func getRandomRightUnit() -> BUnit {
        return _battle._rightRoles[seed(max: _battle._rightRoles.count)]
    }
    internal func findHpLowestUnit(inleft:Bool = false) {
        if inleft {
            _battle._selectedTarget = findLowesHpUnit(_battle._left)
        } else {
            _battle._selectedTarget = findLowesHpUnit(_battle._right)
        }
    }
    private func findLowesHpUnit(_ bs:Dictionary<String, BUnit>) -> BUnit {
        var bu = BUnit()
        var lhp:CGFloat = 0
        for unit in bs.values {
            if lhp == 0 {
                bu = unit
                lhp = unit.getHp()
            } else {
                if lhp > unit.getHp() {
                    bu = unit
                    lhp = unit.getHp()
                }
            }
            
        }
        
        return bu
    }
    
    func selectable() -> Bool {
        return true
    }
}
