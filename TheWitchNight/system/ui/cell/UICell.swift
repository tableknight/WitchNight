//
//  UICell.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/29.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UICell: SKSpriteNode {
    internal var _matrix = Array<Array<Int>>()
    var xSize:Int = 1
    var ySize:Int = 1
    var zLayer:Int = 1
    static let BEYOND_PLAYER = 1
    static let UNDER_PLAYER = -1
    var nameWithPos = Array<String>()
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        _matrix = [[Block.IMPASSABLE]]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func setTexture(_ texture:SKTexture) {
        self.texture = texture
        self.size = texture.size()
    }
    
    func canPlace(scene:RandomScene, x:Int, y:Int) -> Bool {
        for __y in 0...ySize - 1 {
            for __x in 0...xSize - 1 {
                if _matrix[__y][__x] != Block.PASSABLE {
                    let itemX = x + __x
                    let itemY = y + __y
                    if scene.getWeight(itemX, itemY) != Block.PASSABLE || scene.inPath(x: itemX.toFloat(), y: itemY.toFloat()) {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    func place(parent: Scenery, x:Int, y:Int, shadowR:Bool = false) {
        for __y in 0...ySize - 1 {
            for __x in 0...xSize - 1 {
                if _matrix[__y][__x] == Block.IMPASSABLE {
                    parent._matrix[y + __y][x + __x] = _matrix[__y][__x]
                }
                nameWithPos.append("\(y + __y)\(x + __x)")
            }
        }
        parent.addItemNode(item:self, x:x.toFloat(), y:y.toFloat())
        if shadowR {
            for _y in 0...ySize - 1 {
                let x0 = x + xSize
                let y0 = y + _y
                if _matrix[_y][xSize - 1] == Block.IMPASSABLE {
                    let sha = Shadow()
                    parent.addItemNode(item: sha, x: x0.toFloat(), y: y0.toFloat())
                }
            }
        }
    }
    
    func doTouch() {
        
    }
}

class Shadow:UICell {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setTexture(SKTexture(imageNamed: "sha.png"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
