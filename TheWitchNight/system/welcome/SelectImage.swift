//
//  SelectImage.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SelectImage:UIPanel {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        
        for u in _listBox.children {
            if u.contains(touchPoint!) {
                let rc = u as! ImageComponent
                _lastSelectedComponent.selected = false
                _lastSelectedComponent = rc
                _lastSelectedComponent.selected = true
                return
            }
        }
        
        if _prevButton.contains(touchPoint!) {
            
        }
        if _nextButton.contains(touchPoint!) {
            if !hasSelected() {
                return
            }
            (parent as! CreationFlow).showMinions()
        }
    }
    override func create() {
        createCloseButton()
        createPageButtons()
        _label.text = "选择角色形象"
        _closeButton.text = "返回"
//        _closeButton.isHidden = true
        _prevButton.text = "上一步"
        _prevButton.isHidden = true
        _nextButton.text = "下一步"
        
        addChild(_listBox)
        _images = [
            Data.instance.pictureCollabo8_2.getCell(6, 3, 3, 4),
            Data.instance.pictureAll2.getCell(6, 3, 3, 4),
            Data.instance.pictureActor3.getCell(3, 7, 3, 4),
            Data.instance.pictureActor1.getCell(0, 7, 3, 4),
            Data.instance.pictureActor1.getCell(9, 3, 3, 4),
            Data.instance.picturePeople1.getCell(0, 3, 3, 4),
        ]
        createCharList()
    }
    
    private func createCharList() {
        let startX = -cellSize * 5
        let startY = cellSize * 2.25
        let width = cellSize * 5.5
        let height = cellSize * 1.75
        if _images.count > 0 {
            for i in 0..._images.count - 1 {
                let y = i % 3
                let x = i / 3
                
                let cc = ImageComponent()
//                cc.unit = _chars[i]
                cc.image = _images[i]
                cc.position.x = startX + width * x.toFloat()
                cc.position.y = startY - height * y.toFloat()
                cc.zPosition = self.zPosition + 2
                _listBox.addChild(cc)
            }
        }
    }
    private func loadStage(char:Character) {
        Data.instance._char = char
        let bUnit = BUnit()
        bUnit.setUnit(unit: char)
        bUnit.createForStage()
        let stage = UIStage()
        stage.setChar(bUnit)
        Data.instance.scene.addChild(stage)
        stage.showSceneMask()
        stage.maskFadeOut {
            
        }
        //        let out = SKAction.fadeOut(withDuration: TimeInterval(1))
        //        self.parent?.addChild(stage)
        //        scene?.addChild(stage)
    }
    private func hasSelected() -> Bool {
        for n in _listBox.children {
            let c = n as! ImageComponent
            if c.selected {
                return true
            }
        }
        return false
    }
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var _listBox = SKSpriteNode()
    var _images = Array<SKTexture>()
    var _lastSelectedComponent = ImageComponent()
}

class ImageComponent:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //        _char = Data.instance._char!
//        _bg.removeFromParent()
        let rect = CGRect(x: 0, y: -cellSize * 1.125, width: cellSize * 4.5, height: cellSize * 1.25)
        _bg = SKShapeNode(rect: rect, cornerRadius: 2)
        addChild(_bg)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var image: SKTexture {
        set {
            createImage(texture: newValue.getCell(1, 0), x: cellSize * 0.25)
            createImage(texture: newValue.getCell(1, 1), x: cellSize * 1.25)
            createImage(texture: newValue.getCell(1, 2), x: cellSize * 2.25)
            createImage(texture: newValue.getCell(1, 3), x: cellSize * 3.25)
            _image = newValue
        }
        get {
            return _image
        }
    }
    
    private func createImage(texture:SKTexture, x:CGFloat) {
        let node = SKSpriteNode(texture: texture)
        node.position.x = x
        node.anchorPoint = CGPoint(x: 0, y: 1)
        addChild(node)
//        return node
    }
    
    var selected:Bool {
        set {
            _selected = newValue
            if newValue {
                _bg.lineWidth = Data.SELECTED_STROKE_WIDTH
                _bg.strokeColor = Data.SELECTED_HIGHLIGH_COLOR
            } else {
                _bg.lineWidth = Data.UNSELECTED_STROKE_WIDTH
                _bg.strokeColor = Data.UNSELECTED_STROKE_COLOR
            }
        }
        get {
            return _selected
        }
    }
    internal var _selected = false
    
    private var _image = SKTexture()
    private var _bg = SKShapeNode()
}
