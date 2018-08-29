//
//  SacredRing.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/5.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class RingOfDead:Ring {
    override init() {
        super.init()
        _name = "亡灵之戒"
        _description = "种族转换为亡灵。"
        _level = 12
        _chance = 100
    }
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        _attrCount = seed(min: 3, max: 6)
        createAttrs()
        hasInitialized = true
        createPrice()
    }
//    private var _backup = 0
    override func on() {
        super.on()
//        _backup = Data.instance._char._race
        Data.instance._char._race = EvilType.RISEN
    }
    
    override func off() {
        super.off()
        Data.instance._char._race = Data.instance._char._soulStone._race
        
    }
}
class IdlirWeddingRing:Ring {
    override init() {
        super.init()
        _name = "伊德利尔的婚戒"
        _description = "变形成为伊德利尔的新娘"
        _level = 29
        _chance = 100
    }
    override func createQuality() {
        sacredAttrCount()
    }
    var _originalImage = SKTexture()
    override func on() {
        super.on()
        _originalImage = Data.instance._char._img
        let t = SKTexture(imageNamed: "idlir_bride.png")
        Data.instance._char._img = t
        Data.instance.stage._char._charTexture = t
        Data.instance.stage._char.faceSouth()
    }
    override func off() {
        Data.instance._char._img = _originalImage
        Data.instance.stage._char._charTexture = _originalImage
        Data.instance.stage._char.faceSouth()
    }
}
class ApprenticeRing:Ring {
    override init() {
        super.init()
        _name = "学徒法戒"
        _description = "略微提高玩火的成功几率"
        _level = 15
        _chance = 50
    }
    override func createQuality() {
        sacredAttrCount()
    }
}
class CopperRing:Ring {
    override init() {
        super.init()
        _name = "铜质戒指"
        _description = "火焰抵抗 +5"
        _level = 5
        removeAttrId(id: FIRERESISTANCE)
        _chance = 100
    }
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        hasInitialized = true
        _attrCount = 3
        createAttrs()
        createPrice()
    }
    override func on() {
        super.on()
        Data.instance._char._ElementalResistance.fire += 5
    }
    override func off() {
        super.off()
        Data.instance._char._ElementalResistance.fire -= 5
    }
}
class SilverRing:Ring {
    override init() {
        super.init()
        _name = "银质戒指"
        _description = "火焰抵抗 +15"
        _level = 15
        removeAttrId(id: FIRERESISTANCE)
        _chance = 100
    }
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        hasInitialized = true
        _attrCount = 3
        createAttrs()
        createPrice()
    }
    override func on() {
        super.on()
        Data.instance._char._ElementalResistance.fire += 15
    }
    override func off() {
        super.off()
        Data.instance._char._ElementalResistance.fire -= 15
    }
}
class DellarsGoldenRing:Ring {
    override init() {
        super.init()
        _name = "德拉的金戒"
        _description = "火焰抵抗 +35"
        _level = 35
        removeAttrId(id: FIRERESISTANCE)
        _chance = 60
    }
    override func create(level:CGFloat) {
        _quality = Quality.SACRED
        hasInitialized = true
        _attrCount = seed(min: 3, max: 6)
        createAttrs()
        createPrice()
    }
    override func on() {
        super.on()
        Data.instance._char._ElementalResistance.fire += 35
    }
    override func off() {
        super.off()
        Data.instance._char._ElementalResistance.fire -= 35
    }
}
class LuckyRing:Ring {
    override init() {
        super.init()
        _name = "幸运指环"
        _avoid = seed(min: 10, max: 16).toFloat()
        _lucky = seed(min: 10, max: 16).toFloat()
        _description = "幸运 +\(_lucky) & 闪避 +\(_avoid)"
        _level = 15
        removeAttrId(id: LUCKY)
        removeAttrId(id: AVOID)
        _chance = 100
    }
    var _lucky:CGFloat = 0
    var _avoid:CGFloat = 0
    override func createQuality() {
        sacredAttrCount()
        _attrCount = 3
    }
    override func on() {
        super.on()
        Data.instance._char._lucky += _lucky
        Data.instance._char._extensions.avoid += _avoid
    }
    override func off() {
        super.off()
        Data.instance._char._lucky -= _lucky
        Data.instance._char._extensions.avoid -= _avoid
    }
}

