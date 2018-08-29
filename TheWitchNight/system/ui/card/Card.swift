//
//  Card.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/19.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Card:SKSpriteNode{
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let t = SKTexture(imageNamed: "card.png")
        self.texture = t
        
        self.size = t.size()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setSize(which:Int) {
        if 4 == which {
            self.size = CGSize(width: 96, height: 72)
        } else if 5 == which {
            self.size = CGSize(width: 80, height: 60)
        }
    }
    
}
