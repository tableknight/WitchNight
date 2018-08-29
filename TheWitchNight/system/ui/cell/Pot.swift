//
//  Pot.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Pot: UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let pot = Cell.pot()
        self.texture = pot
        self.size = pot.size()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func doTouch() {
        let pot_broken = Cell.pot_broken()
        self.texture = pot_broken
    }
    
}
