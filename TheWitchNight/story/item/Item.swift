//
//  Item.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Item:Prop {
    func use(unit: BUnit, completion:@escaping () -> Void) {
        
    }
    
    override init() {
        super.init()
    }
    
    var _cooldown = 0
    var useable = false
    var useInBattle = false
    var _timeleft = 0
    var targetSelf = false
    var _battle:Battle!
    
    func use(target:Creature) {
        
    }
    
    func usableInBattle() -> Bool {
        return useInBattle
    }
    
    func timeleft() -> Int {
        return _timeleft
    }
    
    func removeFromChar() {
        Data.instance._char.removeProp(p: self)
    }
    
}

class TheWitchsTear:Item {
    static let NAME = "天使之泪"
    override init() {
        super.init()
        _name = TheWitchsTear.NAME
        _level = 1
        _quality = Quality.NORMAL
        _price = 6
        _sellingPrice = 12
        _description = "一滴来自天使的眼泪，经过时间的沉淀，变成了一颗晶莹剔透的水晶，似乎拥有某种魔力"
    }
}

class Potion:Item {
    override init() {
        super.init()
        useable = true
        useInBattle = true
        _cooldown = 3
        _name = "治疗药水"
        targetSelf = true
        _price = 5
        _sellingPrice = 20
        _description = "恢复50%最大生命值，战斗中冷却时间2回合"
    }
    
    internal var _rate:CGFloat = 0.5
    
    override func use(target: Creature) {
        target._extensions.hp += target._extensions.health * _rate
        if target._extensions.hp >= target._extensions.health {
            target._extensions.hp = target._extensions.health
        }
        Data.instance._char.removeProp(p: self)
    }
    
    override func use(unit: BUnit, completion: @escaping () -> Void) {
        if (unit.getHp() >= unit.getHealth()) || _count <= 0 {
            return
        }
        _timeleft = _cooldown
        let this = self
        _battle._curRole.showText(text: _name) {
            unit.actionHealed {
                let change = unit.getHealth() * this._rate
                unit.hpChange(value: change)
                unit.showValue(value: change) {
                    completion()
                }
            }
        }
//        completion()
    }
}

class LittlePotion:Potion {
    override init() {
        super.init()
        _cooldown = 2
        _name = "小型治疗药水"
        targetSelf = true
        _price = 3
        _sellingPrice = 12
        _description = "恢复25%最大生命值，战斗中冷却时间1回合"
        _rate = 0.25
    }
}

class SealScroll:Item {
    override init() {
        super.init()
        useable = false
        useInBattle = true
        _cooldown = 0
        _name = "封印卷轴"
        _price = 6
        _sellingPrice = 24
        _description = "对目标释放封印术"
    }
    
    override func use(unit: BUnit, completion:@escaping () -> Void) {
        let this = self
        let char = Data.instance._char!
        let c = _battle._curRole
        c.showText(text: "封印") {
            unit.actionSealed {
                let chance = this.seed(max: unit.getHealth().toInt())
                if Mode.debug || chance > unit.getHp().toInt() {
                    if char._minions.count >= 5 {
                        showMsg(text: "随从位已满！")
                        completion()
                    } else {
                        unit.actionDead {
                            unit.removeFromBattle()
                            unit.removeFromParent()
                            char._minions.append(unit._unit)
                            setTimeout(delay: 0.5) {
                                if !this._battle.hasFinished() {
                                    completion()
                                }
                            }
                        }
                    }
                } else {
                    showMsg(text: "封印失败！")
                    completion()
                }
            }
        }
    }
}

class TownScroll:Item {
    override init() {
        super.init()
        useable = true
        useInBattle = true
        _name = "传送卷轴"
        _price = 6
        _sellingPrice = 24
        _description = "传送到\(CenterVillage.VILLAGE_NAME)"
    }
    override func use(target: Creature) {
        removeFromChar()
        showMsg(text: _description)
        let cv = CenterVillage()
        Data.instance.stage.switchScene(next: cv)
    }
}

class BagIncreaseContract:Item {
    override init() {
        super.init()
        useable = true
        _name = "背包扩充协议"
        _price = 25
        _sellingPrice = 100
        _description = "扩充6个背包格子"
    }
}

class StorageIncreaseContract:Item {
    override init() {
        super.init()
        useable = true
        _name = "仓库扩充协议"
        _price = 25
        _sellingPrice = 100
        _description = "扩充6个仓库格子"
    }
}

class MinionIncreaseContract:Item {
    override init() {
        super.init()
        useable = true
        _name = "寄存扩充协议"
        _price = 25
        _sellingPrice = 100
        _description = "扩充2个随从寄存位"
    }
}

class RebornScroll:Item {
    override init() {
        super.init()
        useable = true
        _name = "重生卷轴"
        _price = 100
        _sellingPrice = 400
        _description = "将一个随从重生到1级"
    }
}

class SmallGoldBag:Item {
    override init() {
        super.init()
        useable = true
        _name = "小钱袋子"
        _price = 100
        _sellingPrice = 400
        _description = "获得100金币"
    }
}

//class SpellBook:Item {
//    override init() {
//        super.init()
//        useable = true
//    }
//    private var _spell:Spell!
//    func setSpell(spell:Spell) {
//        _spell = spell
//        _name = "技能书：\(spell._name)"
//        _description = spell._description
//    }
//    
//    override func use(target: Creature) {
//        
//    }
//}
