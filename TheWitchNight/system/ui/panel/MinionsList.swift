//
//  MinionsPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/9.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MinionsList:UIPanel {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        isUserInteractionEnabled = true
//        let bg = SKSpriteNode()
//        bg.size = CGSize(width: Data.instance.screenWidth, height: Data.instance.screenHeight)
//        bg.color = UIColor.darkGray
//        addChild(bg)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _closeButton.contains(touchPoint!) {
            Data.instance.stage.closeMinionsListPanel(panel: self)
            return
        }
        
        if _discardButton.contains(touchPoint!) {
            if !_lastSelectedComponent.selected {
                return
            }
            if _discardButton.selected {
                _discardButton.selected = false
                _lastSelectedComponent.removeFromParent()
                let char = Data.instance._char!
                let index = char._minions.index(of: _lastSelectedComponent._minion)
                if nil != index {
                    char._minions.remove(at: index!)
                }
                _lastSelectedComponent = MinionComponent()
            } else {
                _discardButton.selected = true
            }
        }
        
//        for mc in _minionComponents {
//            if mc.contains(touchPoint!) {
//                if mc.selected {
//
//                } else {
//                    mc.selected = true
//                    _lastSelectedComponent.selected = false
//                    _lastSelectedComponent = mc
//                }
//            }
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func createPanelbackground() {
        let b = CGRect(x: -cellSize * 6.5, y: -cellSize * 3, width: cellSize * 13, height: cellSize * 6)
        let bg = SKShapeNode(rect: b, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.zPosition = self.zPosition + 2
        addChild(bg)
        _bg = bg
    }
    
    var _minionComponents = Array<MinionComponent>()
    var _lastSelectedComponent = MinionComponent()
    var _minions = Array<Creature>()
    var _discardButton = Button()
    func create(minions:Array<Creature>) {
        createCloseButton()
        _closeButton.position.x += cellSize * 0.5
        
        _discardButton.position.x = _closeButton.position.x
        _discardButton.position.y = -_closeButton.position.y
        _discardButton.zPosition = _closeButton.zPosition
        _discardButton.text = "丢弃"
        addChild(_discardButton)
        
        _label.text = "查看：再次点击已选中单位。"
        _label.position.x = -cellSize * 6.5
        
        let count = Label()
        count.position.y = -_label.position.y - 10
        count.position.x = _label.position.x
        count.zPosition = _label.zPosition
        count.align = "left"
        count.fontSize = _label.fontSize
        count.text = "随从：\(_char._minions.count)/6 作战单位：\(_char._minionsCount)"
        addChild(count)
        
        _minions = minions
        let size = minions.count - 1
        let startY = cellSize * 2.6
        for i in 0...size {
            let x = i / 4
            let y = i % 4
            let mc = MinionComponent()
            mc.create(minion: minions[i])
            if x < 1 {
                mc.position.x = -cellSize * 6
            } else {
                mc.position.x = cellSize * 0.25
            }
            mc.zPosition = self.zPosition + 5
            mc.position.y = startY - y.toFloat() * cellSize * 1.4
            mc._panelMinionsList = self
            addChild(mc)
            _minionComponents.append(mc)
        }
    }
    
    func changeSeat(seat:String) {
        for m in _minionComponents {
            m.lightOff(seat: seat)
        }
    }
}

class MinionComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        self.size = CGSize(width: cellSize * 2.75, height: cellSize * 6)
//        let bg = SKShapeNode(rect: CGRect(origin: CGPoint(x: -cellSize * 1.5, y: -cellSize * 3), size: self.size), cornerRadius: 4 )
//        bg.fillColor = UIColor.black
//        addChild(bg)
        isUserInteractionEnabled = true
    }
    
    func getReadyMinionsCount() -> Int {
        var i = 0
        for m in Data.instance._char._minions {
            if m._seat != BUnit.STAND_BY && m != _minion {
                i += 1
            }
        }
        return i
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
//        let lightColor = UIColor.white
        let charSeat = Data.instance._char._seat
        if _llt.contains(touchPoint!) {
            if BUnit.LLT == charSeat {
                return
            }
            if _minion._seat == BUnit.LLT {
                light(p: SKSpriteNode())
                _minion._seat = BUnit.STAND_BY
            } else {
                if getReadyMinionsCount() >= Data.instance._char._minionsCount {
                    return
                }
                _panelMinionsList.changeSeat(seat: BUnit.LLT)
                light(p: _llt)
                _minion._seat = BUnit.LLT
            }
        } else if _llm.contains(touchPoint!) {
            if BUnit.LLM == charSeat {
                return
            }
            if _minion._seat == BUnit.LLM {
                light(p: SKSpriteNode())
                _minion._seat = BUnit.STAND_BY
            } else {
                if getReadyMinionsCount() >= Data.instance._char._minionsCount {
                    return
                }
                _panelMinionsList.changeSeat(seat: BUnit.LLM)
                light(p: _llm)
                _minion._seat = BUnit.LLM
            }
        } else if _llb.contains(touchPoint!) {
            if BUnit.LLB == charSeat {
                return
            }
            if _minion._seat == BUnit.LLB {
                light(p: SKSpriteNode())
                _minion._seat = BUnit.STAND_BY
            } else {
                if getReadyMinionsCount() >= Data.instance._char._minionsCount {
                    return
                }
                _panelMinionsList.changeSeat(seat: BUnit.LLB)
                light(p: _llb)
                _minion._seat = BUnit.LLB
            }
        } else if _lrt.contains(touchPoint!) {
            if BUnit.LRT == charSeat {
                return
            }
            if _minion._seat == BUnit.LRT {
                light(p: SKSpriteNode())
                _minion._seat = BUnit.STAND_BY
            } else {
                if getReadyMinionsCount() >= Data.instance._char._minionsCount {
                    return
                }
                _panelMinionsList.changeSeat(seat: BUnit.LRT)
                light(p: _lrt)
                _minion._seat = BUnit.LRT
            }
        } else if _lrm.contains(touchPoint!) {
            if BUnit.LRM == charSeat {
                return
            }
            if _minion._seat == BUnit.LRM {
                light(p: SKSpriteNode())
                _minion._seat = BUnit.STAND_BY
            } else {
                if getReadyMinionsCount() >= Data.instance._char._minionsCount {
                    return
                }
                _panelMinionsList.changeSeat(seat: BUnit.LRM)
                light(p: _lrm)
                _minion._seat = BUnit.LRM
            }
        } else if _lrb.contains(touchPoint!) {
            if BUnit.LRB == charSeat {
                return
            }
            if _minion._seat == BUnit.LRB {
                light(p: SKSpriteNode())
                _minion._seat = BUnit.STAND_BY
            } else {
                if getReadyMinionsCount() >= Data.instance._char._minionsCount {
                    return
                }
                _panelMinionsList.changeSeat(seat: BUnit.LRB)
                light(p: _lrb)
                _minion._seat = BUnit.LRB
            }
        } else {
            if selected {
                let mp = RoleInfoPanel()
                mp.create(char: _minion)
//                _panelMinionsList.isHidden = true
                Data.instance.stage.closeMinionsListPanel(panel: _panelMinionsList)
                Data.instance.stage.showCharPanel(panel: mp)
                
                return
            }
            if (touchPoint?.x)! < cellSize * 3.5 {
                selected = true
                _panelMinionsList._lastSelectedComponent.selected = false
                _panelMinionsList._lastSelectedComponent = self
                _panelMinionsList._discardButton.selected = false
            }
        }
    }
    var _panelMinionsList:MinionsList!
    func light(p:SKSpriteNode) {
        let lightColor = UIColor.lightGray
        let charSeat = Data.instance._char._seat
        if BUnit.LLT != charSeat {
            _llt.color = lightColor
        }
        if BUnit.LLM != charSeat {
            _llm.color = lightColor
        }
        if BUnit.LLB != charSeat {
            _llb.color = lightColor
        }
        if BUnit.LRT != charSeat {
            _lrt.color = lightColor
        }
        if BUnit.LRM != charSeat {
            _lrm.color = lightColor
        }
        if BUnit.LRB != charSeat {
            _lrb.color = lightColor
        }
        p.color = UIColor.white
    }
    
    func lightOff(seat:String) {
        if _minion._seat == seat {
            _minion._seat = BUnit.STAND_BY
            light(p: SKSpriteNode())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createBg() {
        let rect = CGRect(x: 0, y: -cellSize * 1.125, width: cellSize * 5.75, height: cellSize * 1.25)
        _bg = SKShapeNode(rect: rect, cornerRadius: 2)
        _bg.fillColor = UIColor.black
        _bg.strokeColor = UIColor.gray
        addChild(_bg)
        
    }
    private var _bg = SKShapeNode()
    
    var _minion = Creature()
    func create(minion:Creature) {
        createBg()
        _minion = minion
        let m = _minion
        
//        let apr = CGPoint(x: 0, y: 1)
//        let apl = CGPoint(x: 1, y: 1)
//        let apc = CGPoint(x: 0.5, y: 1)
//        let fontColor = UIColor.white
        let img = SKSpriteNode(texture: m._img.getCell(1, 0))
        img.position.x = cellSize * 0.25
        img.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(img)
//        let img1 = SKSpriteNode(texture: m._img.getCell(1, 3))
//        img1.anchorPoint = apr
//        img1.position.y = startY
//        addChild(img1)
        
        
        
        let level = Label()
        level.text = "lv.\(m._level.toInt())[\(m._name)]"
        level.fontColor = QualityColor.getColor(m._quality)
//        level.position.y = startY - cellSize - 23
//        level.position.x = startX
        level.fontSize = 14
        level.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        addChild(level)
        
        let _hpbar = HBar()
        _hpbar._color = UIColor.red
        _hpbar.setBar(value: m._extensions.hp / m._extensions.health)
//        _hpbar.position.y = level.position.y - 15
//        _hpbar.position.x = startX
//        _hpbar.anchorPoint = apc
        addChild(_hpbar)
        
        let _expbar = HBar()
        _expbar._color = UIColor.green
        _expbar.setBar(value: m._exp / m.expNext())
//        _expbar.position.y = _hpbar.position.y - 15
//        _expbar.position.x = startX
//        _expbar.anchorPoint = apc
        addChild(_expbar)
        
        let gap:CGFloat = cellSize * 0.25
        
        _hpbar.position.y = -cellSize * 0.65
        _expbar.position.y = _hpbar.position.y - 10
        level.position.y = -gap - 6
        _hpbar.position.x = cellSize * 1.5
        _expbar.position.x = _hpbar.position.x
        level.position.x = _hpbar.position.x
        
        let colorLight = UIColor.white
        let colorChar = QualityColor.RARE
        let charSeat = Data.instance._char._seat
        
        let yH = cellSize * 0.35
        
        let startY:CGFloat = 0
        let startX = cellSize * 3.75
        
        let llt = getSeat()
        llt.position.x = startX
        llt.position.y = startY
        addChild(llt)
        if m._seat == BUnit.LLT {
            llt.color = colorLight
        } else if charSeat == BUnit.LLT {
            llt.color = colorChar
        }
        
        let lrt = getSeat()
        lrt.position.x = llt.position.x + cellSize - 3
        lrt.position.y = llt.position.y
        addChild(lrt)
        if m._seat == BUnit.LRT {
            lrt.color = colorLight
        } else if charSeat == BUnit.LRT {
            lrt.color = colorChar
        }
        
        let llm = getSeat()
        llm.position.x = startX
        llm.position.y = llt.position.y - yH
        addChild(llm)
        if m._seat == BUnit.LLM {
            llm.color = colorLight
        } else if charSeat == BUnit.LLM {
            llm.color = colorChar
        }
        
        let lrm = getSeat()
        lrm.position.x = lrt.position.x
        lrm.position.y = lrt.position.y - yH
        addChild(lrm)
        if m._seat == BUnit.LRM {
            lrm.color = colorLight
        } else if charSeat == BUnit.LRM {
            lrm.color = colorChar
        }
        
        let llb = getSeat()
        llb.position.x = startX
        llb.position.y = llm.position.y - yH
        addChild(llb)
        if m._seat == BUnit.LLB {
            llb.color = colorLight
        } else if charSeat == BUnit.LLB {
            llb.color = colorChar
        }
        
        let lrb = getSeat()
        lrb.position.x = lrt.position.x
        lrb.position.y = llm.position.y - yH
        addChild(lrb)
        if m._seat == BUnit.LRB {
            lrb.color = colorLight
        } else if charSeat == BUnit.LRB {
            lrb.color = colorChar
        }
        
//        let btn = MenuButton()
//        btn.setText(text: "丢弃")
//        btn.position.x = cellSize * 0.5
//        btn.position.y = lrb.position.y - cellSize
//        addChild(btn)
//        _discard = btn
        _llt = llt
        _llm = llm
        _llb = llb
        _lrt = lrt
        _lrm = lrm
        _lrb = lrb
    }
    var _llt = SKSpriteNode()
    var _llm = SKSpriteNode()
    var _llb = SKSpriteNode()
    var _lrt = SKSpriteNode()
    var _lrm = SKSpriteNode()
    var _lrb = SKSpriteNode()
    var _discard:MenuButton!
    func getSeat(color:UIColor = UIColor.lightGray) -> SKSpriteNode {
        let node = SKSpriteNode()
        node.size = CGSize(width: cellSize * 0.85, height: cellSize * 0.3)
        node.color = color
        node.anchorPoint = CGPoint(x: 0, y: 1)
        return node
    }
    
    private var _select = false
    var selected:Bool {
        set {
            if newValue {
                _bg.lineWidth = 2
                _bg.strokeColor = UIColor.white
            } else {
                _bg.lineWidth = 1
                _bg.strokeColor = UIColor.gray
            }
            _select = newValue
        }
        get {
            return _select
        }
    }
}
