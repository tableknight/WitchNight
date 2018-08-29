//
//  Loot.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Loot: Core {
    override init() {
        super.init()
        _char = Data.instance._char
    }
    private var _char:Character!
    func getWeaponById(id:Int) -> Weapon {
        switch id {
        case 0:
            return Bow()
        case 1:
            return Sword()
        case 2:
            return Wand()
        case 3:
            return Dagger()
        case 4:
            return Blunt()
        case 5:
            return Instrument()
        case 6:
            return Fist()
        default:
            return Sword()
        }
    }
    private var _weaponlist = [0,1,2,3,4,5,6]
    func lootWeapon(level:CGFloat) -> Weapon {
        let weapon = getWeaponById(id: seed(min: 0, max: 7))
        weapon.create(level: level)
        return weapon
    }
    
    func getArmorById(id:Int) -> Armor {
        switch id {
        case 0:
            return Amulet()
        case 1:
            return Ring()
        case 2:
            return MagicMark()
        case 3:
            return Ring()
        case 4:
            return Shield()
        case 5:
            return EarRing()
        default:
            return Ring()
        }
    }
    
    private var _armorlist = [0,1,2,3,4,5]
    func lootArmor(level:CGFloat) -> Armor {
        let armor = getArmorById(id: seed(min: 0, max: 6))
        armor.create(level: level)
        return armor
    }
    
    func loot(role:Creature) {
        var chance = seed().toFloat()
        let lucky = role._lucky * 0.01 + 1
        if chance < 20 * lucky  {
            let a = lootArmor(level: role._level)
//            _char.addProp(p: a)
//            debug("获得装备：Lv.\(a._level)\(a._name)")
            _props.append(a)
        }
        chance = seed().toFloat()
        if chance < 15 * lucky {
            let w = lootWeapon(level: role._level)
//            _char.addProp(p: w)
//            debug("获得武器：Lv.\(w._level)\(w._name)")
            _props.append(w)
        }
        chance = seed().toFloat()
        if chance < 2 * lucky {
            let book = SpellBook()
            book.spell = getSpellBook(role: role)
//            _char.addProp(p: book)
//            debug("获得技能书：[\(book._name)]")
            _props.append(book)
        }
        chance = seed().toFloat()
        if chance < 30 * lucky {
            let item = getItem()
//            _char.addProp(p: item)
//            debug("获得物品：[\(item._name)]")
            _props.append(item)
        }
        chance = seed().toFloat()
        if chance < 5 * lucky {
            if role._spellsInuse.count > 0 {
                let book = SpellBook()
                book.spell = role._spellsInuse[seed(max: role._spellsInuse.count)]
//                _char.addProp(p: book)
//                debug("获得技能书：[\(book._name)]")
                _props.append(book)
            }
        }
    }
    
    func getExp(level:CGFloat) -> CGFloat {
        let l = level + 1
        return l * l * atan(10.toFloat() + l * 0.1)
    }
    var _normalSpellArray = [0,1,2,3,4,5,6,7,8,9]
    
    
    
    func getSpellBook(role:Creature) -> Spell {
        let sed = seed()
        var spellAttay = Array<Int>()
        
        if sed < 50 {
            spellAttay = _normalSpellArray
            return getNormalSpell(id: spellAttay.one())
        } else if sed < 80 {
            spellAttay = _goodSpellArray
            return getGoodSpell(id: spellAttay.one())
        } else if sed < 96 {
            spellAttay = _rareSpellArray
            return getRareSpell(id: spellAttay.one())
        } else {
            spellAttay = _sacredSpellArray
            return getSacredSpell(id: spellAttay.one())
        }
    }
    
    func getNormalSpell(id:Int) -> Spell {
        switch id {
        case 0:
            return Cruel()
        case 1:
            return Bellicose()
        case 2:
            return BargeAbout()
        case 3:
            return FeignAttack()
        case 4:
            return FireBreath()
        case 5:
            return Heal()
        case 6:
            return Focus()
        case 7:
            return Strong()
        case 8:
            return Energetic()
        case 9:
            return ThunderAttack()
        default:
            return Cruel()
        }
    }
    var _goodSpellArray = [0,1,2,3,4,5,6,7,8,9,10,11]
    func getGoodSpell(id:Int) -> Spell {
        switch id {
        case 0:
            return BloodThirsty()
        case 1:
            return MultipleHit()
        case 2:
            return FireFist()
        case 3:
            return FrozenShoot()
        case 4:
            return Disappear()
        case 5:
            return IceFist()
        case 6:
            return QuickHeal()
        case 7:
            return Sacrifice()
        case 8:
            return Bitslap()
        case 9:
            return LastChance()
        case 10:
            return PriceOfBlood()
        case 11:
            return MightOfOaks()
        default:
            return BloodThirsty()
        }
    }
    var _rareSpellArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
    func getRareSpell(id:Int) -> Spell {
        switch id {
        case 0:
            return Lighting()
        case 1:
            return Crazy()
        case 2:
            return ProtectFromGod()
        case 3:
            return OneShootDoubleKill()
        case 4:
            return FireRain()
        case 5:
            return ThunderArray()
        case 6:
            return FragileCurse()
        case 7:
            return FireOrFired()
        case 8:
            return Firelord()
        case 9:
            return DeathStrike()
        case 10:
            return Taunt()
        case 11:
            return Interchange()
        case 12:
            return ProtectionFromIce()
        case 13:
            return IceGuard()
        case 14:
            return TruePower()
        case 15:
            return Dominate()
        case 16:
            return ShootAll()
        default:
            return Lighting()
        }
    }
    var _sacredSpellArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    func getSacredSpell(id:Int) -> Spell {
        switch id {
        case 0:
            return VampireBlood()
        case 1:
            return RaceSuperiority()
        case 2:
            return DancingOnIce()
        case 3:
            return OnePunch()
        case 4:
            return TurnAttack()
        case 5:
            return TurnMagic()
        case 6:
            return AttackReturnBack()
        case 7:
            return EyeToEye()
        case 8:
            return LifeDraw()
        case 9:
            return MagicSword()
        case 10:
            return Refresh()
        case 11:
            return SummonFlower()
        case 12:
            return SwapHealth()
        case 13:
            return Steal()
        case 14:
            return DeathGaze()
        case 15:
            return SpiritIntervene()
        case 16:
            return Immune()
        case 17:
            return Reborn()
        case 18:
            return SoulLash()
        default:
            return VampireBlood()
        }
    }
    
    func getItem() -> Item {
        let chance = seed()
        if chance < 50 {
            return TheWitchsTear()
        }
        if chance < 75 {
            return LittlePotion()
        }
        if chance < 90 {
            return Potion()
        }
        if chance < 95 {
            return TownScroll()
        }
        if chance < 98 {
            return SealScroll()
        }
        
        return TheWitchsTear()
    }
    private var _props = Array<Prop>()
    func getList() -> Array<Prop> {
        return _props
    }
    var _sacredSwords = [1,2,3,4,5,6,7]
    func getSacredSword(id:Int) -> Sword {
        switch id {
        case 1:
            return NewSword()
        case 2:
            return NewSwordPlus()
        case 3:
            return DragonSlayer()
        case 4:
            return DragonSaliva()
        case 5:
            return TheExorcist()
        case 6:
            return BloodBlade()
        case 7:
            return ElementalSword()
        default:
            return NewSword()
        }
    }
    var _sacredDaggers = [1,2]
    func getSacredDagger(id:Int) -> Dagger {
        switch id {
        case 1:
            return NightBlade()
        case 2:
            return LazesPedicureKnife()
        default:
            return NightBlade()
        }
    }
    var _sacredShields = [1,2,3,4]
    func getSacredShield(id:Int) -> Shield {
        switch id {
        case 1:
            return Faceless()
        case 2:
            return Accident()
        case 3:
            return FrancisFace()
        case 4:
            return EvilExpel()
        default:
            return Faceless()
        }
    }
    var _sacredAmulets = [1,2,3,4,5,6,7,8]
    func getSacredAmulet(id:Int) -> Amulet {
        switch id {
        case 1:
            return TrueLie()
        case 2:
            return MedalOfCourage()
        case 3:
            return FangOfVampire()
        case 4:
            return MoonShadow()
        case 5:
            return EternityNight()
        case 6:
            return Sparkling()
        case 7:
            return MedalOfHero()
        case 8:
            return JadeHeart()
        default:
            return TrueLie()
        }
    }
    var _sacredRings = [1,2,3,4,5,6,7]
    func getSacredRing(id:Int) -> Ring {
        switch id {
        case 1:
            return RingOfDead()
        case 2:
            return IdlirWeddingRing()
        case 3:
            return ApprenticeRing()
        case 4:
            return CopperRing()
        case 5:
            return SilverRing()
        case 6:
            return DellarsGoldenRing()
        case 7:
            return LuckyRing()
        default:
            return LuckyRing()
        }
    }
    var _sacredSoulstones = [1,2,3]
    func getSacredSoulstone(id:Int) -> SoulStone {
        switch id {
        case 1:
            return HeartOfSwamp()
        case 2:
            return PandoraHearts()
        case 3:
            return HeartOfTarrasque()
        default:
            return HeartOfSwamp()
        }
    }
    var _sacredInstruments = [1,2]
    func getSacredInstrument(id:Int) -> Instrument {
        switch id {
        case 1:
            return TheMonatNotes()
        case 2:
            return NoPants()
        default:
            return TheMonatNotes()
        }
    }
    var _sacredWands = [1,2,3,4]
    func getSacredWand(id:Int) -> Wand {
        switch id {
        case 1:
            return LightingRod()
        case 2:
            return FireMaster()
        case 3:
            return WitchWand()
        case 4:
            return PuppetMaster()
        default:
            return LightingRod()
        }
    }
    var _sacredBlunts = [1,2,3,4,5]
    func getSacredBlunt(id:Int) -> Blunt {
        switch id {
        case 1:
            return IberisThignbone()
        case 2:
            return GiantFang()
        case 3:
            return ThorsHammer()
        case 4:
            return HolyPower()
        case 5:
            return IdyllssHand()
        default:
            return IberisThignbone()
        }
    }
    var _sacredMarks = [1,2,3,4,5,6,7]
    func getSacredMark(id:Int) -> MagicMark {
        switch id {
        case 1:
            return PuppetMark()
        case 2:
            return MarkOfOaks()
        case 3:
            return MarkOfDeathGod()
        case 4:
            return MarkOfVitality()
        case 5:
            return MarkOfHeaven()
        case 6:
            return MoltenFire()
        case 7:
            return TheEye()
        default:
            return PuppetMark()
        }
    }
    var _sacredBows = [1,2,3,4]
    func getSacredBow(id:Int) -> Bow {
        switch id {
        case 1:
            return Hawkeye()
        case 2:
            return Boreas()
        case 3:
            return Skylark()
        case 4:
            return SoundOfWind()
        default:
            return Hawkeye()
        }
    }
    var _sacredEarrings = [1,2,3,4]
    func getSacredEarring(id:Int) -> EarRing {
        switch id {
        case 1:
            return VerdasTear()
        case 2:
            return DeepSeaPearl()
        case 3:
            return EyeOfDius()
        case 4:
            return LavaCrystal()
        default:
            return VerdasTear()
        }
    }
    private func getSacredOutfit(id:Int) -> Outfit {
        switch id {
        case 1:
            return getSacredSword(id:_sacredSwords.one())
        case 2:
            return getSacredDagger(id:_sacredDaggers.one())
        case 3:
            return getSacredShield(id:_sacredShields.one())
        case 4:
            return getSacredAmulet(id:_sacredAmulets.one())
        case 5:
            return getSacredRing(id:_sacredRings.one())
        case 6:
            return getSacredSoulstone(id:_sacredSoulstones.one())
        case 7:
            return getSacredInstrument(id:_sacredInstruments.one())
        case 8:
            return getSacredWand(id:_sacredWands.one())
        case 9:
            return getSacredBlunt(id:_sacredBlunts.one())
        case 10:
            return getSacredMark(id:_sacredMarks.one())
        case 11:
            return getSacredBow(id:_sacredBows.one())
        case 12:
            return getSacredEarring(id:_sacredEarrings.one())
        default:
            return getSacredSword(id:_sacredSwords.one())
        }
    }
    
    func getSacred() -> Outfit? {
        let outfit = getSacredOutfit(id: [1,2,3,4,5,6,7,8,9,10,11,12].one())
        if outfit._level <= _char._level {
            if seed() < outfit._chance {
                outfit.create(level: outfit._level)
                return outfit
            }
        }
        return nil
    }
    
    //abandoned
    private func resetSacredChance() {
        _sacredSwords = []
        _sacredDaggers = []
        _sacredShields = []
        _sacredAmulets = []
        _sacredRings = []
        _sacredSoulstones = []
        _sacredInstruments = []
        _sacredWands = []
        _sacredBlunts = []
        _sacredMarks = []
        _sacredBows = []
        _sacredEarrings = []
    }
}
