//
//  Character.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Character: Creature {
    static var MAX_STORED_MINIONS_COUNT = "maxStoredMinionsCount"
    static var MAX_MINIONS_COUNT = "maxMinionsCount"
    override init() {
        super.init()
        isMainChar = true
        _name = "冒险者"
        _setting["maxStoredMinionsCount"] = 5
        _setting["maxMinionsCount"] = 6
        _setting["storageSize"] = 40
        _setting["bagSize"] = 24
        _seat = BUnit.LLM
//        _img = Data.instance
    }
    override func create(level: CGFloat = 1) {
        staminaChange(value: 15)
        strengthChange(value: 15)
        agilityChange(value: 15)
        intellectChange(value: 15)
        _extensions.hp = _extensions.health
//        _spells = [TurnAttack(), FeignAttack()]
        _level = level
        
//        _weapon = NewSword()
//        _weapon.on()
    }
    
    func hasSpell(spell:Spell) -> Bool {
        for s in _spells {
            if s._name == spell._name {
                return true
            }
        }
        for s in _spellsInuse {
            if s._name == spell._name {
                return true
            }
        }
        for m in _minions {
            for s in m._spellsInuse {
                if s._name == spell._name {
                    return true
                }
            }
        }
        return false
    }
    func removeSpell(spell:Spell) {
        var index = _spells.index(of: spell)
        if index != nil {
            _spells.remove(at: index!)
            return
        }
        index = _spellsInuse.index(of: spell)
        if index != nil {
            _spellsInuse.remove(at: index!)
            return
        }
        for m in _minions {
            index = m._spellsInuse.index(of: spell)
            if index != nil {
                m._spellsInuse.remove(at: index!)
                return
            }
        }
    }
    
    func addProp(p:Prop) {
        if p is Item {
            if p is SpellBook {
                _props.append(p)
            } else {
                var exist = false
                for e in _props {
                    if type(of: e) == type(of: p) {
                        let i = e as! Item
                        i._count += p._count
                        exist = true
                        break
                    }
                }
                if !exist {
                    _props.append(p)
                }
            }
        } else {
            _props.append(p)
        }
    }
    
    func addStorage(p:Prop) {
        if p is Item {
            if p is SpellBook {
                _props.append(p)
            } else {
                var exist = false
                for e in _props {
                    if type(of: e) == type(of: p) {
                        let i = e as! Item
                        i._count += p._count
                        exist = true
                        break
                    }
                }
                if !exist {
                    _props.append(p)
                }
            }
        } else {
            _props.append(p)
        }
    }
    
    func removeProp(p:Prop) {
        let i = _props.index(of: p)
        if p is Item {
            if nil != i {
//                let itm = _props[i!] as! Item
                if p._count > 1 {
                    p._count -= 1
                } else {
                    _props.remove(at: i!)
                }
            }
        } else {
            if nil != i {
                _props.remove(at: i!)
            }
        }
    }
    func removeStorage(p:Prop) {
        let i = _props.index(of: p)
        if p is Item {
            if nil != i {
                //                let itm = _props[i!] as! Item
                if p._count > 1 {
                    p._count -= 1
                } else {
                    _props.remove(at: i!)
                }
            }
        } else {
            if nil != i {
                _props.remove(at: i!)
            }
        }
    }
    
    override func levelup() {
        _leftPoint += _levelPoint
        _level += 1
        _extensions.hp = _extensions.health
    }
    
    func getReadyMinions() -> Array<Creature> {
        var ms = Array<Creature>()
        for m in _minions {
            if m._seat != BUnit.STAND_BY && m._extensions.hp >= 1 {
                ms.append(m)
            }
        }
        return ms
    }
    
    var _dungeonLevel:Int = 1
    var _minionsCount = 2
    var _props = Array<Prop>()
    var _storage = Array<Prop>()
    var _minions = Array<Creature>()
    var _storedMinions = Array<Creature>()
    
    var hasShield = false
    var hasEarring = false
    var hasWeapon = true
    var hasMark = false
    var _amulet = Amulet()
    var _leftRing = Ring()
    var _rightRing = Ring()
    var _earRing = EarRing()
    var _shield = Shield()
    var _magicMark = MagicMark()
    var _soulStone = SoulStone()
    
    var _levelPoint = 5
    var _money = 0
    
    func addMoney(num:Int) {
        _money += num
    }
    
    func addSpellUnused(spell:Spell) -> Bool {
        for s in _spells {
            if type(of: s) == type(of: s) {
                return false
            }
        }
        for u in _minions {
            for s in u._spellsInuse {
                if type(of: s) == type(of: s) {
                    return false
                }
            }
        }
        
        _spells.append(spell)
        
        return true
    }
    
    var _setting = Dictionary<String, Any>()
    var _boss:Dictionary<String, Dictionary<String, String>> = [
        "malkus" : ["name": "马尔库斯", "passed": "0", "level" : "21"],
        "dius" : ["name": "迪乌斯", "passed": "0", "level" : "32"],
        "umisa" : ["name": "犹弥萨", "passed": "0", "level" : "40"],
        "francis" : ["name": "佛朗西斯", "passed": "0", "level" : "46"],
        "idylls" : ["name": "埃迪尔斯", "passed": "0", "level" : "50"],
        "kukur" : ["name": "库库尔", "passed": "0", "level" : "59"],
        "pitheron" : ["name": "皮瑟隆", "passed": "0", "level" : "66"],
        "iberis" : ["name": "伊比利斯", "passed": "0", "level" : "78"],
        "georgeantonbill" : ["name": "乔治安顿比尔", "passed": "0", "level" : "82"],
        "idlir" : ["name": "伊德利尔", "passed": "0", "level" : "88"],
        "cusses" : ["name": "库塞斯", "passed": "0", "level" : "96"],
        "eykan" : ["name": "埃坎", "passed": "0", "level" : "102"],
    ]
    
    var _event = Array<Int>()
    
//    var fn:() -> Void = {}
}
