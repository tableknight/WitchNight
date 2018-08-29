//
//  Battle.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/3/12.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class Battle: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        addChild(BUnit())
//        createBG()
        self.name = "battle"
        self.size = CGSize(width: Data.instance.screenWidth, height: Data.instance.screenHeight)
        s = cellSize * 1.5
        xd = cellSize * 2
        yd = cellSize * 1.6
//        ttl = [-s, s * 2]
//        ttm = [0, s * 2]
//        ttr = [s, s * 2]
//        tbl = [-s, s]
//        tbm = [0, s]
//        tbr = [s, s]
//        btl = [-s, -s]
//        btm = [0, -s]
//        btr = [s, -s]
//        bbl = [-s, -s * 2]
//        bbm = [0, -s * 2]
//        bbr = [s, -s * 2]
        
        llt = [-s * 2 - xd, s + yd]
        llm = [-s * 2 - xd, 0 + yd]
        llb = [-s * 2 - xd, -s + yd]
        
        lrt = [-s - xd, s + yd]
        lrm = [-s - xd, 0 + yd]
        lrb = [-s - xd, -s + yd]
        
        rlt = [s + xd, s + yd]
        rlm = [s + xd, 0 + yd]
        rlb = [s + xd, -s + yd]
        
        rrt = [s * 2 + xd, s + yd]
        rrm = [s * 2 + xd, 0 + yd]
        rrb = [s * 2 + xd, -s + yd]
        
