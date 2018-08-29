//
//  MinionsHousePanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/10.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class MinionsHousePanel: UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        if _prevButton0.contains(touchPoint!) {
            if _curPageStored <= 1 {
                return
            }
            _curPageStored -= 1
            createStoredMinions()
        } else if _nextButton0.contains(touchPoint!) {
            if _curPageStored.toFloat() >= ceil(_char._storedMinions.count.toFloat() / _pageSize.toFloat()) {
                return
            }
            _curPageStored += 1
            createStoredMinions()
        } else if _prevButton.contains(touchPoint!) {
            if _curPageChar <= 1 {
                return
            }
            _curPageChar -= 1
            createCharMinions()
        } else if _nextButton.contains(touchPoint!) {
            if _curPageChar.toFloat() >= ceil(_char._minions.count.toFloat() / _pageSize.toFloat()) {
                return
            }
            _curPageChar += 1
            createCharMinions()
        } else if _closeButton.contains(touchPoint!) {
            Data.instance.stage.removePanelDefault(p: self)
        } else {
            for mc in _curStoredMinions {
                if mc.contains(touchPoint!) {
                    if _lastSelectedStoredMinion == mc {
                        let max = _char._setting[Character.MAX_MINIONS_COUNT] as! Int
                        if _char._minions.count < max {
                            let i = _char._storedMinions.index(of: mc.unit)
                            if nil != i {
                                _char._storedMinions.remove(at: i!)
                                _char._minions.append(mc.unit)
                                mc.unit._seat = BUnit.STAND_BY
                                mc.removeFromParent()
                                _lastSelectedStoredMinion = MinionsHouseComponent()
                                _curPageStored = 1
                                createStoredMinions()
                                _curPageChar = 1
                                createCharMinions()
                                setMinionsCountLabel()
                            }
                        }
                    } else {
                        _lastSelectedStoredMinion.selected = false
                        mc.selected = true
                        _lastSelectedStoredMinion = mc
                    }
                }
            }
            
            for mhc in _curCharMinions {
                if mhc.contains(touchPoint!) {
                    if _lastSelectedCharMinion == mhc {
                        let max = _char._setting[Character.MAX_STORED_MINIONS_COUNT] as! Int
                        if _char._storedMinions.count < max {
                            let i = _char._minions.index(of: mhc.unit)
                            if nil != i {
                                _char._minions.remove(at: i!)
                                _char._storedMinions.append(mhc.unit)
                                mhc.unit._seat = BUnit.STAND_BY
                                mhc.removeFromParent()
                                _lastSelectedCharMinion = MinionsHouseComponent()
                                _curPageStored = 1
                                createStoredMinions()
                                _curPageChar = 1
                                createCharMinions()
                                setMinionsCountLabel()
                            }
                        }
                    } else {
                        _lastSelectedCharMinion.selected = false
                        mhc.selected = true
                        _lastSelectedCharMinion = mhc
                    }
                }
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func create() {
        createCloseButton()
        createPageButtons()
        createPageButtons0()
        _bg.removeFromParent()
        
        _label.text = "存取：再次点击已选中的随从或宠物。"
        
        let b = CGRect(x: -cellSize * 6, y: -cellSize * 3, width: cellSize * 5.5, height: cellSize * 6)
        let bg = SKShapeNode(rect: b, cornerRadius: 4)
        bg.fillColor = UIColor.black
        bg.zPosition = self.zPosition + 2
        addChild(bg)
        let b2 = CGRect(x: cellSize * 0.5, y: -cellSize * 3, width: cellSize * 5.5, height: cellSize * 6)
        let bg2 = SKShapeNode(rect: b2, cornerRadius: 4)
        bg2.fillColor = UIColor.black
        bg2.zPosition = self.zPosition + 2
        addChild(bg2)
        
        _charMinionsBox.zPosition = self.zPosition + 4
        _storedMinionsBox.zPosition = self.zPosition + 4
        addChild(_charMinionsBox)
        addChild(_storedMinionsBox)
        
        _storedMinionsCount.position.x = -cellSize
        _storedMinionsCount.position.y = -cellSize * 3.5
        _storedMinionsCount.fontSize = 16
        _storedMinionsCount.zPosition = self.zPosition + 4
        addChild(_storedMinionsCount)
        
        _minionsCount.position.x = cellSize
        _minionsCount.position.y = -cellSize * 3.5
        _minionsCount.fontSize = 16
        _minionsCount.zPosition = self.zPosition + 4
        addChild(_minionsCount)
        
        setMinionsCountLabel()
        
        createCharMinions()
        createStoredMinions()
    }
    
    func setMinionsCountLabel() {
        _storedMinionsCount.text = "\(_char._storedMinions.count)/\(_char._setting["maxStoredMinionsCount"] ?? 0)"
        _minionsCount.text = "\(_char._minions.count)/\(_char._setting["maxMinionsCount"] ?? 0)"
    }
    
    func createPageButtons0() {
        _nextButton0.text = "下一页"
        _nextButton0.position.x = -cellSize * 5 + cellSize * 2.25
        _nextButton0.position.y = -cellSize * 3.5
        _nextButton0.zPosition = self.zPosition + 3
        addChild(_nextButton0)
        
        _prevButton0.text = "上一页"
        _prevButton0.position.x = -cellSize * 5
        _prevButton0.position.y = -cellSize * 3.5
        _prevButton0.zPosition = self.zPosition + 3
        addChild(_prevButton0)
    }
    
    func createCharMinions() {
        let s = (_curPageChar - 1) * _pageSize
        var e = _curPageChar * _pageSize
        if e >= _char._minions.count {
            e = _char._minions.count
        }
        
        let startX = cellSize
        let startY = cellSize * 2.6
        _curCharMinions = []
        _charMinionsBox.removeAllChildren()
        //for i in 0...3 {
        for i in s...e - 1 {
            let cc = MinionsHouseComponent()
            cc.position.x = startX
            cc.position.y = startY - (i - _pageSize * (_curPageChar - 1)).toFloat() * cellSize * 1.375
            cc.unit = _char._minions[_char._minions.count - i - 1]
            _charMinionsBox.addChild(cc)
            _curCharMinions.append(cc)
        }
    }
    
    func createStoredMinions() {
        let s = (_curPageStored - 1) * _pageSize
        var e = _curPageStored * _pageSize
        if e >= _char._storedMinions.count {
            e = _char._storedMinions.count
        }
        
        if e < 1 {
            return
        }
        
        let startX = -cellSize * 5.5
        let startY = cellSize * 2.6
        _curStoredMinions = []
        _storedMinionsBox.removeAllChildren()
        for i in s...e - 1 {
            let cc = MinionsHouseComponent()
            cc.position.x = startX
            cc.position.y = startY - (i - _pageSize * (_curPageStored - 1)).toFloat() * cellSize * 1.375
            cc.unit = _char._storedMinions[_char._storedMinions.count - i - 1]
            _storedMinionsBox.addChild(cc)
            _curStoredMinions.append(cc)
        }
    }
    
    internal var _prevButton0 = Button()
    internal var _nextButton0 = Button()
    private var _charMinionsBox = SKSpriteNode()
    private var _storedMinionsBox = SKSpriteNode()
    private var _pageSize = 4
    private var _curPageChar = 1
    private var _curPageStored = 1
    
    private var _curCharMinions = Array<MinionsHouseComponent>()
    private var _curStoredMinions = Array<MinionsHouseComponent>()
    
    private var _lastSelectedStoredMinion = MinionsHouseComponent()
    private var _lastSelectedCharMinion = MinionsHouseComponent()
    
    private var _storedMinionsCount = Label()
    private var _minionsCount = Label()
    
}

class MinionsHouseComponent:CharComponent {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        _char = Data.instance._char!
        _bg.removeFromParent()
        let rect = CGRect(x: 0, y: -cellSize * 1.125, width: cellSize * 4.5, height: cellSize * 1.25)
        _bg = SKShapeNode(rect: rect, cornerRadius: 2)
        addChild(_bg)
        _hpbar.position.x = cellSize * 1.5
        _expbar.position.x = _hpbar.position.x
        _name.position.x = _hpbar.position.x
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var unit: Creature {
        set {
            super.unit = newValue
            let actor = SKSpriteNode(texture: newValue._img.getCell(1, 0))
            actor.position.x = cellSize * 0.25
            actor.anchorPoint = CGPoint(x: 0, y: 1)
            addChild(actor)
        }
        get {
            return _unit
        }
    }
}
