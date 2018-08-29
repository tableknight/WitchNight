//
//  LostForest.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/7.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BloodSquare: UIRandomScene {
    override func getEvilById(_ id: Int) -> Creature {
        switch id {
        case 0:
            return BloodyBat()
        case 1:
            return Kodagu()
        case 2:
            return EvilSpirit()
        case 3:
            return HellBaron()
        default:
            return BloodyBat()
        }
    }
    override func getItem() -> UIItem {
        let n = seed(max:90)
        if n < 25 {
            return BloodItem1()
        } else if  n < 50 {
            return BloodItem2()
        } else if n < 53 {
            return getTower()
        } else if n < 54 {
            return getGate()
        } else if n < 62 {
            return getUIEvil()
        } else if n < 70 {
            return BloodPillar()
        } else if n < 75 {
            return BloodPillarSmall()
        } else if n < 80 {
            return BloodPillarShard()
        }
        return UIItem()
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isRandomScene = true
        let oa4 = Data.instance.dungeon_a4
        _groundSets = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
        _id = 4
        _name = "鲜血平原"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BloodyBat: Demon {
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 2.2
        _stars.agility = 1.4
        _stars.intellect = 0.9
        _name = "血色蝙蝠"
        _spellSlot = SpellSlot(max: 2, min: 0)
        _img = Data.instance.pictureMonster.getCell(0, 3, 3, 4)
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [VampireBlood()]
        }
    }
}

class Kodagu: Demon {
    override init() {
        super.init()
        _stars.strength = 2.2
        _stars.stamina = 2.2
        _stars.agility = 0.6
        _stars.intellect = 0.6
        _name = "达古"
        _spellSlot = SpellSlot(max: 2, min: 0)
        _img = SKTexture(imageNamed: "Kodagu.png")
        specialUnit = true
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [BargeAbout()]
        }
    }
}

class EvilSpirit: Natrue {
    override init() {
        super.init()
        _stars.strength = 0.5
        _stars.stamina = 1.5
        _stars.agility = 0.8
        _stars.intellect = 2.5
        _name = "邪灵"
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Data.instance.pictureEvil.getCell(9, 3, 3, 4)
    }
    
}

class HellBaron: Natrue {
    override init() {
        super.init()
        _stars.strength = 0.6
        _stars.stamina = 0.6
        _stars.agility = 2.1
        _stars.intellect = 2.4
        _name = "地狱男爵"
        _spellSlot = SpellSlot(max: 3, min: 0)
        _img = SKTexture(imageNamed: "HellBaron.png")
    }
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [LifeDraw()]
        }
    }
}

class BloodItem2:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.dungeon_b.getCell(6, 9, 1, 2)
        setTexture(tree)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BloodItem1:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.dungeon_b.getCell(6, 7)
        setTexture(tree)
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BloodPillar:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.dungeon_b.getCell(6, 9, 1, 2)
        setTexture(tree)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BloodPillarSmall:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.dungeon_b.getCell(6, 7)
        setTexture(tree)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class BloodPillarShard:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.dungeon_b.getCell(6, 6)
        setTexture(tree)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

