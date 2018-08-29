//
//  Meadow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Meadow: UIRandomScene {
    static var GIANTWASP = 0
    static var TREESPIRIT = 1
    static var VIRULENTTOAD = 2
    static var PYTHON = 3
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isRandomScene = true
        let oa4 = Data.instance.outside_a4
        _groundSets = GroundSets(ground: oa4.getCell(12, 2, 2, 2), wall: oa4.getCell(12, 4, 2, 2))
        _id = 0
        _name = "林间小径"
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

class TallTree:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let tree = Data.instance.outside_b.getCell(5, 12, 1, 2)
        setTexture(tree)
        _items = [0]
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class DeadTree:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.outside_b.getCell(4, 12)
        setTexture(item)
        _items = [0]
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Stump:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.outside_b.getCell(4, 11)
        setTexture(item)
        _items = [0]
        _xSize = 1
        _ySize = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class BigTree:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let item = Data.instance.outside_b.getCell(0, 15, 2, 2)
        setTexture(item)
        _items = [0, 0]
        _xSize = 2
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
class VirulentToad: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.1
        _stars.stamina = 2.8
        _stars.agility = 1.1
        _stars.intellect = 1.1
        _name = "绿精灵"
        _race = EvilType.NATURE
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Data.instance.pictureCollabo8_2.getCell(0, 3, 3, 4)
    }
}
class GiantWasp: Natrue {
    override init() {
        super.init()
        _stars.strength = 2.6
        _stars.stamina = 0.5
        _stars.agility = 2.1
        _stars.intellect = 0.8
        _name = "露琪"
        _race = EvilType.NATURE
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Data.instance.pictureNature.getCell(0, 7, 3, 4)
    }
    
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 && aQuarter() {
            _spellsInuse = [Reborn()]
        }
    }
}
class TreeSpirit: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.0
        _stars.stamina = 2.0
        _stars.agility = 1.0
        _stars.intellect = 2.2
        _name = "树精"
        _race = EvilType.NATURE
        _spellSlot = SpellSlot(max: 2, min: 0)
        _img = Data.instance.pictureNature.getCell(9, 7, 3, 4)
        //        _spells = [FrozenShoot()]
    }
    
    override func create(level: CGFloat) {
        super.create(level: level)
        if _spellCount > 0 {
            _spellsInuse = [FragileCurse()]
        }
    }
}
class Python: Natrue {
    override init() {
        super.init()
        _stars.strength = 1.5
        _stars.stamina = 1.6
        _stars.agility = 1.4
        _stars.intellect = 1.3
        _name = "花仙子"
        _race = EvilType.NATURE
        _spellSlot = SpellSlot(max: 1, min: 0)
        _img = Data.instance.pictureNature.getCell(3, 7, 3, 4)
    }
}

