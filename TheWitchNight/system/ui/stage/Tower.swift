//
//  Tower.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/30.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Tower:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    internal var _triggered = false
}
class FireEnergeTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.tiled_dungeons.getCell(15, 11, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = FireEnerge()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class WaterEnergeTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.tiled_dungeons.getCell(14, 11, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = WaterEnerge()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class ThunderEnergeTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.dungeon_b.getCell(13, 8, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = ThunderEnerge()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class TimeReduceTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.dungeon_b.getCell(12, 8, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = TimeReduce()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class PhysicalPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.dungeon_b.getCell(8, 8, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = PhysicalPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class MagicalPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.inside_c.getCell(11, 6, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = MagicalPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class AttackPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.dungeon_b.getCell(9, 8, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = AttackPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class DefencePowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.dungeon_b.getCell(10, 8, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = DefencePower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class MindPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.inside_c.getCell(8, 6, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = MindPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class LuckyPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.sf_inside_c.getCell(8, 11, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = LuckyPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
class SpeedPowerTower:Tower {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(Data.instance.sf_inside_c.getCell(10, 11, 1, 2))
        _xSize = 1
        _ySize = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func triggerEvent() {
        if !_triggered {
            _triggered = true
            let s = SpeedPower()
            showMsg(text: "[\(s._name)] \(s._description)")
            Data.instance.stage.addStatus(status: s)
        }
    }
}
