//
//  SpellCard.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/20.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SpellCard: Card {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _spell:Spell!
    func create(spell:Spell) {
        _spell = spell
        let labelName = Label(spell._name, 0, 0)
        addChild(labelName)
    }
}