//        var es = Array<Creature>();
//        for _ in 0...3 {
//            let e = GiantWasp()
//            e.create(level: 10)
//            es.append(e)
//        }
//        setEvils(evils: es)
//        var es1 = Array<Creature>();
//        for _ in 0...2 {
//            let e = GiantWasp()
//            e.create(level: 10)
//            es1.append(e)
//        }
//        setRoles(roles: es1)
//        let t = Timer(timeInterval: 3000, target: self, selector: #selector(later), userInfo: self, repeats: false)
//        t.fire()
//        let t = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(later), userInfo: nil, repeats: true)
//        t.fire()
//        _curRole.actionAttack {
//            print("123")
//        }
//        _curRole.actionCast {
//        }
//        _curRole.setOrderMode()
        createBG()
        createOrder()
        _char = Data.instance._char!
        isUserInteractionEnabled = true;
    }
    internal var _isCharDead = false;
    internal var _isAllEvilDead = false;
    func battleStart() {
//        for unit in _left.values {
//            for s in unit._unit._spellsInuse {
//                s.beforeBattle(t: unit)
//            }
//        }
//        for unit in _right.values {
//            for s in unit._unit._spellsInuse {
//                s.beforeBattle(t: unit)
//            }
//        }
//        _roundLabel.isHidden = true
        
        for p in _char._props {
            if p is Item {
                let item = p as! Item
                item._timeleft = 0
            }
        }
        
        for s in _char._spellsInuse {
            s._timeleft = 0
        }
        
        for m in _char._minions {
            for s in m._spellsInuse {
                s._timeleft = 0
            }
        }
        
        _roundLabel.fontSize = 18
        _roundLabel.align = "left"
        _roundLabel.position.x = -cellSize * 7.5
        _roundLabel.position.y = cellSize * 4 - 10
        addChild(_roundLabel)
        roundStart()
    }
    internal var _roundLabel = Label()
    internal func defaultOrderAttack() {
        if !(_curRole._unit._weapon is Instrument) {
            _waitingForSelectTarget = true
            _selectedSpell = Attack()
            _selectedSpell._battle = self
            showAvailableUnits()
        }
    }
    func reduceCooldown() {
        for u in _leftRoles {
            for s in u._unit._spellsInuse {
                if s._timeleft > 0 {
                    s._timeleft -= 1
                }
            }
        }
        for u in _rightRoles {
            for s in u._unit._spellsInuse {
                if s._timeleft > 0 {
                    s._timeleft -= 1
                }
            }
        }
        
        for p in Data.instance._char._props {
            if p is Item {
                let item = p as! Item
                if item._timeleft > 0 {
                    item._timeleft -= 1
                }
            }
        }
        
    }
    internal func stillInBattle(unit:BUnit) -> Bool {
        if _leftRoles.contains(unit) {
            return true
        }
        if _rightRoles.contains(unit) {
            return true
        }
        
        return false
    }
    func roundEnd() {
        for u in _leftRoles {
            for s in u._status.values {
                s.inEndOfRound()
            }
        }
        for u in _rightRoles {
            for s in u._status.values {
                s.inEndOfRound()
            }
        }
    }
    func moveStart() {
//        if _isCharDead {
//            defeated()
//            return
//        }
//        if _isAllEvilDead {
//            defeat()
//            return
//        }
        if _roleAll.count <= 0 {
            debug("roleAll empty")
            roundEnd()
            roundStart()
            return
        }
        let this = self
        findNextRole() {
            if this._curRole.isDead() {
                debug("dead in move start")
                this._curRole.removeFromBattle()
                this._curRole.removeFromParent()
                this.moveStart()
                return
            }
            
            if !this.stillInBattle(unit: this._curRole) {
                debug("单位已不在战斗中")
                return
            }
            
            this.createAction()
        }
    }
    internal func createAction() {
        let this = self
        _curRole.isDefend = false
        if this._curRole.hasStatus(type: Status.FREEZING) {
            this._curRole.actionUnfreeze {
                print("unfreezing")
                this._curRole.removeStatus(type: Status.FREEZING)
                this.moveEnd()
            }
            return
        }
        
        if !_curRole._unit.hasAction {
            moveEnd()
            return
        }
        
        if _curRole.hasStatus(type: Status.TAUNTED) {
            this._selectedSpell = Attack()
            this._selectedSpell._battle = self
            let s = _curRole.getStatus(type: Status.TAUNTED)
            if nil != s {
                let source = s!._source
                if !source.isDead() {
                    _selectedTarget = source
                    execOrder()
                    return
                }
            }
        }
        
        if !_curRole.inleft {
            this.createAI()
        } else {
            if this._curRole.hasSpell(spell: Crazy()) {
                this._selectedSpell = Attack()
                this._selectedSpell._battle = self
                this._selectedSpell.findTarget()
                this.execOrder()
            } else {
                this._curRole.setOrderMode()
                this.defaultOrderAttack()
                this.showOrder()
            }
        }
    }
    internal func cleanUnitStatus() {
        for unit in _left.values {
//            for s in unit._status.values {
//                if s.timeleft > 0 {
//                    s.timeleft -= 1
//                }
//            }
            unit._speed = 0
//            unit.isDefend = false
        }
        for unit in _right.values {
//            for s in unit._status.values {
//                if s.timeleft > 0 {
//                    s.timeleft -= 1
//                }
//            }
            unit._speed = 0
//            unit.isDefend = false
        }
    }
    
    internal func createAI() {
        let _seed = seed(max:101)
        let sensitive = _curRole._unit._sensitive
        if _seed < sensitive {
            let sps = _curRole.getActiveSpell()
//            debug("ai cast spell")
            if sps.count < 1 {
                _selectedSpell = Attack()
            } else {
                _selectedSpell = sps[seed(max: sps.count)]
            }
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        } else if _seed < (sensitive + 25) {
//            debug("ai cast defend")
            _curRole.isDefend = true
            _selectedSpell = Defend()
            _selectedSpell._battle = self
            let this = self
            _curRole.showText(text: "防御") {
                this.execOrder()
            }
        } else {
//            debug("ai cast attack")
            _selectedSpell = Attack()
            _selectedSpell._battle = self
            _selectedSpell.findTarget()
            execOrder()
        }
    }
    var victory = false
    internal func defeat() {
        print("defeat")
        let l = Loot()
        let ms = Data.instance._char.getReadyMinions()
        for u in _evilsOrg {
            l.loot(role: u._unit)
            let exp = l.getExp(level: u._unit._level)
            Data.instance._char.expUp(up: exp)
            debug("\(Data.instance._char._name)获得了\(exp.toInt())点经验。")
            for m in ms {
                if m._extensions.hp > 0 {
                    let ep = l.getExp(level: u._unit._level)
                    m.expUp(up: ep)
                    debug("\(m._name)获得了\(ep.toInt())点经验。")
                }
            }
        }
        victory = true
        let list = l.getList()
        if list.count > 0 {
            let p = LootPanel()
            p.create(props: list)
            p._battle = self
            addChild(p)
        } else {
            fadeOutBattle()
        }
    }
    internal func defeated() {
//        print("defeated")
        showMsg(text: "战斗失败！")
        fadeOutBattle()
    }
    func fadeOutBattle() {
        let this = self
        run(SKAction.fadeOut(withDuration: TimeInterval(1))) {
            //            let c = Data.instance._char!
            //            c._extensions.hp = c._extensions.health
            Data.instance.stage.removeBattle(b: self)
            this.afterBatteAction()
        }
    }
    var afterBatteAction = {}
    func hasFinished() -> Bool {
        if _rightRoles.count < 1 {
            defeat()
            return true
        }
        if Data.instance._char._extensions.hp < 1 {
            defeated()
            return true
        }
        
        return false
    }
    internal func calcSpeedLine() {
        _speedLine = 0
        for unit in _left.values {
            _speedLine += unit.getSpeed() * unit._unit._weapon._attackSpeed
        }
        for unit in _right.values {
            _speedLine += unit.getSpeed() * unit._unit._weapon._attackSpeed
        }
    }
    internal func roundStart(){
        _round += 1
        _roundLabel.text = "第\(_round)回合"
//        _roundLabel.isHidden = false
        cleanUnitStatus()
//        _roleAll = _leftRoles + _rightRoles
        reduceCooldown()
        calcSpeedLine()
        orderUnits()
        let this = self
//        this._roundLabel.isHidden = true
        setTimeout(delay: 0.5, completion: {
            this.moveStart()
        })
    }
    internal func orderUnits() {
        var all = _leftRoles + _rightRoles
        _roleAll = []
//        calcSpeedLine()
        while all.count > 0 {
            for unit in all {
                unit._speed += unit.getSpeed() * unit._unit._weapon._attackSpeed
                if unit._speed >= _speedLine {
                    _roleAll.append(unit)
                    all.remove(at: all.index(of: unit)!)
                }
            }
        }
    }
    internal var _speedLine:CGFloat = 0
    var _roleAll = Array<BUnit>()
    var _round = 0
    internal var hasRhythm = false
    internal func findNextRole(completion:@escaping () -> Void) {
        if hasRhythm {
            hasRhythm = false
            let this = self
            _curRole.showText(text: "律动") {
                this.createCurRole {
                    completion()
                }
            }
            return
        }
        let sd = seed()
        if sd < 25 - _mainChar.getChaos().toInt() {
            let index = seed(max: _roleAll.count)
            let unit = _roleAll[index]
            _curRole = unit
            _roleAll.remove(at: index)
            debug("行为混乱")
            completion()
        } else {
            createCurRole {
                completion()
            }
        }
        //print(_curRole._unit._name)
    }
    
    internal func createCurRole(completion:@escaping () -> Void) {
        _curRole = _roleAll[0]
        //            let this = self
        if seed().toFloat() < _curRole.getRhythm() {
            completion()
            hasRhythm = true
        } else {
            _roleAll.remove(at: 0)
            completion()
        }
    }
    
    func placeEvils() {}
    func placeRoles() {}
    func silenceUnit(unit:BUnit) {
        let index = _roleAll.index(of: unit)
        if nil != index {
            _roleAll.remove(at: index!)
        }
    }
    internal func createBG() {
        let di = Data.instance
        let bg = SKShapeNode(rect: CGRect(x: -di.screenWidth * 0.6, y: -di.screenHeight * 0.6, width: di.screenWidth * 1.2, height: di.screenHeight * 1.2))
//        bg.fillColor = UIColor.black
//        bg.alpha = 0.10
        addChild(bg)
    }

    internal var _orderAttack = UIOrder()
    internal var _orderCancel = UIOrder()
    internal var _orderDefend = UIOrder()
    internal var _orderSpell = UIOrder()
    internal var _orderItem = UIOrder()
    internal var _orderSummon = UIOrder()
    internal var _orderRecall = UIOrder()
    internal func createOrder() {
        let orderY = -cellSize * 3.5
        let startX = -cellSize * 2
        let orderSize = cellSize
        
        _orderAttack.create(label: "攻击")
        _orderAttack.position.x = startX
        _orderAttack.position.y = orderY
        _orderAttack.isHidden = true
        addChild(_orderAttack)
        _orders.append(_orderAttack)
//        if _curRole._unit._weapon is Instrument {
//            _orderAttack.isHidden = true
//        }
        
        
        _orderDefend.create(label: "防御")
        _orderDefend.position.x = startX + orderSize
        _orderDefend.position.y = orderY
        _orderDefend.isHidden = true
        addChild(_orderDefend)
        _orders.append(_orderDefend)
        
        _orderSpell.create(label: "技能")
        _orderSpell.position.x = startX + orderSize * 2
        _orderSpell.position.y = orderY
        _orderSpell.isHidden = true
        addChild(_orderSpell)
        _orders.append(_orderSpell)
        
        _orderItem.create(label: "物品")
        _orderItem.position.x = startX + orderSize * 3
        _orderItem.position.y = orderY
        _orderItem.isHidden = true
        addChild(_orderItem)
        _orders.append(_orderItem)
        
        _orderSummon.create(label: "召唤")
        _orderSummon.position.x = startX + orderSize * 4
        _orderSummon.position.y = orderY
        _orderSummon.isHidden = true
        addChild(_orderSummon)
        _orders.append(_orderSummon)
        
        _orderRecall.create(label: "召回")
        _orderRecall.position.x = startX + orderSize * 5
        _orderRecall.position.y = orderY
        _orderRecall.isHidden = true
        addChild(_orderRecall)
        _orders.append(_orderRecall)
        
        _orderCancel.create(label: "取消")
        _orderCancel.position.x = cellSize * 5
        _orderCancel.position.y = orderY
        _orderCancel.isHidden = true
        addChild(_orderCancel)
//        showOrder()
    }
    var _selectedSpell = Spell()
    internal var _waitingForSelectTarget = false
    internal var waitingForSelectItemTarget = false
    internal var waitingForSelectSummonSeat = false
    internal var waitingForSelectRecallTarget = false
    internal var _itemTargets = Array<BUnit>()
    var _selectedTarget = BUnit()
    var _selectedTargets = Array<BUnit>()
    internal var _char:Character!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let view = touches.first?.view
        let first = touches.first
        let s = first?.location(in: self)
        touchAction(s: s!)
    }
    internal func touchAction(s:CGPoint) {
        
        if _roundLabel.contains(s) {
            Data.instance.stage.removeBattle(b: self)
            let tp = TownScroll()
            tp.use(target: Creature())
            return
        }
        
        if _orderCancel.contains(s) && !_orderCancel.isHidden {
            cancelButtonClicked()
            return
        }
        
        if waitingForSelectItemTarget {
            let this = self
            for u in _itemTargets {
                if u.contains(s) {
                    waitingForSelectItemTarget = false
                    this.hideCancel()
                    this.setUnitDefault(all: true)
                    let item = _selectedItem.prop as! Item
                    item._battle = self
                    item.use(unit: u) {
                        this.moveEnd()
                    }
                    _char.removeProp(p: item)
                    break
                }
            }
            return
        }
        
        if waitingForSelectRecallTarget {
            for u in _leftRoles {
                if u.contains(s) && !u._unit.isMainChar {
                    _mainChar.showText(text: "召回")
                    _left.removeValue(forKey: u._seat)
                    _leftRoles.remove(at: _leftRoles.index(of: u)!)
                    let index = _roleAll.index(of: u)
                    if nil != index {
                        _roleAll.remove(at: index!)
                    }
                    u._unit._seat = BUnit.STAND_BY
                    
                    waitingForSelectRecallTarget = false
                    setUnitDefault(all: true)
                    hideCancel()
                    
                    let this = self
                    u.actionRecall {
                        u.removeFromParent()
                        this.moveEnd()
                    }
                }
            }
            return
        }
        
        if waitingForSelectSummonSeat {
            for u in _summonUnits.values {
                if u.contains(s) {
                    let seat = u._seat
                    if _selectedSpell is Interchange {
                        waitingForSelectSummonSeat = false
                        _selectedTarget = u
                        let this = self
                        speakSpellName()
                        _selectedSpell.cast {
                            this.moveEnd()
                            this.cdSpell(spell: this._selectedSpell)
                        }
                        cleanSummonSeats()
                        setUnitDefault(all: true)
                        hideCancel()
                        return
                    }
                    if _selectedSpell is SummonFlower {
                        let flower = FlowerOfHeal()
                        flower._growth.strength = _curRole._unit._growth.strength
                        flower._growth.stamina = _curRole._unit._growth.stamina
                        flower._growth.agility = _curRole._unit._growth.agility
                        flower._growth.intellect = _curRole._unit._growth.intellect
                        flower.create(level: _curRole._unit._level)
                        
                        //                        _mainChar.showText(text: _selectedSpell._name)
                        //                        _curRole.speak(text: "")
                        speakSpellName()
                        let this = self
                        _curRole.actionCast {
                            u.removeFromParent()
                            this.waitingForSelectSummonSeat = false
                            flower._seat = seat
                            this.createLeftUnit(c: flower)
                            this.cdSpell(spell: this._selectedSpell)
                            this._left[seat]?.actionSummon {
                                this.moveEnd()
                            }
                        }
                        setUnitDefault(all: true)
                        cleanSummonSeats()
                        hideCancel()
                        return
                    }
                    if u.isEmpey {
                        if _char._minionsCount <= (_leftRoles.count - 1) {
                            showMsg(text: "战场随从已达上限！")
                            return
                        }
                        
                        _mainChar.showText(text: "召唤")
                        u.removeFromParent()
                        waitingForSelectSummonSeat = false
                        _selectedMinion._seat = seat
                        createLeftUnit(c: _selectedMinion)
                        cleanSummonSeats()
                        setUnitDefault(all: true)
                        hideCancel()
                        
                        let this = self
                        _left[seat]?.actionSummon {
                            this.moveEnd()
                        }
                        
                    } else {
                        _mainChar.showText(text: "召唤")
                        _left.removeValue(forKey: u._seat)
                        _leftRoles.remove(at: _leftRoles.index(of: u)!)
                        let index = _roleAll.index(of: u)
                        if nil != index {
                            _roleAll.remove(at: index!)
                        }
                        u._unit._seat = BUnit.STAND_BY
                        
                        waitingForSelectSummonSeat = false
                        _selectedMinion._seat = seat
                        cleanSummonSeats()
                        setUnitDefault(all: true)
                        hideCancel()
                        
                        let this = self
                        u.actionRecall {
                            this.createLeftUnit(c: this._selectedMinion)
                            u.removeFromParent()
                            this._left[seat]?.actionSummon {
                                this.moveEnd()
                            }
                        }
                    }
                    
                    return
                }
            }
            return
        }
        
        
        
        if _orderItem.contains(s) && !_orderItem.isHidden {
            hideOrder()
            //            showCancel()
            var itms = Array<Item>()
            for p in Data.instance._char._props {
                if p is Item {
                    let itm = p as! Item
                    if itm.useInBattle {
                        if itm is SealScroll && self is War {
                            continue
                        } else {
                            itms.append(itm)
                        }
                    }
                }
            }
            let bip = BItemPanel()
            bip._battle = self
            bip.create(items: itms)
            addChild(bip)
            return
        }
        
        if _orderSummon.contains(s) && !_orderSummon.isHidden {
            hideOrder()
            showCancel()
            showMinionsList()
            //            showSummonableSeats()
            return
        }
        
        if _orderRecall.contains(s) && !_orderRecall.isHidden {
            hideOrder()
            showCancel()
            showRecallMinions()
            waitingForSelectRecallTarget = true
            return
        }
        
        //点击攻击选项
        if _orderAttack.contains(s) && !_orderAttack.isHidden && !(_curRole._unit._weapon is Instrument) {
            hideOrder()
            showCancel()
            //            _orderCancel.isHidden = false
            _waitingForSelectTarget = true
            _selectedSpell = Attack()
            _selectedSpell._battle = self
            showAvailableUnits()
        } else if _orderDefend.contains(s) && !_orderDefend.isHidden {
            _selectedSpell = Defend()
            _selectedSpell._battle = self
            _curRole.isDefend = true
            setUnitDefault(all: true)
            hideOrder()
            hideCancel()
            moveEnd()
        } else if _orderSpell.contains(s) && !_orderSpell.isHidden {
            showSpellCards()
            hideOrder()
            _waitingForSelectTarget = false
        } else if _waitingForSelectTarget {
            for unit in _left.values {
                if unit.contains(s) && unit.selectable {
                    _selectedTarget = unit
                }
                
            }
            for unit in _right.values {
                if unit.contains(s) && unit.selectable {
                    _selectedTarget = unit
                }
            }
            if _selectedTarget.hasInitialized {
                _waitingForSelectTarget = false
                setUnitDefault(all: true)
                _selectedTarget.setSelectedMode()
                hideCancel()
                hideOrder()
                execOrder()
            } else {
                print("has no selected target!")
            }
            
        } else {
            for card in _spellCards {
                if card.contains(s) {
                    if card.coolDown > 0 {
                        return
                    }
                    _selectedSpell = card.spell
                    hideOrder()
                    showCancel()
                    removeSpellCards()
                    if _selectedSpell.isAutoSelectTarget {
                        _waitingForSelectTarget = false
                        _selectedSpell.findTarget()
                        setUnitDefault(all: true)
                        execOrder()
                        hideCancel()
                    } else {
                        if _selectedSpell is SummonFlower {
                            waitingForSelectSummonSeat = true
                            setUnitDefault()
                            showSummonableSeats(selectAll: false)
                            return
                        }
                        
                        if _selectedSpell is Interchange {
                            waitingForSelectSummonSeat = true
                            setUnitDefault()
                            showSummonableSeats()
                            return
                        }
                        
                        _waitingForSelectTarget = true
                        showAvailableUnits()
                    }
                }
            }
        }
    }
    func moveBack(unit:BUnit, completion:@escaping () -> Void) {
        if unit.isDead() {
            completion()
            return
        }
        let oPos = getPosByStr(unit._seat)
        var dy = unit.position.y - oPos[1]
        if abs(dy) < 1 {
            dy = 0
        }
        let dx = round(unit.position.x - oPos[0])
        let v = CGVector(dx: -dx, dy: -dy)
//        debug("move back \(dx)")
        var time:CGFloat = Data.instance.frameSize * 4
        if abs(v.dx) > 360 {
            time = Data.instance.frameSize * 5
        }
        let move = SKAction.move(by: v, duration: TimeInterval(time))
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
//        let move = SKAction.sequence([go, wait])
        if oPos[0] < unit.position.x {
            unit.faceWest()
            unit.moveWest4frame()
        } else {
            unit.faceEast()
            unit.moveEast4frame()
        }
//        let this = self
        unit.run(move, completion: {
            if unit.inleft {
                unit.faceEast()
            } else {
//                unit.faceEast()
                unit.faceWest()
            }
            unit.run(wait) {
                completion()
            }
        })
    }
    internal func checkRoleDead() {
        for u in _leftRoles {
            if u.isDead() {
                u.actionDead {
                    u.removeFromBattle()
                    u.removeFromParent()
                }
            }
        }
        for u in _rightRoles {
            if u.isDead() {
                u.actionDead {
                    u.removeFromBattle()
                    u.removeFromParent()
                }
            }
        }
    }
    //行动结束后释放的法术或者道具只能存在一个
    internal func moveEnd() {
//        checkRoleDead()
        
//        if _rightRoles.count < 1 {
//            defeat()
//            return
//        }
//        if Data.instance._char._extensions.hp < 1 {
//            defeated()
//            return
//        }
        for s in _curRole._status.values {
            if s._timeleft > 0 {
                s._timeleft -= 1
                if s._timeleft == 0 {
                    s.afterTimesUp()
                }
            }
        }
        var hasAfterMoveAction = false
        let this = self
        for s in _curRole._unit._spellsInuse {
            if s.hasAfterMoveAction {
                s._battle = self
                _curRole.showText(text: s._name)
                s.afterMove {
                    this._selectedTarget = BUnit()
                    this._waitingForSelectTarget = false
                    this.moveStart()
                }
                hasAfterMoveAction = true
                break
            }
        }
        if !hasAfterMoveAction {
            if _curRole._unit.isMainChar && Data.instance._char._shield is Faceless && _round % 3 == 1 {
//                let c = _curRole
                _curRole.showText(text: "无面者") {
                    this._curRole.actionBuff {
                        let spell = EyeToEye()
                        spell.removeSpecialStatus(t:this._curRole)
                        let status = Status()
                        status._type = Status.EYE_TO_EYE
                        status._timeleft = 2
                        this._curRole.addStatus(status: status)
                        
                        this._selectedTarget = BUnit()
                        this._waitingForSelectTarget = false
                        this.moveStart()
                    }
                }
            } else {
                _selectedTarget = BUnit()
                _waitingForSelectTarget = false
                moveStart()
            }
        }
    }
