//
//  IBattleItem.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
protocol IBItem {
    func use(unit:BUnit) -> Void
    func usableInBattle() -> Bool
    func timeleft() -> Int
}
