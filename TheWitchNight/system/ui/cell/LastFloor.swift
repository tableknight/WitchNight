//
//  DoorToTop.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LastFloor: UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let texture = Data.instance.outside_b.getCell(14, 10)
        self.texture = texture
        self.size = texture.size()
        zLayer = UICell.UNDER_PLAYER
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func doTouch() {
        
    }
    
}
