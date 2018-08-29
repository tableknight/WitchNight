//
//  War.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class War: Battle {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
