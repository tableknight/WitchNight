//
//  ItemInfo.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class ItemInfo:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = UIStage.PANEL_LAYER + 100
        //        self.size = CGSize(width: cellSize, height: cellSize)
        
    }
    
    private var _item = Item()
    func create(item:Item) {
        _item = item
        let startX = cellSize * 0.26
        let startY = -cellSize
        
        let i = SKSpriteNode(texture: Data.instance.inside_c.getCell(10, 0))
        i.position.x = startX
        i.position.y = startY - 12
        i.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(i)
        
        let name = Label()
        name.text = "[\(_item._name)]"
        name.fontSize = 20
        //        name.fontName = ""
        name.fontColor = QualityColor.getColor(_item._quality)
        //        name.zPosition = zPosition + 1
        name.position.x = startX
        name.position.y = startY - cellSize + 12
        name.align = "left"
        addChild(name)
        //        var pptStartY = -cellSize * 2.3
        _bgHeight = cellSize * 5
        //        let greeting = "Hi there! It's nice to meet you! 👋"
        //        let endOfSentence = greeting.index(of: "!")!
        //        let st:String.Index = 0
        //        let firstSentence = greeting[...endOfSentence]
        //        let des = Label()
        //        let i = String.Index(of: 0)
        //        var s = ""
        //        for i in 0...7 {
        //            s += String()
        //        }
        //        item._description.index(String.In, offsetBy: 8)
        //        des.text = item._description.dropFirst(8)
        //        let s = _item._description.prefix(while: {0...8})
        //        var s = Substring()
        //        let d = item._description
        //        for i in 0...7 {
        //            s.append(d.index(String.Index(d), offsetBy: 1))
        //        }
        //        let a = Int(d, radix:10)
        //        des.text = a
        //        d[1]
        //        let i =
        //        d.split(separator: "", maxSplits: 4, omittingEmptySubsequences: Bool)
        //        let s = validIndex
        //        var sd = ""
        //        var id = 0
        //        for c in d {
        //            if id >= 5 && id <= 10 {
        //                sd.append(c)
        //            }
        //            id += 1
        //        }
        //        d.index
        //        des.fontColor = UIColor.white
        ////        des.fontName = ""
        //        des.align = "left"
        //        des.fontSize = 14
        //        des.position.x = startX
        //        des.position.y = name.position.y - cellSize * 0.5
        
        let des = MultipleLabel()
        des._lineCharNumber = 8
        des.text = item._description
        des.position.x = startX
        des.position.y = name.position.y - cellSize * 0.5
        addChild(des)
        
        if item._price > 0 {
            let price = Label()
            price.align = "left"
            price.position.x = startX + 1
            price.position.y = des.position.y - des._height - 30
            price.fontSize = 12
            if item is SpellBook {
                price.text = "出售价格：\(item._price)泪"
            } else {
                price.text = "出售价格：\(item._price)G"
            }
            addChild(price)
        }
        
        //        des.max
        //        des.numberOfLines
        //        des.numberOfLines = item._description.count / 8
        //        des.lineBreakMode = NSLineBreakMode.byCharWrapping
        //        item._description.substring(to: <#T##String.Index#>)
        //        Slice.
        //        addChild(des)
        
        
        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: -_bgHeight), size: CGSize(width: cellSize * 3, height: _bgHeight)), cornerRadius: 4 )
        bg.fillColor = UIColor.black
        bg.lineWidth = 2
        //        bg.glowWidth = 3
        bg.strokeColor = UIColor.lightGray
        _bg = bg
        addChild(bg)
        
        let img = SKShapeNode(rect: CGRect(x: 0, y: 0, width: cellSize, height: cellSize), cornerRadius: 2)
        img.position.x = startX
        img.position.y = startY - 12
        img.strokeColor = QualityColor.getColor(_item._quality)
        //        img.lineWidth = 2
        addChild(img)
        
        
        //        let gap:CGFloat = cellSize * 0.5
        //        for i in 0...armor._attrs.count - 1 {
        //            let label = Label()
        //            label.align = "left"
        //            label.fontSize = 16
        //            label.fontName = ""
        //            label.text = armor._attrs[i].getText()
        //            label.position.x = startX
        //            label.position.y = pptStartY - gap * i.toFloat()
        //            label.fontColor = UIColor.white
        //            addChild(label)
        //        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _bg = SKShapeNode()
    var _bgHeight:CGFloat = 0
}
