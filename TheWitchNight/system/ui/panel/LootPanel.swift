//
//  LootPanel.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/4/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class LootPanel:SKSpriteNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        _infoPanel.removeFromParent()
//        _lastSelectProp.selected = false
        if _selectButton.contains(touchPoint!) {
            addProps()
        } else {
            if _lastSelectProp.contains(touchPoint!) {
                removeProp(p: _lastSelectProp)
                _lastSelectProp = PropComponent()
            } else {
                for p in _propComponents {
                    if p.contains(touchPoint!) {
                        _lastSelectProp.selected = false
                        p.selected = true
                        _lastSelectProp = p
                        showInfo(pc:p)
                        return
                    }
                }
                _lastSelectProp.selected = false
                _lastSelectProp = PropComponent()
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
        let rect = CGRect(x: -cellSize * 3.5, y: -cellSize * 2, width: cellSize * 7, height: cellSize * 4)
        _bg = SKShapeNode(rect: rect, cornerRadius: 4)
        _bg.fillColor = UIColor.black
        addChild(_bg)
        addChild(_propBox)
    }
    
    func create(props:Array<Prop>) {
        _props = props
        createBg()
        listProps()
        createButtons()
    }
    
    private func createButtons() {
        _selectButton.text = "拾取"
        _selectButton.position.x = cellSize * 2.5
        _selectButton.position.y = cellSize * 2.5
        addChild(_selectButton)
        
        let lb = Label()
        lb.align = "left"
        lb.text = "丢弃：再次点击已选中的物品。"
        lb.position.x = -cellSize * 3.5
        lb.position.y = cellSize * 2.1
        lb.fontSize = 16
        addChild(lb)
    }
    
    private func listProps() {
        let startX = -cellSize * 2.5
        let startY = cellSize * 1.25
        var i = 0
        for p in _props {
            let lc = PropComponent()
            let y = i / 5
            let mod = i % 5
            lc.prop = p
            lc.position.x = startX + mod.toFloat() * cellSize * 1.25
            lc.position.y = startY - y.toFloat() * cellSize * 1.25
            _propBox.addChild(lc)
            _propComponents.append(lc)
            i += 1
        }
    }
    
    private func removeProp(p:PropComponent) {
        let index = _propComponents.index(of: p)
        if nil != index {
            _propComponents.remove(at: index!)
//            _props.remove(at: index!)
            p.removeFromParent()
        }
        
    }
    
    private func addProps() {
        let c = Data.instance._char!
        for pc in _propComponents {
            c.addProp(p: pc.prop)
        }
        removeFromParent()
        _battle.fadeOutBattle()
    }
    
    private func showInfo(pc:PropComponent) {
        let prop = pc.prop
        if prop is Item {
            let ii = ItemInfo()
            ii.create(item: prop as! Item)
            addChild(ii)
            _infoPanel = ii
        } else if prop is Outfit {
            let ai = ArmorInfo()
            ai.create(armor: prop as! Outfit)
            addChild(ai)
            _infoPanel = ai
        }
        _infoPanel.position.x = pc.position.x + cellSize * 0.5 + 5
        _infoPanel.position.y = pc.position.y + cellSize * 0.5
    }
    private var _lastSelectProp = PropComponent()
    private var _propBox = SKSpriteNode()
    private var _bg = SKShapeNode()
    private var _props = Array<Prop>()
    private var _propComponents = Array<PropComponent>()
    private var _selectButton = Button()
    private var _infoPanel = SKSpriteNode()
    var _battle:Battle!
//    private var _
}
