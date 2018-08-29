//
//  UIEvil.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIEvil: UIUnit {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func triggerEvent() {
        
        let sc = Data.instance.stage._curScene
        
        let b = Battle()
        b.setEvils(evils: sc.getEvil(id: _thisType)._evils)
        let char = Data.instance._char!
        let roles = [char] + char.getReadyMinions()
        
        b.setRoles(roles: roles)
        b.zPosition = UIStage.LAYER6
        b.battleStart()
        Data.instance.stage.addBattle(b: b)
        
//        Data.instance.stage.hideUI()
//        Data.instance.stage.hideScene()
    }
    var _evils = Array<Creature>()
    var _thisType = -1
}

