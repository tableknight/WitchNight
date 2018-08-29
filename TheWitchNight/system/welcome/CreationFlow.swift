//
//  CreationFlow.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/7/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class CreationFlow:SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _selectImage.create()
        _selectItems.create()
        _selectSpell.create()
        _selectMinion.create()
        addChild(_selectSpell)
        addChild(_selectMinion)
        addChild(_selectItems)
        addChild(_selectImage)
        
        showImages()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func showImages() {
        _selectMinion.isHidden = true
        _selectItems.isHidden = true
        _selectSpell.isHidden = true
        _selectImage.isHidden = false
    }
    
    func showMinions() {
        _selectMinion.isHidden = false
        _selectItems.isHidden = true
        _selectSpell.isHidden = true
        _selectImage.isHidden = true
    }
    
    func showItems() {
        _selectMinion.isHidden = true
        _selectItems.isHidden = false
        _selectSpell.isHidden = true
        _selectImage.isHidden = true
    }
    
    func showSpells() {
        _selectMinion.isHidden = true
        _selectItems.isHidden = true
        _selectSpell.isHidden = false
        _selectImage.isHidden = true
    }
    
    func createChar() {
        let char = Character()
        char.create(level: 1)
        char._img = _selectImage._lastSelectedComponent.image
        char._minions = [_selectMinion._lastSelectedComponent.unit]
        char._spellsInuse = [_selectSpell._lastSelectedComponent.spell]
        for c in _selectItems.getSelectedItems() {
            char.addProp(p: c.item)
        }
        loadStage(char: char)
    }
    
    private func loadStage(char:Character) {
        removeFromParent()
        Data.instance._char = char
        let bUnit = BUnit()
        bUnit.setUnit(unit: char)
        bUnit.createForStage()
        let stage = UIStage()
        stage.showSceneMask()
        stage.setChar(bUnit)
        Data.instance.stage = stage
        Data.instance.scene.addChild(stage)
        stage.maskFadeOut {
            stage._char.speak(text: "新的世界，新的旅程！")
        }
    }
    
    private var _selectImage = SelectImage()
    private var _selectItems = SelectItems()
    private var _selectSpell = SelectSpell()
    private var _selectMinion = SelectMinion()
}