//    internal func targetAttacked() {
//        let this = self
//        debug("targetAttacked")
//        _selectedSpell.cast() {
//            //近战攻击并且时物理技能才需要跑回去
//            if this._curRole._unit._weapon.isClose && this._selectedSpell.isPhysical {
//                this.moveBack(unit: this._curRole) {
//
//                }
//            } else {
//                this.moveEnd()
//            }
//            this.unitDead()
//        }
//    }
//    internal func unitDead() {
////        let this = self
////        if this._selectedTarget.isDead() {
////            this._selectedTarget.actionDead {
////                if this._left.index(forKey: this._selectedTarget._seat) != nil {
////                    this._left.removeValue(forKey: this._selectedTarget._seat)
////                }
////                if this._right.index(forKey: this._selectedTarget._seat) != nil {
////                    this._right.removeValue(forKey: this._selectedTarget._seat)
////                }
////                this._selectedTarget.removeFromParent()
////            }
////            if _selectedTarget._unit._name == Data.instance._char._name {
////                _isCharDead = true
////            }
////            if _right.values.count <= 0 {
////                _isAllEvilDead = true
////            }
////        }
//        let this = self
//        for unit in _left.values {
//            if unit.isDead() {
//                this._left.removeValue(forKey: unit._seat)
//                if unit._unit._name == Data.instance._char._name {
//                    this._isCharDead = true
//                }
//                unit.actionDead {
//                    unit.removeFromParent()
//                }
//
//            }
//        }
//        for unit in _right.values {
//            if unit.isDead() {
//                this._right.removeValue(forKey: unit._seat)
//                unit.actionDead {
//                    unit.removeFromParent()
//                }
//            }
//        }
//        if this._right.values.count <= 0 {
//            this._isAllEvilDead = true
//        }
//
//    }
    internal func cdSpell(spell:Spell) {
        if Mode.nocd {
            return
        }
        if spell._cooldown > 0 {
            if Data.instance.stage.hasTowerStatus(status: TimeReduce()) {
                spell._timeleft = spell._cooldown
            } else {
                spell._timeleft = spell._cooldown + 1
            }
        }
    }
    internal func speak(text:String = "") {
        var speaking = _selectedSpell._name
        if text.count > 0 {
            speaking = text
        }
        if speaking.count > 0 {
            _curRole.speakInBattle(text: speaking)
        }
    }
    internal func speakSpellName() {
        _curRole.showText(text:_selectedSpell._name)
    }
    internal func execOrder() {
        let this = self
//        speak()
        speakSpellName()
        var delay:CGFloat = 0
        if _selectedSpell.isPhysical && !(_selectedSpell is Attack) {
            delay = 1
        }
        debug("delay is \(delay)")
        setTimeout(delay: delay, completion: {
            this._selectedSpell.cast {
                this.cdSpell(spell: this._selectedSpell)
                this.moveEnd()
            }
        })
    
    }
    func roleMove(from:BUnit, to:BUnit, completion:@escaping () -> Void) {
        let fromPos = getPosByStr(from._seat)
        let toPos = getPosByStr(to._seat)
        if fromPos == toPos {
            debug("moving bug!")
        }
        var dPos = from._charSize
        if from.position.x < to.position.x {
            from.moveEast4frame()
        } else {
            from.moveWest4frame()
            dPos = -from._charSize
        }
        let v = CGVector(dx: -(fromPos[0] - toPos[0] + dPos), dy: -(fromPos[1] - toPos[1]))
//        debug("\(from.inleft ? "left" : "right") role move 移动距离 ： \(v.dx)")
//        print(v)
        var time:CGFloat = Data.instance.frameSize * 4
        if abs(v.dx) > 360 {
            time = Data.instance.frameSize * 5
        }
        let move = SKAction.move(by: v, duration: TimeInterval(time))
//        print(move)
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        let go = SKAction.sequence([move, wait])
        from.run(go) {
//            debug("not here!")
            completion()
        }
    }
    internal func hideCancel() {
        _orderCancel.isHidden = true
    }
    internal func cancelButtonClicked() {
        hideCancel()
        showOrder()
        _orderCancel.isHidden = true
        _waitingForSelectTarget = false
        waitingForSelectSummonSeat = false
        waitingForSelectItemTarget = false
        waitingForSelectRecallTarget = false
        removeSpellCards()
        cleanSummonSeats()
        setUnitDefault()
    }
    internal func showCancel() {
        _orderCancel.isHidden = false
    }
    internal func setUnitDefault(all:Bool = false) {
        for unit in _left.values {
            if all {
                unit.setDefaultMode()
            } else {
                if _curRole != unit {
                    unit.setDefaultMode()
                }
                _curRole.setOrderMode()
            }
            
        }
        for unit in _right.values {
            unit.setDefaultMode()
        }
    }
    internal func showUnitInfo(hidden:Bool = false) {
        for u in _left.values {
            u._levelLabel.isHidden = hidden
        }
        for u in _right.values {
            u._levelLabel.isHidden = hidden
        }
    }
    internal var _availableEvils = Array<BUnit>()
    internal func showAvailableUnits() {
        setUnitDefault()
        _availableEvils = Array<BUnit>()
        if _selectedSpell.isTargetAll {
            _availableEvils = _leftRoles + _rightRoles
            if !_selectedSpell.canBeTargetSelf {
                let index = _availableEvils.index(of: _mainChar)
                if nil != index {
                    _availableEvils.remove(at: index!)
                } else {
                    debug("showAvailableUnits 找不到主角")
                }
            }
            for unit in _availableEvils {
                unit.setSelectableMode()
            }
            return
        }
        if _selectedSpell.isTargetEmemy{
            if _selectedSpell.isClose {
                if isLeftUnitBlocked(unit: _curRole) {
                    for unit in _right.values {
                        if !isRightUnitBlocked(unit: unit) {
                            _availableEvils.append(unit)
                        }
                    }
                } else {
                    for unit in _right.values {
                        _availableEvils.append(unit)
                    }
                }
            } else {
                for unit in _right.values {
                    _availableEvils.append(unit)
                }
            }
            
        } else {
            _availableEvils = _leftRoles
        }
        for unit in _availableEvils {
            unit.setSelectableMode()
        }
    }
    
    func isRightUnitBlocked(unit:BUnit) -> Bool{
        let s = unit._seat
        if "rrt" == s {
            if nil == _right.index(forKey: "rlt") {
                return false
            } else {
                return true
            }
        }
        if "rrm" == s {
            if nil == _right.index(forKey: "rlm") {
                return false
            } else {
                return true
            }
        }
        if "rrb" == s {
            if nil == _right.index(forKey: "rlb") {
                return false
            } else {
                return true
            }
        }
        return false;
    }
    
    func isLeftUnitBlocked(unit:BUnit) -> Bool {
        let s = unit._seat
        if "llt" == s {
            if nil == _left.index(forKey: "lrt") {
                return false
            } else {
                return true
            }
        }
        if "llm" == s {
            if nil == _left.index(forKey: "lrm") {
                return false
            } else {
                return true
            }
        }
        if "llb" == s {
            if nil == _left.index(forKey: "lrb") {
                return false
            } else {
                return true
            }
        }
        return false;
    }
    
    internal var _spellCards = Array<BattleSpellIcon>()
    internal func showSpellCards() {
        var spells = Array<Spell>()
        for s in _curRole._unit._spellsInuse {
            if !s.isAuro && !s.isPassive {
                spells.append(s)
            }
        }
        if spells.count > 0 {
            let startX = -cellSize * 5.5
            let x = cellSize * 1.6
            var i = 0
            for s in spells {
                s._battle = self
                if s.selectable() {
                    let card = BattleSpellIcon()
                    card.spell = s
                    if wandFireMaster(spell: s) {
                        card.coolDown = s._timeleft - 1
                    } else if wandWitch(spell: s) {
                        card.coolDown = 0
                    } else {
                        card.coolDown = s._timeleft
                    }
                    //                card.setSize(which: spells.count)
                    card.position.y = cellSize * -2.5
                    card.position.x = startX + x * i.toFloat()
                    card.zPosition = 70
                    addChild(card)
                    _spellCards.append(card)
                    i += 1
                }
            }
        } else {
        }
        showCancel()
//        let ta = FrozenShoot()
//        ta._battle = self
//        card.create(spell: ta)
//        card.zPosition = 70
//        addChild(card)
    }
    internal func wandWitch(spell:Spell) -> Bool {
        if spell.isCurse {
            if _curRole._unit is Character {
                let char = _curRole._unit as! Character
                if char._weapon is WitchWand {
                    return true
                }
            }
        }
        return false
    }
    internal func wandFireMaster(spell:Spell) -> Bool {
        if spell.isMagical && spell.isFire {
            if _curRole._unit is Character {
                let char = _curRole._unit as! Character
                if char._weapon is FireMaster {
                    return true
                }
            }
        }
        
        return false
    }
    internal func removeSpellCards() {
        for card in _spellCards {
            card.removeFromParent()
        }
        _spellCards = Array<BattleSpellIcon>()
    }
    
    internal var _orders = Array<UIOrder>()
    internal func showOrder() {
        for o in _orders {
            o.isHidden = false
//            addChild(o)
        }
        if _curRole._unit._weapon is Instrument {
            _orderAttack.isHidden = true
        }
        if !_curRole._unit.isMainChar {
            _orderItem.isHidden = true
            _orderRecall.isHidden = true
            _orderSummon.isHidden = true
        }
        showUnitInfo(hidden: false)
    }
    internal func hideOrder() {
        for o in _orders {
            o.isHidden = true
//            o.removeFromParent()
        }
        showUnitInfo(hidden: true)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setEvilsBySeat(evils:Array<Creature>) {
        //        var ps = [BUnit.RLT,BUnit.RLM,BUnit.RLB,BUnit.RRT,BUnit.RRM,BUnit.RRB]
        var es = evils
//        let c = 6 - evils.count
//        for _ in 0...c - 1 {
//            let c = Creature()
//            c._seat = "empty"
//            es.append(c)
//        }
        for i in 0...es.count - 1 {
            let evil = BUnit()
            evil.specialUnit = es[i].specialUnit
            if es[i]._seat == "empty" {
                evil.createEmpty()
            } else {
                evil.create()
                evil.setUnit(unit: es[i])
                evil.faceWest()
                _rightRoles.append(evil)
                _evilsOrg.append(evil)
            }
            evil.unitPos = "right"
            evil.inleft = false
            evil._battle = self
            setEvilPosBySeat(unit: evil)
            addChild(evil)
        }
    }
    internal func setEvilPosBySeat(unit:BUnit) {
        let pos = unit._unit._seat
        switch pos {
        case "rlt":
            unit.position.x = rlt[0]
            unit.position.y = rlt[1]
            unit._seat = "rlt"
            if !unit.isEmpey {
                _right["rlt"] = unit
            }
            break;
        case "rlm":
            unit.position.x = rlm[0]
            unit.position.y = rlm[1]
            unit._seat = "rlm"
            if !unit.isEmpey {
                _right["rlm"] = unit
            }
            break;
        case "rlb":
            unit.position.x = rlb[0]
            unit.position.y = rlb[1]
            unit._seat = "rlb"
            if !unit.isEmpey {
                _right["rlb"] = unit
            }
            break;
        case "rrt":
            unit.position.x = rrt[0]
            unit.position.y = rrt[1]
            unit._seat = "rrt"
            if !unit.isEmpey {
                _right["rrt"] = unit
            }
            break;
        case "rrm":
            unit.position.x = rrm[0]
            unit.position.y = rrm[1]
            unit._seat = "rrm"
            if !unit.isEmpey {
                _right["rrm"] = unit
            }
            break;
        case "rrb":
            unit.position.x = rrb[0]
            unit.position.y = rrb[1]
            unit._seat = "rrb"
            if !unit.isEmpey {
                _right["rrb"] = unit
            }
            break;
        default:
            debug("set evil pos error")
            break
        }
    }
    internal var _evilsOrg = Array<BUnit>()
    func setEvils(evils:Array<Creature>) {
//        var ps = [BUnit.RLT,BUnit.RLM,BUnit.RLB,BUnit.RRT,BUnit.RRM,BUnit.RRB]
        var es = evils
//        let c = 6 - evils.count
//        for _ in 0...c - 1 {
//            let c = Creature()
//            c._seat = "empty"
//            es.append(c)
//        }
        for i in 0...es.count - 1 {
            let evil = BUnit()
            evil.specialUnit = es[i].specialUnit
            if es[i]._seat == "empty" {
                evil.createEmpty()
            } else {
                evil.create()
                evil.setUnit(unit: es[i])
                evil.faceWest()
                _rightRoles.append(evil)
                _evilsOrg.append(evil)
            }
            evil.unitPos = "right"
            evil.inleft = false
            evil._battle = self
            setEvilPos(unit: evil)
            addChild(evil)
        }
    }
    internal var _emptyPos = [0,1,2,3,4,5]
    func setEvilPos(unit:BUnit) {
        let index = seed(max: _emptyPos.count)
        let pos = _emptyPos[index]
        _emptyPos.remove(at: index)
        switch pos {
        case 0:
            unit.position.x = rlt[0]
            unit.position.y = rlt[1]
            unit._seat = "rlt"
            if !unit.isEmpey {
                _right["rlt"] = unit
            }
            break;
        case 1:
            unit.position.x = rlm[0]
            unit.position.y = rlm[1]
            unit._seat = "rlm"
            if !unit.isEmpey {
                
                _right["rlm"] = unit
            }
            break;
        case 2:
            unit.position.x = rlb[0]
            unit.position.y = rlb[1]
            unit._seat = "rlb"
            if !unit.isEmpey {
                
                _right["rlb"] = unit
            }
            break;
        case 3:
            unit.position.x = rrt[0]
            unit.position.y = rrt[1]
            unit._seat = "rrt"
            if !unit.isEmpey {
                
                _right["rrt"] = unit
            }
            break;
        case 4:
            unit.position.x = rrm[0]
            unit.position.y = rrm[1]
            unit._seat = "rrm"
            if !unit.isEmpey {
                
                _right["rrm"] = unit
            }
            break;
        case 5:
            unit.position.x = rrb[0]
            unit.position.y = rrb[1]
            unit._seat = "rrb"
            if !unit.isEmpey {
                
                _right["rrb"] = unit
            }
            break;
        default:
            debug("set evil pos error")
            break
        }
    }
    
    internal func createLeftUnit(c:Creature) {
        let role = BUnit()
        role.specialUnit = c.specialUnit
        role.create()
        role.setUnit(unit: c)
        role.unitPos = "left"
        role.inleft = true
        role._battle = self
        _leftRoles.append(role)
        role.faceEast()
        setRolePos(unit: role)
        addChild(role)
        
    }
    
    internal var _roles = Array<BUnit>()
    func setRoles(roles:Array<Creature>) {
        var ps = [BUnit.LLT,BUnit.LLM,BUnit.LLB,BUnit.LRT,BUnit.LRM,BUnit.LRB]
        for i in 0...roles.count - 1 {
            ps.remove(at: ps.index(of: roles[i]._seat)!)
            let role = BUnit()
            if roles[i].isMainChar {
                _mainChar = role
            }
            role.specialUnit = roles[i].specialUnit
            role.create()
            role.setUnit(unit: roles[i])
//            role.faceEast()
            role.unitPos = "left"
            role.inleft = true
            role._battle = self
            _leftRoles.append(role)
//            let e = roles[i]
//            print("\(e._name): 攻击：\(e._extensions.attack)，防御：\(e._extensions.defence)， 速度\(e._extensions.speed)")
            role.faceEast()
            setRolePos(unit: role)
            addChild(role)
        }
        
//        for s in ps {
//            let emptyBUnit = BUnit()
//            emptyBUnit.createEmpty()
//            let c = Creature()
//            c._seat = s
//            emptyBUnit._unit = c
//            setRolePos(unit: emptyBUnit)
//            addChild(emptyBUnit)
//        }
    }
//    internal var _rolePos = [0,1,2,3,4,5]
    func setRolePos(unit:BUnit) {
//        let index = seed(max: _rolePos.count)
        let pos = unit._unit._seat
//        _rolePos.remove(at: index)
        switch pos {
        case "llt":
            unit.position.x = llt[0]
            unit.position.y = llt[1]
            unit._seat = "llt"
            if !unit.isEmpey {
                
                _left["llt"] = unit
            }
            break;
        case "llm":
            unit.position.x = llm[0]
            unit.position.y = llm[1]
            unit._seat = "llm"
            if !unit.isEmpey {
                
                _left["llm"] = unit
            }
            break;
        case "llb":
            unit.position.x = llb[0]
            unit.position.y = llb[1]
            unit._seat = "llb"
            if !unit.isEmpey {
                
                _left["llb"] = unit
            }
            break;
        case "lrt":
            unit.position.x = lrt[0]
            unit.position.y = lrt[1]
            unit._seat = "lrt"
            if !unit.isEmpey {
                
                _left["lrt"] = unit
            }
            break;
        case "lrm":
            unit.position.x = lrm[0]
            unit.position.y = lrm[1]
            unit._seat = "lrm"
            if !unit.isEmpey {
                
                _left["lrm"] = unit
            }
            break;
        case "lrb":
            unit.position.x = lrb[0]
            unit.position.y = lrb[1]
            unit._seat = "lrb"
            if !unit.isEmpey {
                
                _left["lrb"] = unit
            }
            break;
        default:
            debug("set evil pos error")
            break
        }
    }
    func getPosByStr(_ str:String) -> Array<CGFloat> {
        switch str {
        case "llt":
            return llt;
        case "llm":
            return llm;
        case "llb":
            return llb;
        case "lrt":
            return lrt;
        case "lrm":
            return lrm;
        case "lrb":
            return lrb;
        case "rlt":
            return rlt;
        case "rlm":
            return rlm;
        case "rlb":
            return rlb;
        case "rrt":
            return rrt;
        case "rrm":
            return rrm;
        case "rrb":
            return rrb;
        default:
            return llt
        }
    }
    
    internal func removeFromLeft(unit:BUnit) {
        _left.removeValue(forKey: unit._seat)
        let index = _leftRoles.index(of: unit)
        if nil != index {
            _leftRoles.remove(at: index!)
        }
    }
    
    internal func removeFromRight(unit:BUnit) {
        _right.removeValue(forKey: unit._seat)
        let index = _rightRoles.index(of: unit)
        if nil != index {
            _rightRoles.remove(at: index!)
        }
    }
    
    func removeFromPart(unit:BUnit) {
        if unit.inleft {
            removeFromLeft(unit: unit)
        } else {
            removeFromRight(unit: unit)
        }
        let index = _roleAll.index(of: unit)
        if nil != index {
            _roleAll.remove(at: index!)
        }
    }
    
    func showItemTargets() {
        let item = _selectedItem.prop as! Item
        if item is TownScroll {
            Data.instance.stage.removeBattle(b: self)
            item.use(target: Creature())
            return
        }
        _waitingForSelectTarget = false
        
        if item.targetSelf {
            for u in _leftRoles {
                u.setSelectableMode()
            }
            for u in _rightRoles {
                u.setDefaultMode()
            }
            _itemTargets = _leftRoles
        } else {
            for u in _rightRoles {
                u.setSelectableMode()
            }
            _itemTargets = _rightRoles
        }
        waitingForSelectItemTarget = true
        showCancel()
    }
    
    func removeItemPanel(bip:BItemPanel) {
        bip.removeFromParent()
        waitingForSelectItemTarget = false
        showOrder()
        hideCancel()
    }
    
    internal func showSummonableSeats(selectAll:Bool = true) {
        cleanSummonSeats()
        var ps = [BUnit.LLT,BUnit.LLM,BUnit.LLB,BUnit.LRT,BUnit.LRM,BUnit.LRB]
        let index = ps.index(of: _char._seat)
        if nil != index {
            ps.remove(at: index!)
        }
        
        for s in ps {
            if _left.index(forKey: s) != nil {
                if selectAll {
                    _left[s]?.setSelectableMode()
                    _summonUnits[s] = _left[s]
                }
            } else {
                let emptyBUnit = BUnit()
                emptyBUnit.createEmpty()
                emptyBUnit.setSelectableMode()
                emptyBUnit._battle = self
                let c = Creature()
                c._seat = s
                emptyBUnit._unit = c
                setRolePos(unit: emptyBUnit)
                addChild(emptyBUnit)
                _summonUnits[s] = emptyBUnit
            }
        }
    }
    
    internal func cleanSummonSeats() {
        for u in _summonUnits.values {
            if u.isEmpey {
//                _summonUnits.removeValue(forKey: u._seat)
                u.removeFromParent()
            } else {
                u.setDefaultMode()
            }
        }
        _summonUnits = Dictionary<String, BUnit>()
    }
    
    internal func showMinionsList() {
        let clp = CharListPanel()
        var summonableMinions = Array<Creature>()
        for m in _char._minions {
            if m._seat == BUnit.STAND_BY {
                summonableMinions.append(m)
            }
        }
        let this = self
        clp.selectAction = {
            this.waitingForSelectSummonSeat = true
            this.showSummonableSeats()
            clp.removeFromParent()
            this._selectedMinion = clp._lastSelected.unit
        }
        clp.create(list: summonableMinions)
        
        addChild(clp)
    }
    
    internal func showRecallMinions() {
        for u in _leftRoles {
            if !u._unit.isMainChar {
                u.setSelectableMode()
            }
        }
    }
    
    internal var _summonUnits = Dictionary<String, BUnit>()
    internal var _selectedMinion = Creature()
    
    
    internal var s:CGFloat = 0
    internal var xd:CGFloat = 0
    internal var yd:CGFloat = 0
    
    internal var ttl = Array<CGFloat>()
    internal var ttm = Array<CGFloat>()
    internal var ttr = Array<CGFloat>()
    internal var tbl = Array<CGFloat>()
    internal var tbm = Array<CGFloat>()
    internal var tbr = Array<CGFloat>()
    internal var btl = Array<CGFloat>()
    internal var btm = Array<CGFloat>()
    internal var btr = Array<CGFloat>()
    internal var bbl = Array<CGFloat>()
    internal var bbm = Array<CGFloat>()
    internal var bbr = Array<CGFloat>()
    
    internal var llt = Array<CGFloat>()
    internal var llm = Array<CGFloat>()
    internal var llb = Array<CGFloat>()
    internal var lrt = Array<CGFloat>()
    internal var lrm = Array<CGFloat>()
    internal var lrb = Array<CGFloat>()
    internal var rlt = Array<CGFloat>()
    internal var rlm = Array<CGFloat>()
    internal var rlb = Array<CGFloat>()
    internal var rrt = Array<CGFloat>()
    internal var rrm = Array<CGFloat>()
    internal var rrb = Array<CGFloat>()
    
    var _left = Dictionary<String, BUnit>()
    var _right = Dictionary<String, BUnit>()
    
    var _leftRoles = Array<BUnit>()
    var _rightRoles = Array<BUnit>()
    
    var _curRole:BUnit = BUnit()
    var _mainChar:BUnit = BUnit()
    var _selectedItem = BItemComponent()
    var _specialEvents = Array<String>()
    var isFinalChallenge = false
}

