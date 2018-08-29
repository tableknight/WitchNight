//
//  Bed.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/1.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Bed: UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let bed = Cell.bed()
        self.texture = bed
        self.size = bed.size()
        xSize = 1
        ySize = 2
        _matrix = [[Block.TOUCHABLEITEM],[Block.TOUCHABLEITEM]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func doTouch() {
//        let pot_broken = Cell.pot_broken()
        self.texture = Cell.bed_broken()
    }
    
}

