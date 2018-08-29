//
//  DeadEarth.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class DeadEarth: UIRandomScene {
    override func getEvilById(_ id: Int) -> Creature {
        switch id {
        case 0:
            return BoneWitch()
        case 1:
            return RedEyeDemon()
        case 2:
            return DeadSpirit()
        case 3:
            return WasteWalker()
        default:
            return BoneWitch()
        }
    }
    override func getItem() -> UIItem {
        let n = seed(max:140)
        if n < 10 {
            return TallStone()
        } else if  n < 20 {
            return StoneBlock()
        } else if n < 25 {
            return StonePillar()
        } else if n < 30 {
            return BrokenPillar()
        } else if n < 60 {
            return TallDeadTree()
        } else if n < 75 {
            return DeadTree()
        } else if n < 85 {
            return Grave()
        } else if n < 95 {
            return Stump()
        } else if n < 100 {
            return getTower()
        } else if n < 105 {
            return getGate()
        } else if n < 115 {
            return getUIEvil()
        }
        return UIItem()
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isRandomScene = true
        let oa4 = Data.instance.dungeon_a4
        _groundSets = GroundSets(ground: oa4.getCell(2, 2, 2, 2), wall: oa4.getCell(2, 4, 2, 2))
        _id = 1
        _name = "死亡峡谷"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BoneWitch: Rizen {
    override init() {
        super.init()
        _stars.strength = 1.0
        _stars.stamina = 1.0
        _stars.agility = 1.0
        _stars.intellect = 2.8
        _name = "白骨巫师"
        _spellSlot = SpellSlot(max: 2, min: 1)
        _spellsInuse = [FireBreath()]
        _img = Data.instance.pictureMonster.getCell(3, 7, 3, 4)
    }
}
class RedEyeDemon: Demon {
    override init() {
        super.init()
        _stars.strength = 1.0
        _stars.stamina = 2.1
        _stars.agility = 2.1
        _stars.intellect = 0.6
        _name = "红眼恶魔"
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Data.instance.pictureMonster.getCell(0, 7, 3, 4)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [Strong()]
        }
    }
}
class DeadSpirit: Rizen {
    override init() {
        super.init()
        _stars.strength = 0.8
        _stars.stamina = 1.0
        _stars.agility = 2.2
        _stars.intellect = 2.4
        _name = "死灵"
        _spellSlot = SpellSlot(max: 3, min: 1)
        _img = Data.instance.pictureMonster.getCell(6, 7, 3, 4)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [DeathStrike()]
        }
        if _spellCount > 1 && aQuarter() {
            _spellsInuse.append(Energetic())
        }
    }
    
}
class WasteWalker: Rizen {
    override init() {
        super.init()
        _stars.strength = 2.2
        _stars.stamina = 2.2
        _stars.agility = 1
        _stars.intellect = 0.4
        _name = "荒地行者"
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Data.instance.pictureMonster.getCell(9, 7, 3, 4)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [Cruel()]
        }
    }
    
}
class TallStone:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.dungeon_b.getCell(1, 9, 1, 2)
        setTexture(tree)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class StoneBlock:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.dungeon_b.getCell(1, 7)
        setTexture(tree)
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class StonePillar:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.dungeon_b.getCell(1, 11, 1, 2)
        setTexture(tree)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BrokenPillar:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.dungeon_b.getCell(1, 12)
        setTexture(tree)
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class TallDeadTree:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.outside_b.getCell(8, 6, 1, 2)
        setTexture(tree)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class Grave:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.outside_b.getCell(6, 9)
        setTexture(tree)
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
