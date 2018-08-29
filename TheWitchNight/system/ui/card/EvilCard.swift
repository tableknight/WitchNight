//
//  EvilCard.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/19.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class EvilCard: Card {
//    override init() {
//        super.init()
//
//    }
    init(unit:IEvil) {
        super.init()
//        print(unit)
//        print(unit._level)
//        let str = "lv." + unit._level + "[" + unit._name + "]"
        let startPos = CGFloat(_card.size.height * 0.5 - 30)
        var leftPos = CGFloat(_card.size.width * -0.5 + 20)
        let rightPos:CGFloat = 20
        let gap:CGFloat = 20
        let mains = unit.getMains()
        let exts = unit.getExts()
        let stars = unit.getStars()
        let ppties = unit.getPpties()
        let growth = unit.getGrowth()
        func toTop(_ index:CGFloat) -> CGFloat{
            return startPos - gap * index
        }
        let name = Label()
        name.text = "lv.\(ppties.level.toInt())[\(TypeName.getName(ppties.race))][\(ppties.name)]"
        name.fontColor = QualityColor.getColor(unit.getQuality())
        name.setPos(leftPos, startPos)
        _card.addChild(name)
        let exp = Label()
        exp.text = "经验 \(ppties.exp.toInt())/\(ppties.expNext.toInt())"
        exp.setPos(leftPos, toTop(1))
        _card.addChild(exp)
        
        let hp = Label()
        hp.text = "生命 \(exts.hp.toInt())/\(exts.health.toInt())"
        hp.setPos(leftPos, toTop(2))
        _card.addChild(hp)
        
        let sta = Label()
        sta.text = "耐力 \(mains.stamina.toInt())"
        sta.setPos(leftPos, toTop(3))
        _card.addChild(sta)
        
        let atk = Label()
        atk.text = "攻击 \(exts.attack.toInt())"
        atk.setPos(rightPos, toTop(3))
        _card.addChild(atk)
        
        _card.addChild(Label("力量 \(mains.strength.toInt())", leftPos, toTop(4)))
        _card.addChild(Label("防御 \(exts.defence.toInt())", rightPos, toTop(4)))
//
        _card.addChild(Label("敏捷 \(mains.agility.toInt())", leftPos, toTop(5)))
        _card.addChild(Label("速度 \(exts.speed.toInt())", rightPos, toTop(5)))
//
        _card.addChild(Label("智力 \(mains.strength.toInt())", leftPos, toTop(6)))
        _card.addChild(Label("精神 \(exts.spirit.toInt())", rightPos, toTop(6)))
//        print(toTop(6))
//        print(toTop(7))
        _card.addChild(Label("命中 \(exts.accuracy.toInt())", leftPos, toTop(7)))
        _card.addChild(Label("闪避 \(exts.avoid.toInt())", rightPos, toTop(7)))
//
        _card.addChild(Label("暴击 \(exts.critical.toInt())", leftPos, toTop(8)))
        _card.addChild(Label("抵抗 \(exts.resistance.toInt())", rightPos, toTop(8)))
        
        let spells = unit.getSpells()
//        if(spells.count > 0) {
//            for i in 0...spells.count {
//
//            }
//        }
        let carrys = unit.getCarrys()
        let xGap = 61
        leftPos -= 5
        for i in 0...2 {
            if i < spells.count {
                let slot = CardSlot()
                let size = slot.getNode().size
                slot.setPos(leftPos + (size.width * 0.5) + (xGap * i).toFloat(), toTop(9) - (size.height * 0.5) + 10)
                _card.addChild(slot.getNode())
            } else {
                let slot = CardSlot()
                let size = slot.getNode().size
                slot.setPos(leftPos + (size.width * 0.5) + (xGap * i).toFloat(), toTop(9) - (size.height * 0.5) + 10)
                _card.addChild(slot.getNode())
            }
        }
    
    }
    
}
