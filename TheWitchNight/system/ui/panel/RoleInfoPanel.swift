//
//  RoleInfo.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/12.
//  Copyright © 2018年 Chen. All rights reserved.
//
//        let ci = CharInfo()
//        addChild(ci)

import SpriteKit
class RoleInfoPanel:SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                let touchPoint = touches.first?.location(in: self)
        let char = _unit
        let isMain = char.isMainChar
        if _closeButton.contains(touchPoint!) {
            close()
            return
        } else if _prevButton.contains(touchPoint!) {
            let ms = Data.instance._char._minions
            let index = ms.index(of: _unit)
            if nil == index || 0 == index {
                return
            }
            let ci = RoleInfoPanel()
            
            ci.create(char: ms[(index! - 1)])
            Data.instance.stage.closeCharPanel(panel: self)
            Data.instance.stage.showCharPanel(panel: ci)
            return
        } else if _nextButton.contains(touchPoint!) {
            let ms = Data.instance._char._minions
            let index = ms.index(of: _unit)
            if nil == index || ms.count - 1 <= index! {
                return
            }
            let ci = RoleInfoPanel()
            ci.create(char: ms[(index! + 1)])
            Data.instance.stage.closeCharPanel(panel: self)
            Data.instance.stage.showCharPanel(panel: ci)
            return
        } else if isMain && _llt.contains(touchPoint!) {
            setRoleSeat(seat: BUnit.LLT, _llt)
        } else if isMain && _llm.contains(touchPoint!) {
            setRoleSeat(seat: BUnit.LLM, _llm)
        } else if isMain && _llb.contains(touchPoint!) {
            setRoleSeat(seat: BUnit.LLB, _llb)
        } else if isMain && _lrt.contains(touchPoint!) {
            setRoleSeat(seat: BUnit.LRT, _lrt)
        } else if isMain && _lrm.contains(touchPoint!) {
            setRoleSeat(seat: BUnit.LRM, _lrm)
        } else if isMain && _lrb.contains(touchPoint!) {
            setRoleSeat(seat: BUnit.LRB, _lrb)
        } else {
            for sc in _spellComponents {
                if sc.contains(touchPoint!) {
                    let sp = SpellPanel()
                    sp.create(role: char)
                    Data.instance.stage.closeCharPanel(panel: self)
                    Data.instance.stage.showSpellPanel(panel: sp)
                    return
                }
            }
            if char._leftPoint > 0 {
                if _attrStrength.contains(touchPoint!) {
                    changeProperties(p: "str")
                } else if _attrStamina.contains(touchPoint!) {
                    changeProperties(p: "sta")
                } else if _attrAgility.contains(touchPoint!) {
                    changeProperties(p: "agl")
                } else if _attrIntellect.contains(touchPoint!) {
                    changeProperties(p: "int")
                }
                return
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
    private var _unit = Creature()
    func create(char:Creature) {
        _unit = char
//        let char = Data.instance._char!
        let bChar = BUnit()
        bChar.setUnit(unit: char)
        
        let to = Creature()
        to._level = 0
        
        let isMain = char.isMainChar
        
        let startX = -cellSize * 6.5
        let startY = cellSize * 2.5
        //        let ab = CGPoint(x: 0.5, y: 1)
        if isMain {
            let actor = Actor()
            actor.setActor()
            actor.anchorPoint = CGPoint(x: 0, y: 1)
            actor.size = CGSize(width: cellSize * 1.2, height: cellSize * 1.2)
            actor.position.x = startX
            actor.position.y = startY
            addChild(actor)
        } else {
            let actor = SKSpriteNode(texture: char._img.getCell(1, 0))
            //        actor.setActor()
            actor.anchorPoint = CGPoint(x: 0, y: 1)
            actor.size = CGSize(width: cellSize * 1.2, height: cellSize * 1.2)
            actor.position.x = startX
            actor.position.y = startY
            addChild(actor)
        }
        
        let firstGap:CGFloat = 3
        
        let race = Label()
        race.text = EvilType.getTypeLabel(type: char._race)
        race.align = "left"
        race.fontSize = 13
        race.position.x = startX + cellSize * 1.2 + firstGap + 3
        race.position.y = startY - 20
        addChild(race)
        
        let lv = Label()
        lv.text = "Lv.\(char._level.toInt())\(char._name)"
        lv.align = "left"
        lv.fontSize = 15
        lv.position.x = race.position.x + 2
        lv.position.y = startY - 35
        addChild(lv)
        
        let _hpbar = HBar()
        _hpbar._color = UIColor.red
        _hpbar.setBar(value: char._extensions.hp / char._extensions.health)
        _hpbar.position.y = lv.position.y - 11
        _hpbar.position.x = race.position.x + firstGap
        //        _hpbar.anchorPoint = apc
        addChild(_hpbar)
        
        let _expbar = HBar()
        _expbar._color = UIColor.green
        _expbar.setBar(value: char._exp / char.expNext())
        _expbar.position.y = _hpbar.position.y - 11
        _expbar.position.x = _hpbar.position.x
        //        _expbar.anchorPoint = apc
        addChild(_expbar)
        
        let gap:CGFloat = 3
        let colorLight = QualityColor.RARE
        
        if isMain {
        
        let llt = getSeatNode()
        llt.position.y = startY - 2
        llt.position.x = (_expbar.position.x + _expbar.size.width) + 15
        if char._seat == BUnit.LLT {
            llt.color = colorLight
        }
        addChild(llt)
        
        let lrt = getSeatNode()
        lrt.position.y = startY - 2
        lrt.position.x = llt.position.x + llt.size.width + gap
        if char._seat == BUnit.LRT {
            lrt.color = colorLight
        }
        addChild(lrt)
        
        let llm = getSeatNode()
        llm.position.y = llt.position.y - llt.size.height - gap
        llm.position.x = llt.position.x
        if char._seat == BUnit.LLM {
            llm.color = colorLight
        }
        addChild(llm)
        
        let lrm = getSeatNode()
        lrm.position.y = llm.position.y
        lrm.position.x = lrt.position.x
        if char._seat == BUnit.LRM {
            lrm.color = colorLight
        }
        addChild(lrm)
        
        let llb = getSeatNode()
        llb.position.y = llm.position.y - llm.size.height - gap
        llb.position.x = llt.position.x
        if char._seat == BUnit.LLB {
            llb.color = colorLight
        }
        addChild(llb)
        
        let lrb = getSeatNode()
        lrb.position.y = llb.position.y
        lrb.position.x = lrt.position.x
        if char._seat == BUnit.LRB {
            lrb.color = colorLight
        }
        addChild(lrb)
            
        _llt = llt
        _llm = llm
        _llb = llb
        _lrt = lrt
        _lrm = lrm
        _lrb = lrb

        }
        
        let firstRowX = startX
        let firstLineY = startY - cellSize * 1.2 - cellSize * 0.45
        //        let pGapX:CGFloat = 12
        let gapY = cellSize * 0.95
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
        attack.value = bChar.getAttack(t: to).toInt()
        addChild(attack)
        
        var def = bChar.getDefence(t: to).toInt()
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
        spirit.value = bChar.getSpirit(t: to).toInt()
        addChild(spirit)
        
        let health = AttrLabel()
        health.position.x = intellect.position.x + xWidth
        health.position.y = secondLineY
        health.text = "生命"
        health.value = bChar.getHealth().toInt()
        addChild(health)
        
        if isMain {
            let lucky = AttrLabel()
            lucky.position.x = health.position.x + xWidth
            lucky.position.y = secondLineY
            lucky.text = "幸运"
            lucky.value = bChar.getLucky().toInt()
            addChild(lucky)
            
            let chaos = AttrLabel()
            chaos.position.x = lucky.position.x + xWidth
            chaos.position.y = secondLineY
            chaos.text = "抗混乱"
            chaos.value = bChar.getChaos().toInt()
            addChild(chaos)

            _attrLucky = lucky
            _attrChaos = chaos
        }
        
        
        
        
        let thirdLineY = attack.position.y - gapY
        
        let critical = AttrLabel()
        critical.position.x = strength.position.x
        critical.position.y = thirdLineY
        critical.text = "必杀"
        critical.value = bChar.getCriticalForShow(t: to).toInt()
        addChild(critical)
        
        let avoid = AttrLabel()
        avoid.position.x = critical.position.x + xWidth
        avoid.position.y = thirdLineY
        avoid.text = "闪避"
        avoid.value = bChar.getAvoid(t: to).toInt()
        addChild(avoid)
        
        let accuracy = AttrLabel()
        accuracy.position.x = avoid.position.x + xWidth
        accuracy.position.y = thirdLineY
        accuracy.text = "命中"
        accuracy.value = bChar.getAccuracy(t: to).toInt()
        addChild(accuracy)
        
        
        let mind = AttrLabel()
        mind.position.x = accuracy.position.x + xWidth
        mind.position.y = thirdLineY
        mind.text = "念力"
        mind.value = bChar.getMind(target: to).toInt()
        addChild(mind)
        
        let _break = AttrLabel()
        _break.position.x = mind.position.x + xWidth
        _break.position.y = thirdLineY
        _break.text = "破甲"
        _break.value = bChar.getBreak(target: to).toInt()
        addChild(_break)
        
        let revenge = AttrLabel()
        revenge.position.x = _break.position.x + xWidth
        revenge.position.y = thirdLineY
        revenge.text = "复仇"
        revenge.value = bChar.getRevenge(target: to).toInt()
        addChild(revenge)
        
        let rhythm = AttrLabel()
        rhythm.position.x = revenge.position.x + xWidth
        rhythm.position.y = thirdLineY
        rhythm.text = "律动"
        rhythm.value = bChar.getRhythm().toInt()
        addChild(rhythm)
        
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
        
        if isMain {
            let spellWidth = cellSize * 1.2
            if char._spellsInuse.count > 0 {
                for i in 0...char._spellsInuse.count - 1 {
                    let sc = SpellComponent()
                    sc.setSpell(s: char._spellsInuse[i])
                    sc.position.x = _hpbar.position.x + cellSize * 5 + i.toFloat() * spellWidth
                    sc.position.y = startY - cellSize * 0.7
                    addChild(sc)
                    _spellComponents.append(sc)
                }
            }
        } else {
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
            _nextButton.position.x = cellSize * 3.75
            _nextButton.position.y = cellSize * 3.5
            _nextButton.text = "后一个"
            addChild(_nextButton)
            _prevButton.position.x = _nextButton.position.x - cellSize * 2.25
            _prevButton.position.y = _nextButton.position.y
            _prevButton.text = "前一个"
            addChild(_prevButton)
        }
        
        
        let btn = Button()
        btn.text = "关闭"
        btn.position.x = cellSize * 6
        btn.position.y = cellSize * 3.5
        addChild(btn)
        
        
        
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
        
        _attrMind = mind
        _attrBreak = _break
        _attrRevenge = revenge
        _attrFirePower = firePower
        _attrThunderPower = thunderPower
        _attrWaterPower = waterPower
        _attrFireRes = fireRes
        _attrThunderRes = thunderRes
        _attrWaterRes = waterRes
        
        _closeButton = btn
    }
    
    private func close() {
        Data.instance.stage.closeCharPanel(panel: self)
        if !_unit.isMainChar {
            let ml = MinionsList()
            let c = Data.instance._char!
            ml.create(minions: c._minions)
            Data.instance.stage.showMinionsListPanel(panel: ml)
        }
    }
    
    private func setRoleSeat(seat:String, _ node:SKSpriteNode) {
        let color = UIColor.lightGray
        _llt.color = color
        _llm.color = color
        _llb.color = color
        _lrt.color = color
        _lrm.color = color
        _lrb.color = color
        node.color = QualityColor.RARE
        Data.instance._char._seat = seat
        
        for m in Data.instance._char._minions {
            if m._seat == seat {
                m._seat = BUnit.STAND_BY
            }
        }
    }
    
    private func changeProperties(p:String) {
        let char = _unit
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
        reloadData()
        if char._leftPoint < 1 {
            _attrLeftPoint.removeFromParent()
        }
    }
    
    private func reloadData() {
        let char = _unit
        let bChar = BUnit()
        bChar.setUnit(unit: char)
        
        let to = Creature()
        to._level = 0
        
        _attrStrength.value = bChar.getStrength().toInt()
        _attrStamina.value = bChar.getStamina().toInt()
        _attrAgility.value = bChar.getAgility().toInt()
        _attrIntellect.value = bChar.getIntellect().toInt()
        _attrAttack.value = bChar.getAttack(t: to).toInt()
        _attrDefence.value = bChar.getDefence(t: to).toInt()
        _attrSpeed.value = bChar.getSpeed().toInt()
        _attrSpirit.value = bChar.getSpirit(t: to).toInt()
        _attrHealth.value = bChar.getHealth().toInt()
        _attrCritical.value = bChar.getCriticalForShow(t: to).toInt()
        _attrAvoid.value = bChar.getAvoid(t: to).toInt()
        _attrAccuracy.value = bChar.getAccuracy(t: to).toInt()
        _attrMind.value = bChar.getMind(target: to).toInt()
        _attrBreak.value = bChar.getBreak().toInt()
        _attrRevenge.value = bChar.getRevenge().toInt()
        _attrLeftPoint.value = char._leftPoint
    }
    
    private func getSeatNode(color:UIColor = UIColor.lightGray) -> SKSpriteNode {
        let node = SKSpriteNode()
        node.size = CGSize(width: cellSize * 0.95, height: cellSize * 0.35)
        node.color = color
        node.anchorPoint = CGPoint(x: 0, y: 1)
        return node
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _llt:SKSpriteNode!
    private var _llm:SKSpriteNode!
    private var _llb:SKSpriteNode!
    private var _lrt:SKSpriteNode!
    private var _lrm:SKSpriteNode!
    private var _lrb:SKSpriteNode!
    
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
    private var _attrChaos:AttrLabel!
    private var _attrMind:AttrLabel!
    private var _attrBreak:AttrLabel!
    private var _attrRevenge:AttrLabel!
    private var _attrFirePower:AttrLabel!
    private var _attrThunderPower:AttrLabel!
    private var _attrWaterPower:AttrLabel!
    private var _attrFireRes:AttrLabel!
    private var _attrThunderRes:AttrLabel!
    private var _attrWaterRes:AttrLabel!
    private var _spellComponents = Array<SpellComponent>()
    private var _closeButton:Button!
    private var _nextButton = Button()
    private var _prevButton = Button()
}

class AttrLabel:SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _value:Int = 0
    private var _bg:SKShapeNode!
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = CGSize(width: cellSize * 1.6, height: cellSize * 0.6)
        _label.fontSize = 14
        _label.align = "left"
        _label.position.x = -cellSize * 0.6
        _label.position.y = -15
        background = true
        addChild(_label)
    }
    private var _label:Label = Label()
    private var _text = ""
    var background:Bool {
        set {
            if newValue {
                _bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: -cellSize * 0.8, y: -cellSize * 0.5), size: self.size), cornerRadius: 2 )
                _bg.fillColor = UIColor.black
                addChild(_bg)
            } else {
//                _bg?.removeFromParent()
                
            }
        }
        get {
            return false
        }
    }
    private var _plus = " +"
    var plus:Bool {
        set {
            if newValue {
                _label.text = self._text + " \(self._value)" + " +"
            } else {
                _label.text = self._text + " \(self._value)"
            }
        }
        get {
            return false
        }
    }
    var text:String {
        set {
            _text = newValue
        }
        get {
            return ""
        }
    }
    
    var value:Int {
        set {
            _value = newValue
            _label.text = self._text + " \(self._value)"
        }
        get {
            return _value
        }
    }
    
}
