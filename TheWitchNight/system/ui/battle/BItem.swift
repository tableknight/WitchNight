//
//  Bitem.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/5/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BItemPanel: SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        _infoPanel.removeFromParent()
        if _items.count > 28 {
            
        }
        if _closeButton.contains(touchPoint!) {
            _battle.removeItemPanel(bip: self)
        } else if _lastSelectedItem.contains(touchPoint!) {
            _battle._selectedItem = _lastSelectedItem
            _battle.showItemTargets()
            removeFromParent()
        } else {
            _lastSelectedItem.selected = false
            for bic in _itemComponents {
                if bic.contains(touchPoint!) {
                    let item = bic.prop as! Item
                    if item._timeleft < 1 {
                        bic.selected = true
                        _lastSelectedItem = bic
                        showInfo(pc: bic)
                    }
                }
            }
        }
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = UIStage.PANEL_LAYER
        isUserInteractionEnabled = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createBg() {
        _itemBox = SKSpriteNode()
        let rect = CGRect(x: -cellSize * 5, y: -cellSize * 2.5, width: cellSize * 10, height: cellSize * 5)
        _bg = SKShapeNode(rect: rect, cornerRadius: 4)
        _bg.fillColor = UIColor.black
        addChild(_bg)
        addChild(_itemBox)
    }
    
    func create(items:Array<Item>) {
        _items = items
        createBg()
        listProps()
        createButtons()
    }
    
    private func createButtons() {
        _closeButton = Button()
        _closeButton.text = "关闭"
        _closeButton.position.x = cellSize * 4
        _closeButton.position.y = cellSize * 3
        addChild(_closeButton)
        
        if _items.count > 28 {
            _prevButton = Button()
            _prevButton.text = "上一页"
            _prevButton.position.x = cellSize * 2
            _prevButton.position.y = cellSize * -3
            
            _closeButton = Button()
            _closeButton.text = "下一页"
            _closeButton.position.x = cellSize * 4
            _closeButton.position.y = cellSize * -3
            addChild(_prevButton)
            addChild(_closeButton)
        }
        
        let lb = Label()
        lb.align = "left"
        lb.text = "使用：再次点击已选中的物品。"
        lb.position.x = -cellSize * 5
        lb.position.y = cellSize * 2.6
        lb.fontSize = 16
        addChild(lb)
    }
    
    private func listProps() {
        let startX = -cellSize * 4
        let startY = cellSize * 1.75
        var i = 0
        for p in _items {
            let lc = BItemComponent()
            let y = i / 5
            let mod = i % 5
            lc.prop = p
            lc.position.x = startX + mod.toFloat() * cellSize * 1.25
            lc.position.y = startY - y.toFloat() * cellSize * 1.25
            lc.timeleft = p._timeleft
            _itemBox.addChild(lc)
            _itemComponents.append(lc)
            i += 1
        }
    }
    
    private func showInfo(pc:BItemComponent) {
        let prop = pc.prop
        let ii = ItemInfo()
        ii.create(item: prop as! Item)
        addChild(ii)
        _infoPanel = ii
        _infoPanel.position.x = pc.position.x + cellSize * 0.5 + 5
        _infoPanel.position.y = pc.position.y + cellSize * 0.5
    }
    
    private var _bg:SKShapeNode!
    private var _mask:SKShapeNode!
    private var _itemBox:SKSpriteNode!
    private var _items = Array<Item>()
    private var _itemComponents = Array<BItemComponent>()
    
    var _battle:Battle!
    private var _closeButton = Button()
    private var _nextButton:Button!
    private var _prevButton:Button!
    private var _lastSelectedItem = BItemComponent()
    private var _infoPanel = SKSpriteNode()
}

class BItemComponent:PropComponent {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let rect = CGRect(origin: CGPoint(x: -cellSize * 0.5, y: -cellSize * 0.5), size: self.size)
        
        let cooldownBG = SKShapeNode(rect: rect, cornerRadius: 2)
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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var _timeleft = 0
    private var _cdNum = Label()
    private var _cdBg = SKShapeNode()
    var timeleft:Int {
        set {
            _timeleft = newValue
            if newValue > 0 {
                _cdBg.isHidden = false
                _cdNum.isHidden = false
                _cdNum.text = "\(newValue)"
                _bg.strokeColor = UIColor.gray
            } else {
                _cdBg.isHidden = true
                _cdNum.isHidden = true
                _bg.strokeColor = UIColor.white
            }
        }
        get {
            return _timeleft
        }
    }
}
