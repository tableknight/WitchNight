//
//  CharListPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/26.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class CharListPanel:SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        _lastSelected.selected = false
        if _closeButton.contains(touchPoint!) {
            closeAction()
            self.removeFromParent()
            _panel.pageReload()
        } else {
            for cc in _curPageList {
                if cc.contains(touchPoint!) {
                    cc.selected = true
                    _lastSelected = cc
                    if _item._count > 0 {
                        _item.use(target: cc.unit)
                        let c = cc.unit
                        cc.unit = c
                    }
                    selectAction()
                    break
                }
            }
        }
    }
    func create(list:Array<Creature>) {
        createBackground()
        addChild(_listBox)
        _list = list
        _closeButton.position.x = cellSize * 4.25 + 5
        _closeButton.position.y = cellSize * 1.625
        _closeButton.text = "关闭"
        addChild(_closeButton)
        _prevButton.position.x = _closeButton.position.x
        _prevButton.position.y = _closeButton.position.y - cellSize + 8
        _prevButton.text = "上一页"
        addChild(_prevButton)
        _nextButton.position.x = _closeButton.position.x
        _nextButton.position.y = _prevButton.position.y - cellSize + 8
        _nextButton.text = "下一页"
        addChild(_nextButton)
        let l = Label()
        l.position.x = -cellSize * 3.25
        l.position.y = cellSize * 2 + 8
        l.align = "left"
        l.fontSize = 14
        l.text = "选择：点击目标。"
        addChild(l)
        if list.count > _pageSize {
            _nextButton.isHidden = false
            _prevButton.isHidden = false
        } else {
            _nextButton.isHidden = true
            _prevButton.isHidden = true
        }
        showList()
    }
    private func createBackground() {
        let rect = CGRect(x: -cellSize * 3.25, y: -cellSize * 2, width: cellSize * 6.5, height: cellSize * 4)
        let bg = SKShapeNode(rect: rect, cornerRadius: 4)
        bg.fillColor = UIColor.black
//        addChild(bg)
        let bg0 = Data.createMask()//        addChild(bg0)
        
        let bgnode = SKSpriteNode()
//        bgnode.zPosition = UIStage.PANEL_LAYER + 11
        addChild(bgnode)
        
        bgnode.addChild(bg0)
        bgnode.addChild(bg)
    }
    private func showList() {
        let startX = -cellSize * 2.75
        let startY = cellSize * 1.75
        let width = cellSize * 3
        let height = cellSize * 1.25
        if _list.count > 0 {
            let end = getPageEnd() - 1
            let s = (_curPage - 1) * _pageSize
            for i in s...end {
                let base = i - (_curPage - 1) * _pageSize
                let y = base / 2
                let mod = base % 2

                let cc = CharComponent()
                cc.unit = _list[i]
                cc.position.x = startX + width * mod.toFloat()
                cc.position.y = startY - height * y.toFloat()
                
                _listBox.addChild(cc)
                _curPageList.append(cc)
            }
        }
    }
    private func getPageEnd() -> Int {
        let pages = _list.count / _pageSize
        if pages >= _curPage {
            return _curPage * _pageSize
        }
        return _list.count
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = UIStage.PANEL_LAYER + 10
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private var _list = Array<Creature>()
    private var _listBox = SKSpriteNode()
    private var _closeButton = Button()
    private var _nextButton = Button()
    private var _prevButton = Button()
    private var _pageSize = 6
    private var _curPageList = Array<CharComponent>()
    private var _curPage = 1
    var _lastSelected = CharComponent()
    var _panel = ItemPanel()
    var _item = Item()
    var closeAction = {}
    var selectAction = {}
}

class CharComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let rect = CGRect(x: 0, y: -cellSize, width: cellSize * 2.5, height: cellSize)
        _bg = SKShapeNode(rect: rect, cornerRadius: 2)
        _bg.fillColor = UIColor.black
        
        let gap:CGFloat = cellSize * 0.25
        _hpbar.position.x = gap
        _hpbar.position.y = -cellSize * 0.65
        _hpbar._color = UIColor.red
        _expbar.position.x = _hpbar.position.x
        _expbar.position.y = _hpbar.position.y - 10
        _expbar._color = UIColor.green
        _name.position.x = gap
        _name.position.y = -gap - 6
        _name.fontSize = 15
        _name.align = "left"
        
        addChild(_bg)
        addChild(_hpbar)
        addChild(_expbar)
        addChild(_name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var unit:Creature {
        set {
            _unit = newValue
            _name.text = "Lv.\(_unit._level.toInt())[\(_unit._name)]"
            _name.fontColor = QualityColor.getColor(_unit._quality)
            _hpbar.setBar(value: _unit._extensions.hp / _unit._extensions.health)
            _expbar.setBar(value: _unit._exp / _unit.expNext())
        }
        get {
            return _unit
        }
    }
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _bg.lineWidth = 4
                _bg.strokeColor = Data.SELECTED_HIGHLIGH_COLOR
            } else {
                _bg.lineWidth = 1
                _bg.strokeColor = UIColor.white
            }
        }
        get {
            return _selected
        }
    }
    internal var _selected = false
    internal var _unit = Creature()
    internal var _hpbar = HBar()
    internal var _expbar = HBar()
    internal var _name = Label()
    internal var _bg = SKShapeNode()
}
