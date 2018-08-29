//
//  RoleInfo.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/15.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MinionPanel:SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
//        let char = Data.instance._char!
        if _closeButton.contains(touchPoint!) {
            close()
            return
//        } else if _llt.contains(touchPoint!) {
//            setRoleSeat(seat: BUnit.LLT, _llt)
//        } else if _llm.contains(touchPoint!) {
//            setRoleSeat(seat: BUnit.LLM, _llm)
//        } else if _llb.contains(touchPoint!) {
//            setRoleSeat(seat: BUnit.LLB, _llb)
//        } else if _lrt.contains(touchPoint!) {
//            setRoleSeat(seat: BUnit.LRT, _lrt)
//        } else if _lrm.contains(touchPoint!) {
//            setRoleSeat(seat: BUnit.LRM, _lrm)
//        } else if _lrb.contains(touchPoint!) {
//            setRoleSeat(seat: BUnit.LRB, _lrb)
        } else if _minion._leftPoint > 0 {
            if _attrStrength.contains(touchPoint!) {
                changeProperties(p: "str")
            } else if _attrStamina.contains(touchPoint!) {
                changeProperties(p: "sta")
            } else if _attrAgility.contains(touchPoint!) {
                changeProperties(p: "agl")
            } else if _attrIntellect.contains(touchPoint!) {
                changeProperties(p: "int")
            }
        } else {
            for sc in _spellComponents {
                if sc.contains(touchPoint!) {
                    let sp = SpellPanel()
                    sp.create(role: _minion)
                    Data.instance.stage.closeMinionPanel(panel: self)
                    Data.instance.stage.showSpellPanel(panel: sp)
                }
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = CGSize(width: cellSize * 14, height: cellSize * 6)
        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: -cellSize * 7, y: -cellSize * 3), size: self.size), cornerRadius: 4 )
        bg.fillColor = UIColor.black
        addChild(bg)
        isUserInteractionEnabled = true
        
        
    }
    private var _minion = Creature()
    func create(minion:Creature) {
        let char = minion
        _minion = minion
        
        let bChar = BUnit()
        bChar.setUnit(unit: char)
        
        let startX = -cellSize * 6.5
        let startY = cellSize * 2.75
        //        let ab = CGPoint(x: 0.5, y: 1)
        let actor = SKSpriteNode(texture: char._img.getCell(1, 0))
//        actor.setActor()
        actor.anchorPoint = CGPoint(x: 0, y: 1)
        actor.size = CGSize(width: cellSize * 1.2, height: cellSize * 1.2)
        actor.position.x = startX
        actor.position.y = startY
        addChild(actor)
        
        let firstGap:CGFloat = 3
        
        let lv = Label()
        lv.text = "Lv.\(char._level.toInt())\(char._name)"
        lv.align = "left"
        lv.fontSize = 16
        lv.position.x = startX + cellSize * 1.2 + firstGap + 3
        lv.position.y = startY - 33
        addChild(lv)
        
        let _hpbar = HBar()
        _hpbar._color = UIColor.red
        _hpbar.setBar(value: char._extensions.hp / char._extensions.health)
        _hpbar.position.y = lv.position.y - 12
        _hpbar.position.x = lv.position.x + firstGap
        //        _hpbar.anchorPoint = apc
        addChild(_hpbar)
        
        let _expbar = HBar()
        _expbar._color = UIColor.green
        _expbar.setBar(value: char._exp / char.expNext())
        _expbar.position.y = _hpbar.position.y - 12
        _expbar.position.x = _hpbar.position.x
        //        _expbar.anchorPoint = apc
        addChild(_expbar)
        
//        let gap:CGFloat = 10
//        let colorLight = QualityColor.RARE
        
//        let llt = getSeatNode()
//        llt.position.y = startY - 2
//        llt.position.x = (_expbar.position.x + _expbar.size.width) + gap
//        if char._seat == BUnit.LLT {
//            llt.color = colorLight
//        }
//        addChild(llt)
//
//        let lrt = getSeatNode()
//        lrt.position.y = startY - 3
//        lrt.position.x = llt.position.x + llt.size.width + gap
//        if char._seat == BUnit.LRT {
//            lrt.color = colorLight
//        }
//        addChild(lrt)
//
//        let llm = getSeatNode()
//        llm.position.y = llt.position.y - llt.size.height - gap
//        llm.position.x = llt.position.x
//        if char._seat == BUnit.LLM {
//            llm.color = colorLight
//        }
//        addChild(llm)
//
//        let lrm = getSeatNode()
//        lrm.position.y = llm.position.y
//        lrm.position.x = lrt.position.x
//        if char._seat == BUnit.LRM {
//            lrm.color = colorLight
//        }
//        addChild(lrm)
//
//        let llb = getSeatNode()
//        llb.position.y = llm.position.y - llm.size.height - gap
//        llb.position.x = llt.position.x
//        if char._seat == BUnit.LLB {
//            llb.color = colorLight
//        }
//        addChild(llb)
//
//        let lrb = getSeatNode()
//        lrb.position.y = llb.position.y
//        lrb.position.x = lrt.position.x
//        if char._seat == BUnit.LRB {
//            lrb.color = colorLight
//        }
//        addChild(lrb)
        
        let firstRowX = startX
        let firstLineY = actor.position.y - actor.size.height - cellSize * 0.4
        //        let pGapX:CGFloat = 12
        let gapY = cellSize
        let xWidth = cellSize * 1.6 + 12
        
        let more = char._leftPoint > 0
        
        let strength = AttrLabel()
        strength.position.x = firstRowX + strength.size.width * 0.5
        strength.position.y = firstLineY
        strength.text = "力量"
        strength.value = bChar.getStrength().toInt()
        strength.background = more
        //        strength.plus = true
        addChild(strength)
        
        let stamina = AttrLabel()
        stamina.position.x = strength.position.x + xWidth
        stamina.position.y = firstLineY
        stamina.text = "体力"
        stamina.value = bChar.getStamina().toInt()
        stamina.background = more
        addChild(stamina)
        
        let agility = AttrLabel()
        agility.position.x = stamina.position.x + xWidth
        agility.position.y = firstLineY
        agility.text = "敏捷"
        agility.value = bChar.getAgility().toInt()
        agility.background = more
        addChild(agility)
        
        let intellect = AttrLabel()
        intellect.position.x = agility.position.x + xWidth
        intellect.position.y = firstLineY
        intellect.text = "智力"
        intellect.value = bChar.getIntellect().toInt()
        intellect.background = more
        addChild(intellect)
        
//        let health = AttrLabel()
//        health.position.x = intellect.position.x + xWidth
//        health.position.y = firstLineY
//        health.text = "生命"
//        health.value = char._extensions.health.toInt()
//        addChild(health)
        
//        let lucky = AttrLabel()
//        lucky.position.x = health.position.x + xWidth
//        lucky.position.y = firstLineY
//        lucky.text = "幸运"
//        lucky.value = char._lucky.toInt()
//        addChild(lucky)
        
        if more {
            let leftPoint = AttrLabel()
            leftPoint.position.x = intellect.position.x + xWidth
            leftPoint.position.y = firstLineY
            leftPoint.text = "未分配"
            leftPoint.value = char._leftPoint
            addChild(leftPoint)
            _attrLeftPoint = leftPoint
        }
        
        let secondLineY = strength.position.y - gapY
        
        let attack = AttrLabel()
        attack.position.x = firstRowX + attack.size.width * 0.5
        attack.position.y = secondLineY
        attack.text = "攻击"
        attack.value = bChar.getAttack(t: char).toInt()
        addChild(attack)
        
        var def = bChar.getDefence(t: char).toInt()
        if bChar.hasSpell(spell: OnePunch()) || bChar.hasSpell(spell: DancingOnIce()) {
            def = 0
        }
        
        let defence = AttrLabel()
        defence.position.x = attack.position.x + xWidth
        defence.position.y = secondLineY
        defence.text = "防御"
        defence.value = def
        addChild(defence)
        
        let speed = AttrLabel()
        speed.position.x = defence.position.x + xWidth
        speed.position.y = secondLineY
        speed.text = "速度"
        speed.value = bChar.getSpeed().toInt()
        addChild(speed)
        
        let spirit = AttrLabel()
        spirit.position.x = speed.position.x + xWidth
        spirit.position.y = secondLineY
        spirit.text = "精神"
        spirit.value = bChar.getSpirit(t: char).toInt()
        addChild(spirit)
        
        let health = AttrLabel()
        health.position.x = intellect.position.x + xWidth
        health.position.y = secondLineY
        health.text = "生命"
        health.value = bChar.getHealth().toInt()
        addChild(health)
        
        
        
        
        let thirdLineY = attack.position.y - gapY
        
        let critical = AttrLabel()
        critical.position.x = strength.position.x
        critical.position.y = thirdLineY
        critical.text = "必杀"
        critical.value = bChar.getCriticalForShow(t: char).toInt()
        addChild(critical)
        
        let avoid = AttrLabel()
        avoid.position.x = critical.position.x + xWidth
        avoid.position.y = thirdLineY
        avoid.text = "闪避"
        avoid.value = bChar.getAvoid(t: char).toInt()
        addChild(avoid)
        
        let accuracy = AttrLabel()
        accuracy.position.x = avoid.position.x + xWidth
        accuracy.position.y = thirdLineY
        accuracy.text = "命中"
        accuracy.value = bChar.getAccuracy(t: char).toInt()
        addChild(accuracy)
        
        
        let mind = AttrLabel()
        mind.position.x = accuracy.position.x + xWidth
        mind.position.y = thirdLineY
        mind.text = "念力"
        mind.value = bChar.getMind(target: char).toInt()
        addChild(mind)
        
        let forthLineY = critical.position.y - gapY
        
        let firePower = AttrLabel()
        firePower.position.x = strength.position.x
        firePower.position.y = forthLineY
        firePower.text = "火伤"
        firePower.value = bChar.getFirePower().toInt()
        addChild(firePower)
        
        let thunderPower = AttrLabel()
        thunderPower.position.x = firePower.position.x + xWidth
        thunderPower.position.y = forthLineY
        thunderPower.text = "雷伤"
        thunderPower.value = bChar.getThunderPower().toInt()
        addChild(thunderPower)
        
        let waterPower = AttrLabel()
        waterPower.position.x = thunderPower.position.x + xWidth
        waterPower.position.y = forthLineY
        waterPower.text = "冰伤"
        waterPower.value = bChar.getWaterPower().toInt()
        addChild(waterPower)
        
        //        let fifthLineY = firePower.position.y - gapY
        
        let fireRes = AttrLabel()
        fireRes.position.x = waterPower.position.x + xWidth
        fireRes.position.y = forthLineY
        fireRes.text = "火抗"
        fireRes.value = bChar.getFireResistance().toInt()
        addChild(fireRes)
        
        let thunderRes = AttrLabel()
        thunderRes.position.x = fireRes.position.x + xWidth
        thunderRes.position.y = forthLineY
        thunderRes.text = "雷抗"
        thunderRes.value = bChar.getThunderResistance().toInt()
        addChild(thunderRes)
        
        let waterRes = AttrLabel()
        waterRes.position.x = thunderRes.position.x + xWidth
        waterRes.position.y = forthLineY
        waterRes.text = "冰抗"
        waterRes.value = bChar.getWaterResistance().toInt()
        addChild(waterRes)
        
        let spellWidth = cellSize * 1.2
        if char._spellCount > 0 {
            for i in 0...char._spellCount - 1 {
                let sc = SpellComponent()
                if char._spellsInuse.count > i {
                    sc.setSpell(s: char._spellsInuse[i])
                }
                sc.position.x = _hpbar.position.x + cellSize * 3 + i.toFloat() * spellWidth
                sc.position.y = startY - cellSize * 0.7
                addChild(sc)
                _spellComponents.append(sc)
            }
        }
        
        let btn = Button()
        btn.text = "关闭"
        btn.position.x = cellSize * 6
        btn.position.y = cellSize * 3.5
        addChild(btn)
        
//        _llt = llt
//        _llm = llm
//        _llb = llb
//        _lrt = lrt
//        _lrm = lrm
//        _lrb = lrb
        
        _attrStrength = strength
        _attrStamina = stamina
        _attrAgility = agility
        _attrIntellect = intellect
        
        _attrAttack = attack
        _attrDefence = defence
        _attrSpeed = speed
        _attrSpirit = spirit
        _attrHealth = health
        _attrCritical = critical
        _attrAvoid = avoid
        _attrAccuracy = accuracy
//        _attrLucky = lucky
        _attrMind = mind
        _attrFirePower = firePower
        _attrThunderPower = thunderPower
        _attrWaterPower = waterPower
        _attrFireRes = fireRes
        _attrThunderRes = thunderRes
        _attrWaterRes = waterRes
        
        _closeButton = btn
    }
    
    private func close() {
        Data.instance.stage.closeMinionPanel(panel: self)
    }
    
