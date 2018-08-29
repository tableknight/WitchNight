//
//  SmallHouse.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/25.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class SmallHouse:UIItem {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
//        let item = Data.instance.outside_b.getCell(0, 15, 2, 2)
//        setTexture(item)
        _items = [0, 0, 0]
        _xSize = 4
        _ySize = 2
        let oa3 = Data.instance.outside_a3
        let node = SKSpriteNode()
        
        let top_start = SKSpriteNode(texture: oa3.getCell(12, 0))
        let top_start_bottom = SKSpriteNode(texture: oa3.getCell(12, 1, 1, 0.5))
        top_start_bottom.anchorPoint = CGPoint(x: 0.5, y: 1)
        top_start_bottom.position.y = -cellSize * 0.5
        top_start.addChild(top_start_bottom)
        
        let top_connect = SKSpriteNode(texture: oa3.getCell(12.5, 0))
        let top_connect_bottom = SKSpriteNode(texture: oa3.getCell(12.5, 1, 1, 0.5))
        top_connect_bottom.anchorPoint = CGPoint(x: 0.5, y: 1)
        top_connect_bottom.position.y = -cellSize * 0.5
        top_connect.addChild(top_connect_bottom)
        
        let top_end = SKSpriteNode(texture: oa3.getCell(13, 0))
        let top_end_bottom = SKSpriteNode(texture: oa3.getCell(13, 1, 1, 0.5))
        top_end_bottom.anchorPoint = CGPoint(x: 0.5, y: 1)
        top_end_bottom.position.y = -cellSize * 0.5
        top_end.addChild(top_end_bottom)
        
        top_start.anchorPoint = CGPoint(x: 0.5, y: 0)
        top_connect.anchorPoint = CGPoint(x: 0.5, y: 0)
        top_end.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        top_connect.position.x = cellSize
        top_end.position.x = cellSize * 2
        
        let bottom_start = SKSpriteNode(texture: oa3.getCell(12, 2))
        let bottom_start_bottom = SKSpriteNode(texture: oa3.getCell(12, 3, 1, 0.5))
        bottom_start_bottom.anchorPoint = CGPoint(x: 0.5, y: 1)
        bottom_start_bottom.position.y = -cellSize * 0.5
        bottom_start.addChild(bottom_start_bottom)
        
        let door = SKSpriteNode(texture: Data.instance.outside_b.getCell(4, 8))
        
        let bottom_end = SKSpriteNode(texture: oa3.getCell(13, 2))
        let bottom_end_bottom = SKSpriteNode(texture: oa3.getCell(13, 3, 1, 0.5))
        bottom_end_bottom.anchorPoint = CGPoint(x: 0.5, y: 1)
        bottom_end_bottom.position.y = -cellSize * 0.5
        bottom_end.addChild(bottom_end_bottom)
        
        bottom_start.anchorPoint = CGPoint(x: 0.5, y: 1)
        door.anchorPoint = CGPoint(x: 0.5, y: 1)
        bottom_end.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        door.position.x = cellSize
        bottom_end.position.x = cellSize * 2
        
        node.addChild(top_start)
        node.addChild(top_connect)
        node.addChild(top_end)
        node.addChild(bottom_start)
        node.addChild(door)
        node.addChild(bottom_end)
        
        let sha = SKSpriteNode(texture: Data.instance.sha)
        sha.position.x = cellSize * 3
        sha.anchorPoint = CGPoint(x: 0.5, y: 1)
        node.addChild(sha)
        
        setTexture(node.toTexture())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
