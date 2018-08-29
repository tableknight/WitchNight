//
//  Nature.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//


class Natrue: Creature {
    override init() {
        super.init()
        _race = EvilType.NATURE
    }
}
class Demon: Creature {
    override init() {
        super.init()
        _race = EvilType.DEMON
    }
}
class Angel: Creature {
    override init() {
        super.init()
        _race = EvilType.ANGEL
    }
}
class Man: Creature {
    override init() {
        super.init()
        _race = EvilType.MAN
    }
}
class Rizen: Creature {
    override init() {
        super.init()
        _race = EvilType.RISEN
    }
}
class TheFinal: Creature {
    override init() {
        super.init()
        _race = EvilType.FINAL
    }
}