class BattleSpellIcon:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let rect = CGRect(x: -cellSize * 0.75, y: -cellSize * 0.75, width: cellSize * 1.5, height: cellSize * 1.5)
        bg = SKShapeNode(rect: rect, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.zPosition = 40
        addChild(bg)
        
        let cooldownBG = SKShapeNode(rect: rect, cornerRadius: 4)
        cooldownBG.fillColor = UIColor.black
        cooldownBG.alpha = 0.55
        cooldownBG.isHidden = true
        cooldownBG.zPosition = 41
        addChild(cooldownBG)
        
        let cdNum = Label()
        cdNum.fontSize = 24
        cdNum.isHidden = true
        cdNum.zPosition = 42
        cdNum.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        addChild(cdNum)
        
        _cdNum = cdNum
        _cdBg = cooldownBG
    }
    internal var bg:SKShapeNode!
    internal var _spell:Spell!
    var spell:Spell {
        set {
            _spell = newValue
            let l = Label()
            l.text = _spell._name
            l.fontSize = 14
            l.position.y = -cellSize * 0.5 - 6
            l.zPosition = 40
            addChild(l)
            bg.strokeColor = QualityColor.getColor(_spell._quality)
        }
        get {
            return _spell
        }
    }
    
    internal var _cooldown = 0
    internal var _cdNum = Label()
    internal var _cdBg = SKShapeNode()
    var coolDown:Int {
        set {
            _cooldown = newValue
            if newValue > 0 {
                _cdBg.isHidden = false
                _cdNum.isHidden = false
                _cdNum.text = "\(newValue)"
                bg.strokeColor = UIColor.gray
            } else {
                _cdBg.isHidden = true
                _cdNum.isHidden = true
                bg.strokeColor = UIColor.white
            }
        }
        get {
            return _cooldown
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