//    private func setRoleSeat(seat:String, _ node:SKSpriteNode) {
//        let color = UIColor.lightGray
//        _llt.color = color
//        _llm.color = color
//        _llb.color = color
//        _lrt.color = color
//        _lrm.color = color
//        _lrb.color = color
//        node.color = QualityColor.RARE
//    }
    
    private func changeProperties(p:String) {
        let char = _minion
        switch p {
        case "str":
            char.strengthChange(value: 1)
            char._leftPoint -= 1
            break
        case "sta":
            char.staminaChange(value: 1)
            char._leftPoint -= 1
            break
        case "agl":
            char.agilityChange(value: 1)
            char._leftPoint -= 1
            break
        case "int":
            char.intellectChange(value: 1)
            char._leftPoint -= 1
            break
        default:
            break
        }
        _attrStrength.value = char._mains.strength.toInt()
        _attrStamina.value = char._mains.stamina.toInt()
        _attrAgility.value = char._mains.agility.toInt()
        _attrIntellect.value = char._mains.intellect.toInt()
        _attrAttack.value = char._extensions.attack.toInt()
        _attrDefence.value = char._extensions.defence.toInt()
        _attrSpeed.value = char._extensions.speed.toInt()
        _attrSpirit.value = char._extensions.spirit.toInt()
        _attrHealth.value = char._extensions.health.toInt()
        _attrCritical.value = char._extensions.critical.toInt()
        _attrAvoid.value = char._extensions.avoid.toInt()
        _attrAccuracy.value = char._extensions.accuracy.toInt()
        _attrMind.value = char._extensions.mind.toInt()
        _attrLeftPoint.value = char._leftPoint
        if char._leftPoint < 1 {
            _attrLeftPoint.removeFromParent()
        }
    }
    
    private func getSeatNode(color:UIColor = UIColor.lightGray) -> SKSpriteNode {
        let node = SKSpriteNode()
        node.size = CGSize(width: cellSize * 0.95, height: cellSize * 0.25)
        node.color = color
        node.anchorPoint = CGPoint(x: 0, y: 1)
        return node
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    private var _llt:SKSpriteNode!
//    private var _llm:SKSpriteNode!
//    private var _llb:SKSpriteNode!
//    private var _lrt:SKSpriteNode!
//    private var _lrm:SKSpriteNode!
//    private var _lrb:SKSpriteNode!
    
    private var _attrStrength:AttrLabel!
    private var _attrStamina:AttrLabel!
    private var _attrAgility:AttrLabel!
    private var _attrIntellect:AttrLabel!
    private var _attrLeftPoint:AttrLabel!
    private var _attrAttack:AttrLabel!
    private var _attrDefence:AttrLabel!
    private var _attrSpeed:AttrLabel!
    private var _attrSpirit:AttrLabel!
    private var _attrHealth:AttrLabel!
    private var _attrCritical:AttrLabel!
    private var _attrAvoid:AttrLabel!
    private var _attrAccuracy:AttrLabel!
    private var _attrLucky:AttrLabel!
    private var _attrMind:AttrLabel!
    private var _attrFirePower:AttrLabel!
    private var _attrThunderPower:AttrLabel!
    private var _attrWaterPower:AttrLabel!
    private var _attrFireRes:AttrLabel!
    private var _attrThunderRes:AttrLabel!
    private var _attrWaterRes:AttrLabel!
    private var _spellComponents = Array<SpellComponent>()
    private var _closeButton:Button!
}
