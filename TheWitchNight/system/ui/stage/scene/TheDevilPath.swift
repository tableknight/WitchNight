//
//  TheDevilPath.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/6/12.
//  Copyright © 2018年 Chen. All rights reserved.
//


import SpriteKit
class TheDevilPath: UIRandomScene {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let oa4 = Data.instance.dungeon_a4
        _groundSets = GroundSets(ground: oa4.getCell(4, 2, 2, 2), wall: oa4.getCell(4, 4, 2, 2))
        _name = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func getItem() -> UIItem {
        let sd = seed(max: 75)
        if sd < 8 {
            return DeadTree()
        } else if sd < 16 {
            return Stump()
        } else if sd < 18 {
            return getGate()
        } else if sd < 30 {
            return BigTree()
        } else if sd < 50 {
            return TallTree()
        } else if sd < 62 {
            return getUIEvil()
        } else if sd < 65 {
            return getTower()
        }
        
        return UIItem()
    }
    
    override func getEvilById(_ id: Int) -> Creature {
        switch id {
        case 0:
            return GiantWasp()
        case 1:
            return TreeSpirit()
        case 2:
            return Python()
        case 3:
            return VirulentToad()
        default:
            return GiantWasp()
        }
    }
}

