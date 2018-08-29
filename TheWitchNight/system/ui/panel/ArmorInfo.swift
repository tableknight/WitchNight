//
//  ArmorInfo.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit

class ArmorInfo:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = UIStage.PANEL_LAYER + 100
        //        self.size = CGSize(width: cellSize, height: cellSize)
        
    }
    
    private var _armor = Outfit()
    var _panelWidth:CGFloat = 0
    func create(armor:Outfit) {
        _armor = armor
        let startX = cellSize * 0.26
        let startY = -cellSize
        
        let i = SKSpriteNode(texture: Data.instance.inside_c.getCell(10, 0))
        i.position.x = startX
        i.position.y = startY - 12
        i.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(i)
        
        let name = Label()
        var nameText = armor._name
        if armor._quality == Quality.SACRED {
            nameText = armor._outfitName + " · " + armor._name
        }
        name.text = "Lv.\(armor._level.toInt()) [\(nameText)]"
        //        if armor is Instrument || armor is MagicMark {
        //            name.text = armor._name
        //        }
        name.fontSize = 20
        //        if armor._name.count > 4 {
        //            name.fontSize = 16
        //        }
        //        name.fontName = ""
        name.fontColor = QualityColor.getColor(armor._quality)
        //        name.zPosition = zPosition + 1
        name.position.x = startX
        name.position.y = startY - cellSize + 12
        name.align = "left"
        addChild(name)
        
        var width:CGFloat = ((name.text?.count)! * 18).toFloat()
        _bgHeight = cellSize * 3 + (armor._attrs.count * 20).toFloat()
        if width < cellSize * 3 {
            width = cellSize * 3
        }
        
        if armor.isRandom {
            _bgHeight = cellSize * 4
            let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: -_bgHeight), size: CGSize(width: width, height: _bgHeight)), cornerRadius: 4 )
            bg.fillColor = UIColor.black
            bg.lineWidth = 2
            //        bg.glowWidth = 3
            bg.strokeColor = UIColor.lightGray
            _bg = bg
            addChild(bg)
            name.text = "[\(armor._name)??]"
            name.fontColor = QualityColor.getColor(Quality.NORMAL)
//            name.position.y = -cellSize * 0.75
            
            let des = Label()
            des.text = "未鉴定的\(armor._name)"
            des.fontSize = 12
            des.fontColor = QualityColor.GOOD
            des.align = "left"
            des.position.x = startX
            des.position.y = name.position.y - 25
            addChild(des)
            
//            let price = Label()
//            price.align = "left"
//            price.position.x = startX + 1
//            price.position.y = des.position.y - 30
//            price.fontSize = 12
//            price.text = "出售价格：\(armor._price)G"
//            //            lastY = lastY - 30
//            addChild(price)
            
            return
        }
        
        
        var pptStartY = -cellSize * 2.3
        
        if armor is Weapon {
            let w = armor as! Weapon
            let spd = Label()
            spd.text = "攻速 \(w._attackSpeed)"
            //            spd.fontName = ""
            spd.fontColor = UIColor.white
            spd.position.x = startX - 1
            spd.position.y = name.position.y - cellSize * 0.5
            spd.fontSize = 12
            spd.align = "left"
            addChild(spd)
            pptStartY = -cellSize * 2.8 - 6
            _bgHeight = cellSize * 3.5 + (armor._attrs.count * 20).toFloat()
        }
        
        _bgHeight += 15
        
        
        
        
        
        
        var lastY = name.position.y
        
        let gap:CGFloat = cellSize * 0.5
        if armor._attrs.count > 0 {
            for i in 0...armor._attrs.count - 1 {
                let label = Label()
                label.align = "left"
                label.fontSize = 16
                //                label.fontName = ""
                label.text = armor._attrs[i].getText()
                label.position.x = startX - 1
                label.position.y = pptStartY - gap * i.toFloat()
                label.fontColor = UIColor.white
                addChild(label)
                lastY = label.position.y
            }
        }
        
        if armor is MagicMark {
            let spellName = Label()
            let mark = armor as! MagicMark
            spellName.text = "[\(mark._spell._name)]"
            spellName.fontSize = 16
            spellName.align = "left"
            spellName.position.x = startX
            spellName.position.y = lastY - 30
            lastY = lastY - 30
            addChild(spellName)
        }
        
        if !armor._description.isEmpty {
            let des = Label()
            des.text = armor._description
            des.fontSize = 12
            if armor is Instrument {
                des.fontSize = 16
            }
            des.fontColor = QualityColor.GOOD
            des.align = "left"
            des.position.x = startX
            des.position.y = lastY - 28
            lastY = lastY - 25
            addChild(des)
        }
        
//        if armor is Instrument {
//            //            let ins = armor as! Instrument
//            let spellName = Label()
//            spellName.align = "left"
//            spellName.position.x = startX
//            spellName.position.y = lastY - 30
//            spellName.fontColor = QualityColor.getColor(armor._quality)
//            spellName.fontSize = 16
//            spellName.text = armor._description
//            lastY = lastY - 30
//            addChild(spellName)
//        }
        
        if armor._price > 0 {
            let price = Label()
            price.align = "left"
            price.position.x = startX + 1
            price.position.y = lastY - 20
            price.fontSize = 12
            price.text = "出售价格：\(armor._price)G"
//            lastY = lastY - 30
            addChild(price)
            _bgHeight += 20
        }
        _panelWidth = width
        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: -_bgHeight), size: CGSize(width: width, height: _bgHeight)), cornerRadius: 4 )
        bg.fillColor = UIColor.black
        bg.lineWidth = 2
        //        bg.glowWidth = 3
        bg.strokeColor = UIColor.lightGray
        _bg = bg
        addChild(bg)
        
        let img = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize, height: cellSize), cornerRadius: 2)
        img.position.x = startX
        img.position.y = startY - 12
        img.strokeColor = QualityColor.getColor(armor._quality)
        //        img.lineWidth = 2
        addChild(img)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _bg = SKShapeNode()
    var _bgHeight:CGFloat = 0
}
