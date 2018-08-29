//
//  Charactor.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/22.
//  Copyright © 2018年 Chen. All rights reserved.
//
// let unit = UIUnit()
// unit.setTexture("xxx.pmg")
//

import SpriteKit
class UIUnit:UIItem {
    private var _charTexture:SKTexture!
    var _charNode = SKSpriteNode()
    var _moveSpeed:CGFloat = 1
    var _contentUnit:Creature!
    var _sha:SKSpriteNode!
    var _wait:SKAction! = SKAction.wait(forDuration: TimeInterval(Data.instance.frameSize))
    var specialUnit = false
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        size = CGSize(width: cellSize, height: cellSize)
        _charNode.size = CGSize(width: cellSize, height: cellSize)
        addChild(_charNode)
        let shadow = SKSpriteNode(texture: SKTexture(imageNamed: "shadow.png"))
        shadow.position.y = -0.45 * cellSize
        shadow.position.x = 6
        addChild(shadow)
        _sha = shadow
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTexture(_ imageUrl:String) {
        _charTexture = SKTexture(imageNamed: imageUrl)
        faceSouth()
    }
    override func setTexture(_ texture:SKTexture) {
        _charTexture = texture
        faceSouth()
    }
    func setSpeed(_ speed:CGFloat = 1) {
        _moveSpeed = speed
        _wait = SKAction.wait(forDuration: TimeInterval(Data.instance.frameSize * speed))
    }
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
    func moveEast() {
        var y:CGFloat = 2
        if specialUnit {
            y = 3
        }
        let move1 = SKAction.setTexture(_charTexture.getCell(0, 2))
        let move2 = SKAction.setTexture(_charTexture.getCell(2, 2))
        let go = SKAction.sequence([move1, _wait, move2, _wait])
        _charNode.run(go)
    }
}
