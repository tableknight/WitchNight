//
//  Bunit.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/12.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BUnit: SKSpriteNode {
    static var LLT = "llt"
    static var LLM = "llm"
    static var LLB = "llb"
    static var LRT = "lrt"
    static var LRM = "lrm"
    static var LRB = "lrb"
    
    static var RLT = "rlt"
    static var RLM = "rlm"
    static var RLB = "rlb"
    static var RRT = "rrt"
    static var RRM = "rrm"
    static var RRB = "rrb"
    
    
    var inleft = true
    var _battle:Battle!
    var _stage:UIStage!
    var specialUnit = false
    static var STAND_BY = "standby"
    private var _select = SKSpriteNode()
    private var _selectTexture = SKTexture(imageNamed: "select.png")
    var hasInitialized = false
    var isDefend = false
    var _speed: CGFloat = 0
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _stage = Data.instance.stage
    }
    var isEmpey = false
    func createEmpty() {
        self.size = CGSize(width: cellSize * 1.2, height: cellSize * 1.2)
        circleY = -0.26 * cellSize
        _select.size = CGSize(width: cellSize, height: cellSize)
        _select.texture = _selectTexture.getCell(3, 0)
        _select.position.y = circleY
        _select.zPosition = 40
        _charNode.zPosition = 50
        _select.alpha = 0.5
        //        faceEast()
        addChild(_select)
        isEmpey = true
    }
    func create(isChief:Bool = false) {
        hasInitialized = true
        self.size = CGSize(width: cellSize * 1.2, height: cellSize * 1.2)
        _charSize = cellSize
        _charNode.size = CGSize(width: _charSize, height: _charSize)
        circleY = -0.26 * cellSize
        _select.size = CGSize(width: cellSize, height: cellSize)
        _select.texture = _selectTexture.getCell(3, 0)
        _select.position.y = circleY
        _select.zPosition = 40
        _charNode.zPosition = 50
//        faceEast()
        addChild(_select)
        addChild(_charNode)
        
        createLabel()
        
        let hpbarHeight = _charSize * 0.05
        let bar = SKShapeNode(rect: CGRect(x: -_charSize * 0.4, y: 0, width: _charSize * 0.8, height: hpbarHeight))
        bar.fillColor = UIColor.black
        bar.zPosition = 50
        bar.position.y = -_charSize * 0.70
        addChild(bar)
        
        createHPBar()
        
    }
    func createForStage() {
        hasInitialized = true
        self.size = CGSize(width: cellSize * 1.2, height: cellSize * 1.2)
        _charSize = cellSize
        _charNode.size = CGSize(width: _charSize, height: _charSize)
        circleY = -0.26 * cellSize
        _select.size = CGSize(width: cellSize, height: cellSize)
        _select.texture = _selectTexture.getCell(3, 0)
        _select.position.y = circleY
        _select.zPosition = 40
        _charNode.zPosition = 50
        //        faceEast()
        addChild(_select)
        addChild(_charNode)
    }
    func removeFromBattle() {
        _battle.removeFromPart(unit: self)
    }
    private func createLabel() {
        let label = Label.init("12", 0, cellSize * 0.5, UIColor.red)
        label.fontSize = 13
        label.zPosition = 100
        addChild(label)
        label.isHidden = true
        _valueText = label
    }
    private func addLabel() -> Label {
        let label = Label.init("12", 0, cellSize * 0.5, UIColor.red)
        label.fontSize = 13
        label.zPosition = 100
        addChild(label)
        return label
    }
    private func createHPBar(value:CGFloat = 1) {
        let hpbarHeight = _charSize * 0.05
        _hpbar = SKShapeNode(rect: CGRect(x: -_charSize * 0.4, y: 0, width: _charSize * 0.8 * value, height: hpbarHeight))
        _hpbar.fillColor = UIColor.red
        _hpbar.zPosition = 50
        _hpbar.position.y = -_charSize * 0.70
        addChild(_hpbar)
    }
    private var _valueText = Label()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _unit:Creature = Creature()
    var _levelLabel = Label()
    func setUnit(unit:Creature) -> Void {
        _unit = unit
//        _speed = unit._extensions.speed
        _levelLabel = Label("L\(unit._level.toInt())\(unit._name)", 0, -_charSize, QualityColor.getColor(unit._quality))
        _levelLabel.zPosition = 71
        _levelLabel.fontSize = 11
        _levelLabel.isHidden = true
        addChild(_levelLabel)
        let per = _unit._extensions.hp / _unit._extensions.health
        _hpbar.removeFromParent()
        createHPBar(value: per)
        _charTexture = unit._img
    }
    var _charTexture = SKTexture()
    private var _charNode = SKSpriteNode()
    func faceSouth() {
        _charNode.texture = _charTexture.getCell(1, 0)
    }
    func faceNorth() {
        var y:CGFloat = 3
        if specialUnit {
            y = 2
        }
        _charNode.texture = _charTexture.getCell(1, y)
    }
    func faceWest() {
        _charNode.texture = _charTexture.getCell(1, 1)
    }
    func faceEast() {
        var y:CGFloat = 2
        if specialUnit {
            y = 3
        }
        _charNode.texture = _charTexture.getCell(1, y)
    }
    internal var _wait:SKAction! = SKAction.wait(forDuration: TimeInterval(Data.instance.frameSize))
    func moveNorth() {
        //        faceBack()
        var y:CGFloat = 3
        if specialUnit {
            y = 2
        }
        let move1 = SKAction.setTexture(_charTexture.getCell(0, y))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, y))
        //        let stop = SKAction.setTexture(_charTexture.getTextureCell(1, 3))
        let go = SKAction.sequence([move1, _wait, move2, _wait])
        //        let re = SKAction.repeat(go, count: 5)
        _charNode.run(go)
        //        faceNorth()
    }
    
    func moveSouth() {
        //        faceFront()
        let move1 = SKAction.setTexture(_charTexture.getCell(0, 0))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, 0))
        let go = SKAction.sequence([move1, _wait, move2, _wait])
        _charNode.run(go)
        //        let stop = SKAction.setTexture(_charTexture.getTextureCell(1, 3))
        //        let re = SKAction.repeat(go, count: 5)
        //        let _self = self
    }
    func moveWest() {
        let move1 = SKAction.setTexture(_charTexture.getCell(0, 1))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, 1))
        let go = SKAction.sequence([move1, _wait, move2, _wait])
        _charNode.run(go)
    }
    func moveWest4frame() {
        let move1 = SKAction.setTexture(_charTexture.getCell(0, 1))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, 1))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1, _wait, move2, _wait])
        _charNode.run(go)
    }
    func moveEast() {
        var y:CGFloat = 2
        if specialUnit {
            y = 3
        }
        let move1 = SKAction.setTexture(_charTexture.getCell(0, y))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, y))
        let go = SKAction.sequence([move1, _wait, move2, _wait])
        _charNode.run(go)
    }
    func moveEast4frame() {
        var y:CGFloat = 2
        if specialUnit {
            y = 3
        }
        let move1 = SKAction.setTexture(_charTexture.getCell(0, y))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, y))
        let go = SKAction.sequence([move1, _wait, move2, _wait, move1, _wait, move2, _wait])
        _charNode.run(go)
    }
    
    func actionAttack(completion:@escaping () -> Void) {
        var v = CGVector(dx: cellSize * 0.5, dy: 0)
        var v2 = CGVector(dx: -cellSize * 0.5, dy: 0)
        if "right" == unitPos {
            v = CGVector(dx: -cellSize * 0.5, dy: 0)
            v2 = CGVector(dx: cellSize * 0.5, dy: 0)
        }
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.15))
        let go = SKAction.sequence([move1, wait, move2])
        let this = self
        _charNode.run(go, completion: {
            completion()
            if this._battle._selectedTarget.hasStatus(type: Status.ICE_GUARD) {
                if this.seed() < 15 {
                    this._extensions.speed -= 10
                    this.showText(text: "SPEED -10")
                    let status = LostSpeed()
                    status._source = this
                    this.addStatus(status: status)
                }
            }
        })
    }
    func actionWait(ti:CGFloat = 1, completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(ti))
        _charNode.run(wait, completion: completion)
    }
    func actionBuff(completion:@escaping () -> Void) {
        auroUp(x: 2)
        let this = self
        setTimeout(delay: 0.2, completion: {
            this.auroUp(x: 2)
        })
        setTimeout(delay: 0.4, completion: {
            this.auroUp(x: 2)
        })
        setTimeout(delay: 0.6, completion: {
            this.auroUp(x: 2)
        })
        setTimeout(delay: 0.8, completion: {
            this.auroUp(x: 2) {
                completion()
            }
        })
    }
    var _acting = false
    func actionAttacked(defend:Bool = false, completion:@escaping () -> Void) {
        if _acting {
            debug("正在表演")
//            completion()
//            return
        }
        if defend {
            actionDefead {
                completion()
            }
            return
        }
        _acting = true
        let d = cellSize * 0.12
        var v = CGVector(dx: -d, dy: 0)
        var v2 = CGVector(dx: d, dy: 0)
        if "right" == unitPos {
            v = CGVector(dx: d, dy: 0)
            v2 = CGVector(dx: -d, dy: 0)
        }
//        let w = SKAction.wait(forDuration: TimeInterval(2))
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.8))
        let go = SKAction.sequence([move1, wait, move2])
        let this = self
        _charNode.run(go) {
        }
        let fadeOut = SKAction.fadeOut(withDuration: TimeInterval(0))
        let fadeIn = SKAction.fadeIn(withDuration: TimeInterval(0))
        let fadeWait = SKAction.wait(forDuration: TimeInterval(0.2))
        let fadeGo = SKAction.sequence([fadeOut, fadeWait, fadeIn, fadeWait, fadeOut, fadeWait, fadeIn, fadeWait, fadeOut, fadeWait, fadeIn])
        _charNode.run(fadeGo) {
            this._acting = false
            completion()
        }
    }
    func actionDefead(completion:@escaping () -> Void) {
        let size = cellSize * 0.05
        var v = CGVector(dx: -size, dy: 0)
        var v2 = CGVector(dx: size, dy: 0)
        if !inleft {
            v = CGVector(dx: size, dy: 0)
            v2 = CGVector(dx: -size, dy: 0)
        }
//        let w = SKAction.wait(forDuration: TimeInterval(2))
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.05))
        let go = SKAction.sequence([move1, wait, move2])
        _charNode.run(go, completion: completion)
    }
    func actionCast(completion:@escaping () -> Void) {
        let wt1 = SKAction.wait(forDuration: TimeInterval(1))
        let wt = SKAction.wait(forDuration: TimeInterval(0.1))
        let n = SKAction.setTexture(_charTexture.getCell(0, 3))
        let w = SKAction.setTexture(_charTexture.getCell(0, 1))
        let s = SKAction.setTexture(_charTexture.getCell(0, 0))
        let e = SKAction.setTexture(_charTexture.getCell(0, 2))
        var go = SKAction.sequence([wt1, wt, s, wt, w, wt, n, wt, e, wt, s, wt, w, wt, n, wt, e, wt1])
        if !inleft {
            go = SKAction.sequence([wt1, wt, s, wt, e, wt, n, wt, w, wt, s, wt, e, wt, n, wt, w, wt1])
        }
        _charNode.run(go) {
            completion()
        }
    }
    func actionAvoid(completion:@escaping () -> Void) {
        let d = cellSize * 0.3
        var v = CGVector(dx: -d, dy: 0)
        var v2 = CGVector(dx: d, dy: 0)
        if !inleft {
            v = CGVector(dx: d, dy: 0)
            v2 = CGVector(dx: -d, dy: 0)
        }
        //        let w = SKAction.wait(forDuration: TimeInterval(2))
        let move1 = SKAction.move(by: v, duration: 0)
        let move2 = SKAction.move(by: v2, duration: 0)
        let wait = SKAction.wait(forDuration: TimeInterval(0.8))
        let go = SKAction.sequence([move1, wait, move2])
        _charNode.run(go, completion: completion)
        
    }
    //被选择的单位效果
    func setSelectedMode() {
        _select.texture = _selectTexture.getCell(0, 0)
        let move = SKAction.setTexture(_selectTexture.getCell(3, 0))
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        let go = SKAction.sequence([wait, move])
        _select.run(go)
    }
    var _charSize:CGFloat = 0
    private var _hpbar = SKShapeNode()
    private var circleY:CGFloat = 0
    var _seat:String = ""
    var unitPos = "left"
    var selectable = false
    func setOrderMode() {
        _select.texture = _selectTexture.getCell(0, 0)
        selectable = false
    }
    func setDefaultMode() {
        _select.texture = _selectTexture.getCell(3, 0)
        selectable = false
    }
    func setSelectableMode(which:String = "left") {
        var x:CGFloat = 2
        if "left" != which {
            x = 1
        }
        _select.texture = _selectTexture.getCell(x, 0)
        selectable = true
    }
    func markDeathGod() -> Bool {
        if _unit is Character {
            let char = _unit as! Character
            if char._magicMark is MarkOfDeathGod {
                return true
            }
        }
        return false
    }
    func markOfHeaven(value:CGFloat) -> Bool {
        if value < 0 && _battle._curRole._unit._race == EvilType.DEMON {
            if _unit is Character {
                let char = _unit as! Character
                if char._magicMark is MarkOfHeaven {
                    return true
                }
            }
        }
        return false
    }
    func silenced(completion:@escaping () -> Void) {
        if markDeathGod() {
            showText(text: "IMMUNE") {
                completion()
            }
            return
        }
        let index = _battle._roleAll.index(of: self)
        if nil != index {
            _battle._roleAll.remove(at: index!)
        }
        showText(text: "SILENCE", completion: completion)
    }
    func shieldFrancisFace() -> Bool {
        if _unit is Character {
            let char = _unit as! Character
            if char._shield is FrancisFace {
                return true
            }
        }
        return false
    }
    func markMightOfOaks() -> Bool {
        if !_battle._selectedSpell.isPhysical {
            return false
        }
        if _unit is Character {
            let char = _unit as! Character
            if char._magicMark is MarkOfOaks {
                return true
            }
            
        }
        return false
    }
    func sheildEvilExpel(value:CGFloat) -> Bool {
        if value < 0 {
            if _battle._curRole._unit._race == EvilType.DEMON {
                if _unit is Character {
                    let char = _unit as! Character
                    if char._shield is EvilExpel {
                        return true
                    }
                }
            }
        }
        return false
    }
    func showValue(value:CGFloat, isCritical:Bool = false, textColor:UIColor = DamageColor.DAMAGE, completion:@escaping () -> Void = {}) {
        var value = value
        if sheildEvilExpel(value: value) {
            showText(text: "BLOCK") {
                completion()
            }
            return
        }
        if shieldAccident(value: value, completion: {}) {
            showText(text: "SHIFT")
            var targets = Array<BUnit>()
            for u in _battle._leftRoles {
                if !(u._unit is Character) {
                    targets.append(u)
                }
            }
            let t = targets.one()
            t.hpChange(value: value)
            t.showValue(value: value) {
                completion()
            }
            return
        }
        var beCritical = isCritical
        if !beCritical {
            beCritical = _battle._selectedSpell.beCritical
        }
//        if isCritical {
//            showText(text: "Critical", color: UIColor.red) {
//                completion()
//            }
//            return
//        }
        
        if amuletJadeHeart() {
            value *= 0.85
        }
        if markOfHeaven(value: value) {
            value *= 0.85
        }
        let valueText = addLabel()
//        valueText.isHidden = false
        valueText.position.y = cellSize * 0.3
        var color = textColor
        var text = "\(value.toInt())";
        if value > 0 {
            color = DamageColor.HEAL
            text = "+\(value.toInt())"
        }
        if beCritical {
//            valueText.fontSize = 18
//            color = DamageColor.NORMAL
            text = "CRITICAL"
        }
        if swordExorcist(value: value) {
            text = "KILL"
            color = DamageColor.NORMAL
            _unit._extensions.hp = 0
        }
        if amuletMadelOfHero(value: value) {
            color = DamageColor.NORMAL
            text = "STAND"
        }
        valueText.text = text
        valueText.fontColor = color
        let v = CGVector(dx: 0, dy: cellSize * 0.25)
        let move = SKAction.move(by: v, duration: TimeInterval(0.25))
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        let go = SKAction.sequence([move, wait])
        let this = self
        valueText.run(go) {
            valueText.removeFromParent()
        }
        setTimeout(delay: 0.5, completion: {
            if this.isDead() {
                this.actionDead {
                    this.removeFromBattle()
                    this.removeFromParent()
                    if !this._battle.hasFinished() {
                        completion()
                    }
                }
            } else {
                completion()
                if this.shieldFrancisFace() {
                    if this.seed() < 10 {
                        this.showText(text: "CRITICAL +5")
                        this._extensions.critical += 5
                    }
                }
                if this.markMightOfOaks() {
                    if this.seed() < 10 {
                        this.showText(text: "MIGHT OF OAKS")
                        let s = Status()
                        s._type = Status.MIGHT_OF_OAKS
                        s._timeleft = 5
                        this.addStatus(status: s)
                    }
                }
            }
        })
    }
    func showText(text:String = "", color:UIColor = UIColor.white, completion:@escaping () -> Void = {}) {
        if "" == text {
            return
        }
        let valueText = addLabel()
//        _valueText.isHidden = false
        valueText.position.y = cellSize * 0.3
        valueText.text = text
        valueText.fontColor = color
        let v = CGVector(dx: 0, dy: cellSize * 0.2)
        let move = SKAction.move(by: v, duration: TimeInterval(0.25))
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        let go = SKAction.sequence([move, wait])
//        let this = self
        valueText.run(go) {
            completion()
//            this._valueText.isHidden = true
            valueText.removeFromParent()
        }
    }
    func die() {
        removeFromBattle()
        removeFromParent()
    }
    func shieldAccident(value:CGFloat, completion:@escaping () -> Void) -> Bool {
        if _unit is Character {
            let char = _unit as! Character
            if char._shield is Accident {
                if value < 0 {
                    if _battle._leftRoles.count > 2 {
                       return true
                    }
                    
                }
            }
        }
        return false
    }
    func swordExorcist(value:CGFloat) -> Bool {
        if _unit._race == EvilType.RISEN {
            if _battle._curRole._unit is Character {
                if _battle._curRole._unit._weapon is TheExorcist {
                    if _battle._selectedSpell.isPhysical {
                        return true
                    }
                }
            }
        }
        return false
    }
    func amuletMadelOfHero(value:CGFloat) -> Bool {
        if _unit is Character {
            let char = _unit as! Character
            if char._amulet is MedalOfHero {
                if value < 0 && abs(value) > getHp() {
                    return true
                }
            }
        }
        return false
    }
    func amuletJadeHeart() -> Bool {
        if _battle._curRole._unit is PowerLord {
            if _unit is Character {
                let char = _unit as! Character
                if char._amulet is JadeHeart {
                    return true
                }
            }
        }
        return false
    }
    func hpChange(value:CGFloat) {
        if sheildEvilExpel(value: value) {
            return
        }
        if shieldAccident(value: value, completion: {}) {
            return
        }
        if swordExorcist(value: value) {
            return
        }
        if amuletMadelOfHero(value: value) {
            return
        }
        var hp = value
        if amuletJadeHeart() {
            hp *= 0.85
        }
        if markOfHeaven(value: value) {
            hp *= 0.85
        }
        _unit._extensions.hp += hp
        if _unit._extensions.hp > _unit._extensions.health {
            _unit._extensions.hp = _unit._extensions.health
        }
        if _unit._extensions.hp < 0 {
            _unit._extensions.hp = 0
        }
        let per = _unit._extensions.hp / _unit._extensions.health
        _hpbar.removeFromParent()
        createHPBar(value: per)
//        let this = self
//        if isDead() {
//            actionDead {
//                this.removeFromParent()
//            }
//            this._battle.removeFromPart(unit: this)
//        }
    }
    func actionDead(completion:@escaping () -> Void) {
        let wait = SKAction.fadeAlpha(to: 0, duration: TimeInterval(0.75))
        _charNode.run(wait, completion: completion)
    }
    func actionSummon(completion:@escaping () -> Void) {
        _charNode.alpha = 0
        let wait = SKAction.fadeAlpha(to: 1, duration: TimeInterval(0.75))
        _charNode.run(wait, completion: completion)
    }
    func actionRecall(completion:@escaping () -> Void) {
        let wait = SKAction.fadeAlpha(to: 0, duration: TimeInterval(0.75))
        _charNode.run(wait, completion: completion)
    }
    func actionFrozen(completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        _charNode.run(wait, completion: completion)
    }
    func actionCursed(completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        _charNode.run(wait, completion: completion)
    }
    func actionUnfreeze(completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        _charNode.run(wait, completion: completion)
    }
    func auroUp(x:CGFloat = 1, completion:@escaping () -> Void = {}) {
        let node = SKSpriteNode(texture: _selectTexture.getCell(x, 1))
        node.zPosition = 80
        node.position.y = -cellSize * 0.25
        addChild(node)
        let move = SKAction.moveBy(x: 0, y: cellSize * 0.75, duration: TimeInterval(0.5))
        node.run(move) {
            node.removeFromParent()
            completion()
        }
    }
    func actionHealed(completion:@escaping () -> Void) {
        auroUp()
        let this = self
        setTimeout(delay: 0.2, completion: {
            this.auroUp()
        })
        setTimeout(delay: 0.4, completion: {
            this.auroUp()
        })
        setTimeout(delay: 0.6, completion: {
            this.auroUp()
        })
        setTimeout(delay: 0.8, completion: {
            this.auroUp() {
                completion()
            }
        })
    }
    private func auroDown(x:CGFloat = 0, completion:@escaping () -> Void = {}) {
        let node = SKSpriteNode(texture: _selectTexture.getCell(x, 1))
        node.zPosition = 80
        node.position.y = cellSize * 0.5
        addChild(node)
        let move = SKAction.moveBy(x: 0, y: -cellSize * 0.5, duration: TimeInterval(0.5))
        node.run(move) {
            node.removeFromParent()
            completion()
        }
    }
    func actionSealed(completion:@escaping () -> Void) {
        auroDown()
        let this = self
        setTimeout(delay: 0.2, completion: {
            this.auroDown()
        })
        setTimeout(delay: 0.4, completion: {
            this.auroDown()
        })
        setTimeout(delay: 0.6, completion: {
            this.auroDown()
        })
        setTimeout(delay: 0.8, completion: {
            this.auroDown() {
                completion()
            }
        })
    }
    func actionShoot(completion:@escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(1))
        _charNode.run(wait, completion: completion)
    }
    func isDead() -> Bool {
        if _unit._extensions.hp <= 0 {
            return true
        }
        return false
    }
    func isBlocked() -> Bool {
        if inleft {
            return _battle.isLeftUnitBlocked(unit: self)
        } else {
            return _battle.isRightUnitBlocked(unit: self)
        }
    }
    func getActiveSpell() -> Array<Spell> {
        var spells = Array<Spell>()
        for s in _unit._spellsInuse {
            if !s.isPassive && !s.isAuro {
                spells.append(s)
            }
        }
        return spells
    }
    var _status = Dictionary<String, Status>()
    func hasStatus(type:String) -> Bool {
        if _status.index(forKey: type) != nil {
            let s = _status[type]!
            if s._timeleft > 0 {
                return true
            }
        }
        return false
    }
    
    func getStatus(type:String) -> Status? {
        if _status.index(forKey: type) != nil {
            let s = _status[type]!
            if s._timeleft > 0 {
                return s
            }
        }
        return nil
    }
    
    func hasSpell(spell:Spell) -> Bool {
        for s in _unit._spellsInuse {
            if type(of: spell) == type(of: s) {
                return true
            }
        }
        
        return false
    }
    func hasAuro(auro:Spell) -> Bool {
        var spells = Array<Spell>()
        if inleft {
            for u in _battle._leftRoles {
                spells += u._unit._spellsInuse
            }
        } else {
            for u in _battle._rightRoles {
                spells += u._unit._spellsInuse
            }
        }
        for s in spells {
            if type(of: s) == type(of: auro) {
                return true
            }
        }
        return false
    }
    
    func removeStatus(type:String) {
        _status.removeValue(forKey: type)
    }
    func addStatus(status:Status) {
        _status[status._type] = status
    }
    
    func getSpirit(t:Creature) -> CGFloat {
        var spirit = _unit._extensions.spirit - t._level
        
        if hasSpell(spell: Energetic()) {
            spirit *= 1.2
        }
        
        for s in _status.values {
            if s._type == Status.DEATH_STRIKE_UP {
                spirit += 10
            } else if s._type == Status.DEATH_STRIKE_DOWN {
                spirit -= 10
            }
        }
        return spirit
    }
    func getFirePower() -> CGFloat {
        var val = _unit._ElementalPower.fire
//        if hasStatus(type: Status.FIRE_LORD) {
//            val += 20
//        }
        if hasSpell(spell: Firelord()) {
            val += 20
        }
        
        if _unit.isMainChar && _stage.hasTowerStatus(status: FireEnerge()) {
            val += 50
        }
        
        return val + _ElementalPower.fire + _elemental.damage
    }
    func getWaterPower() -> CGFloat {
        var val = _unit._ElementalPower.water
        if _unit.isMainChar && _stage.hasTowerStatus(status: WaterEnerge()) {
            val += 50
        }
        return val + _ElementalPower.water + _elemental.damage
    }
    func getThunderPower() -> CGFloat {
        var val = _unit._ElementalPower.thunder
        if _unit.isMainChar && _stage.hasTowerStatus(status: ThunderEnerge()) {
            val += 50
        }
        return val + _ElementalPower.thunder + _elemental.damage
    }
    func getFireResistance() -> CGFloat {
        var val = _unit._ElementalResistance.fire
//        if hasStatus(type: Status.FIRE_LORD) {
//            val += 20
//        }
        if hasSpell(spell: Firelord()) {
            val += 20
        }
        
        if _unit.isMainChar && _stage.hasTowerStatus(status: FireEnerge()) {
            val += 50
        }
        
        return val + _ElementalResistance.fire + _elemental.resistance
    }
    func getWaterResistance() -> CGFloat {
        var val = _unit._ElementalResistance.water
        if _unit.isMainChar && _stage.hasTowerStatus(status: WaterEnerge()) {
            val += 50
        }
        return val + _ElementalResistance.water + _elemental.resistance
    }
    func getThunderResistance() -> CGFloat {
        var val = _unit._ElementalResistance.thunder
        if _unit.isMainChar && _stage.hasTowerStatus(status: ThunderEnerge()) {
            val += 50
        }
        return val + _ElementalResistance.thunder + _elemental.resistance
    }
    
    func getMagicalDamage() -> CGFloat {
        let val = _unit._magical.damage
        
        return val + _magical.damage
    }
    
    func getMagicalResistance() -> CGFloat {
        let val = _unit._magical.resistance
        
        return val + _magical.resistance
    }
    
    func getPhysicalDamage() -> CGFloat {
        let val = _unit._physical.damage
        
        return val + _physical.damage
    }
    
    func getPhysicalResistance() -> CGFloat {
        let val = _unit._physical.resistance
        
        return val + _physical.resistance
    }
    
    func getAccuracy(t:Creature) -> CGFloat {
        var acc = _unit._extensions.accuracy - t._level
        if hasSpell(spell: BargeAbout()) {
            acc -= 100
        }
        if nil != _battle && hasAuro(auro: Focus()) {
            acc += 20
        }
        if _unit.isMainChar && _stage.hasTowerStatus(status: SpeedPower()) {
            acc += 25
        }
        return acc + _extensions.accuracy
    }
    func getAvoid(t:Creature) -> CGFloat {
        var avd = _unit._extensions.avoid - t._level
        if hasSpell(spell: DancingOnIce()) {
            avd += 100
        }
        if _unit.isMainChar && _stage.hasTowerStatus(status: DefencePower()) {
            avd += 25
        }
        
        if hasStatus(type: Status.DISAPPEAR) {
            avd += 50
        }
        
        return avd + _extensions.avoid
    }
    func getSpeed() -> CGFloat {
        var speed = _unit._extensions.speed
        if _unit.isMainChar && _stage.hasTowerStatus(status: SpeedPower()) {
            speed += 50
        }
        return speed + _extensions.speed
    }
    func getAttack(t:Creature) -> CGFloat {
//        let atk = sqrt(_unit._extensions.attack) * 12
        if hasSpell(spell: MagicSword()) {
            return getSpirit(t:t)
        }
        var atk = _unit._extensions.attack - t._level
        if hasSpell(spell: OnePunch()) {
            atk += getDefence(t: t)
        }
        
        if hasSpell(spell: Bellicose()) {
            atk *= 1.2
        }
        if _unit.isMainChar && _stage.hasTowerStatus(status: AttackPower()) {
            atk += 50
        }
        if _unit is Character {
            let char = _unit as! Character
            if char._weapon is BloodBlade {
                let rate = getHp() / getHealth()
                let plus = char._weapon.getAttack() * (1 - rate)
                atk += plus
            }
        }
        return atk + _extensions.attack
    }
    func getDefence(t:Creature) -> CGFloat {
        var def = _unit._extensions.defence - t._level
        if hasSpell(spell: DancingOnIce()) {
            return 0
        }
        
        if hasStatus(type: Status.FRAGILE) {
            def = def * 0.5
        }
        if hasSpell(spell: Strong()) {
            def *= 1.2
        }
        if _unit.isMainChar && _stage.hasTowerStatus(status: DefencePower()) {
            def += 50
        }
        return def + _extensions.defence
    }
    func getCritical(t:BUnit) -> CGFloat {
        var ctl = _unit._extensions.critical - t._unit._level
        if hasSpell(spell: BloodThirsty()) {
            ctl += _unit._level
        }
        if hasSpell(spell: BargeAbout()) {
            ctl += 100
        }
        if hasSpell(spell: Cruel()) {
            if t.getHp() / t.getHealth() < 0.2 {
                ctl = ctl * 2
            }
        }
        if _unit.isMainChar && _stage.hasTowerStatus(status: AttackPower()) {
            ctl += 25
        }
        return ctl + _extensions.critical
    }
    
    func getCriticalForShow(t:Creature) -> CGFloat {
        var ctl = _unit._extensions.critical - t._level
        if hasSpell(spell: BloodThirsty()) {
            ctl += _unit._level
        }
        if hasSpell(spell: BargeAbout()) {
            ctl += 100
        }
        if _unit.isMainChar && _stage.hasTowerStatus(status: AttackPower()) {
            ctl += 25
        }
        return ctl
    }
    
    func getStrength() -> CGFloat {
        let val = _unit._mains.strength
        return val
    }
    func getStamina() -> CGFloat {
        let val = _unit._mains.stamina
        return val
    }
    func getAgility() -> CGFloat {
        let val = _unit._mains.agility
        return val
    }
    func getIntellect() -> CGFloat {
        let val = _unit._mains.intellect
        return val
    }
    
    func getMind(target:Creature = Creature()) -> CGFloat {
        var mind = _unit._extensions.mind
        if _unit.isMainChar && _stage.hasTowerStatus(status: MindPower()) {
            mind += 25
        }
        return mind + _extensions.mind
    }
    
    func getRevenge(target:Creature = Creature()) -> CGFloat {
        let val = _unit._revenge
        return val + _revenge
    }
    
    func getBreak(target:Creature = Creature()) -> CGFloat {
        let val = _unit._break
        return val + _break
    }
    
    func getHp() -> CGFloat {
        return _unit._extensions.hp
    }
    func getHealth() -> CGFloat {
        return _unit._extensions.health + _extensions.health
    }
    func getRevenge() -> CGFloat {
        let val = _unit._revenge
        return val + _revenge
    }
    func getLucky() -> CGFloat {
        var val = _unit._lucky
        if _unit.isMainChar && _stage.hasTowerStatus(status: LuckyPower()) {
            val += 25
        }
        
        return val
    }
    
    func getRace() -> Int {
        if _race != -1 {
            return _race
        }
        
        return _unit._race
    }
    
    func getRhythm() -> CGFloat {
        let val = _unit._rhythm
        return val + _rhythm
    }
    func getChaos() -> CGFloat {
        let val = _unit._chaos
        return val + _chaos
    }
    private var _speakNode = SKSpriteNode()
    func speak(text:String, autoRemove:Bool = true, duration:CGFloat = 3) {
        let node = SKSpriteNode()
        _speakNode.removeFromParent()
        var width = cellSize * 2.25
        if text.count >= 6 {
            width = width + ((text.count - 6) * 12).toFloat()
        }
        let rect = CGRect(x: -width * 0.5, y: -cellSize * 0.375, width: width, height: cellSize * 0.75)
        let bg = SKShapeNode(rect: rect, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.alpha = 0.65
        node.addChild(bg)
        
        let border = SKShapeNode(rect: rect, cornerRadius: 4)
        border.lineWidth = 2
        node.addChild(border)
        
        let l = Label()
        l.fontSize = 14
        l.fontColor = UIColor.white
        l.position.y = -7
        l.text = text
        node.addChild(l)
        
        node.zPosition = UIStage.LAYER2 + 3
        node.position.y = cellSize
        addChild(node)
        if autoRemove {
            setTimeout(delay: duration, completion: {
                node.removeFromParent()
            })
        }
        _speakNode = node
    }
    
    func removeSpeak() {
        _speakNode.removeFromParent()
    }
    
    func speakInBattle(text:String, autoRemove:Bool = true, duration:CGFloat = 3) {
        let node = SKSpriteNode()
        _speakNode.removeFromParent()
        var width = cellSize * 1.5
        if text.count >= 4 {
            width = width + ((text.count - 4) * 10).toFloat()
        }
        let rect = CGRect(x: -width * 0.5, y: -cellSize * 0.3, width: width, height: cellSize * 0.6)
        let bg = SKShapeNode(rect: rect, cornerRadius: 2)
        bg.fillColor = UIColor.black
        bg.alpha = 0.65
        node.addChild(bg)
        
        let border = SKShapeNode(rect: rect, cornerRadius: 2)
        border.lineWidth = 1
        border.strokeColor = Data.UNSELECTED_STROKE_COLOR
        node.addChild(border)
        
        let l = Label()
        l.fontSize = 13
        l.fontColor = UIColor.white
        l.position.y = -6
        l.text = text
        node.addChild(l)
        
        node.zPosition = 101
        node.position.y = cellSize * 0.8
        addChild(node)
        if autoRemove {
            setTimeout(delay: duration, completion: {
                node.removeFromParent()
            })
        }
        _speakNode = node
    }
    var _mains:Mains = Mains(stamina:0, strength: 0, agility: 0, intellect: 0)
    var _extensions:Extensions = Extensions(
        attack: 0,
        defence: 0,
        speed: 0,
        accuracy: 0,
        critical: 0,
        avoid: 0,
        spirit: 0,
        hp: 0,
        mp: 0,
        health: 0,
        mind: 0
    )
    var _break:CGFloat = 0
    var _revenge:CGFloat = 0
    var _rhythm:CGFloat = 0
    var _chaos:CGFloat = 0
    var _race:Int = -1
    
    var _ElementalPower = Elemental(
        fire : 0,
        water : 0,
        thunder : 0
    )
    
    var _ElementalResistance = Elemental(
        fire : 0,
        water : 0,
        thunder : 0
    )
    var _magical = Magic(damage: 0, resistance: 0)
    var _elemental = Magic(damage: 0, resistance: 0)
    var _physical = Magic(damage: 0, resistance: 0)
    
    func strengthChange(value: CGFloat) {
        _mains.strength += value
        _extensions.attack += value * 2
        _extensions.defence += value * 0
        _extensions.speed += value * 0.5
        _extensions.accuracy += value * 0.1
        _extensions.avoid += value * 0
        _extensions.critical += value * 0.1
        _extensions.spirit += value * -0.5
        _extensions.health += value * 1
        _extensions.hp += value * 1
        _extensions.mp += value * 0
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func staminaChange(value: CGFloat) {
        _mains.stamina += value
        _extensions.attack += value * 1
        _extensions.defence += value * 1
        _extensions.speed += value * 0
        _extensions.accuracy += value * 0
        _extensions.avoid += value * 0
        _extensions.critical += value * 0
        _extensions.spirit += value * -0.5
        _extensions.health += value * 4
        _extensions.hp += value * 4
        _extensions.mp += value * 0
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func agilityChange(value: CGFloat) {
        _mains.agility += value
        _extensions.attack += value * 0.5
        _extensions.defence += value * 0.5
        _extensions.speed += value * 2
        _extensions.accuracy += value * 0.4
        _extensions.avoid += value * 0.2
        _extensions.critical += value * 0.3
        _extensions.spirit += value * 0
        _extensions.health += value * 1
        _extensions.hp += value * 1
        _extensions.mp += value * 1
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
    func intellectChange(value: CGFloat) {
        _mains.intellect += value
        _extensions.attack += value * -0.5
        _extensions.defence += value * 0.3
        _extensions.speed += value * 0.2
        _extensions.accuracy += value * 0
        _extensions.avoid += value * 0.1
        _extensions.critical += value * 0
        _extensions.spirit += value * 3
        _extensions.health += value * 0.5
        _extensions.hp += value * 0.5
        _extensions.mp += value * 3
        if _extensions.hp < 1 {
            _extensions.hp = 1
        }
    }
}
