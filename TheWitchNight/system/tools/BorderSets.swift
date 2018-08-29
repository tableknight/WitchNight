//
//  BorderSets.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/13.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class BorderSets: Core {
    var _border:SKTexture = SKTexture()
    var _corner:SKTexture = SKTexture()
    init(border:SKTexture, corner:SKTexture) {
        _border = border
        _corner = corner
//        let view = SKView()
////        let cellSize = Data.instance.cellSize
//        var node = SKSpriteNode(texture:border.getCell(0, 0))
//        var smallCorner = SKSpriteNode(texture:corner.getCell(0.5, 0, 0.5, 0.5))
//        smallCorner.anchorPoint = CGPoint(x: 0, y: 1)
//        node.addChild(smallCorner)
//        top_left_corner = view.texture(from: node)
//
//        node = SKSpriteNode(texture:border.getCell(1, 0))
//        smallCorner = SKSpriteNode(texture:corner.getCell(0, 0, 0.5, 0.5))
//        smallCorner.anchorPoint = CGPoint(x: 1, y: 1)
//        node.addChild(smallCorner)
//        top_right_corner = view.texture(from: node)
//
//        node = SKSpriteNode(texture:border.getCell(0, 1))
//        smallCorner = SKSpriteNode(texture:corner.getCell(0.5, -0.5, 0.5, 0.5))
//        smallCorner.anchorPoint = CGPoint(x: 0, y: 0)
//        node.addChild(smallCorner)
//        bottom_left_corner = view.texture(from: node)
//
//        node = SKSpriteNode(texture:border.getCell(1, 1))
//        smallCorner = SKSpriteNode(texture:corner.getCell(0, -0.5, 0.5, 0.5))
//        smallCorner.anchorPoint = CGPoint(x: 1, y: 0)
//        node.addChild(smallCorner)
//        bottom_right_corner = view.texture(from: node)
//
//        node = SKSpriteNode(texture:border.getCell(0, 0.5))
//        var smallBorder = border.getCell(1, 0.5)
//        smallCorner = SKSpriteNode(texture:smallBorder.getCell(0.5, -0.5, 0.5, 0.5))
//        smallCorner.anchorPoint = CGPoint(x: 0, y: 0)
//        node.addChild(smallCorner)
//        smallCorner = SKSpriteNode(texture:smallBorder.getCell(0.5, 0, 0.5, 0.5))
//        smallCorner.anchorPoint = CGPoint(x: 0, y: 1)
//        node.addChild(smallCorner)
//        vertical_border = view.texture(from: node)
//
//        node = SKSpriteNode(texture:border.getCell(0.5, 0))
//        smallBorder = border.getCell(0.5, 1)
//        smallCorner = SKSpriteNode(texture:smallBorder.getCell(0, 0, 0.5, 0.5))
//        smallCorner.anchorPoint = CGPoint(x: 1, y: 1)
//        node.addChild(smallCorner)
//        smallCorner = SKSpriteNode(texture:smallBorder.getCell(0.5, 0, 0.5, 0.5))
//        smallCorner.anchorPoint = CGPoint(x: 0, y: 1)
//        node.addChild(smallCorner)
//        horizontal_border = view.texture(from: node)
    }
    
    func topLeftCorner() -> SKTexture {
        let view = SKView()
        let node = SKSpriteNode(texture:_border.getCell(0, 0))
        let smallCorner = SKSpriteNode(texture:_corner.getCell(0.5, 0, 0.5, 0.5))
        smallCorner.anchorPoint = CGPoint(x: 0, y: 1)
        node.addChild(smallCorner)
        return view.texture(from: node)!
    }
    
    func topRightCorner() -> SKTexture {
        let view = SKView()
        let node = SKSpriteNode(texture:_border.getCell(1, 0))
        let smallCorner = SKSpriteNode(texture:_corner.getCell(0, 0, 0.5, 0.5))
        smallCorner.anchorPoint = CGPoint(x: 1, y: 1)
        node.addChild(smallCorner)
        return view.texture(from: node)!
    }
    
    func bottomLeftCorner() -> SKTexture {
        let view = SKView()
        let node = SKSpriteNode(texture:_border.getCell(0, 1))
        let smallCorner = SKSpriteNode(texture:_corner.getCell(0.5, -0.5, 0.5, 0.5))
        smallCorner.anchorPoint = CGPoint(x: 0, y: 0)
        node.addChild(smallCorner)
        return view.texture(from: node)!
    }
    
    func bottomRightCorner() -> SKTexture {
        let view = SKView()
        let node = SKSpriteNode(texture:_border.getCell(1, 1))
        let smallCorner = SKSpriteNode(texture:_corner.getCell(0, -0.5, 0.5, 0.5))
        smallCorner.anchorPoint = CGPoint(x: 1, y: 0)
        node.addChild(smallCorner)
        return view.texture(from: node)!
    }
    
    func verticalBorder() -> SKTexture {
        let view = SKView()
        let node = SKSpriteNode(texture:_border.getCell(0, 0.5))
        let smallBorder = _border.getCell(1, 0.5)
        var smallCorner = SKSpriteNode(texture:smallBorder.getCell(0.5, -0.5, 0.5, 0.5))
        smallCorner.anchorPoint = CGPoint(x: 0, y: 0)
        node.addChild(smallCorner)
        smallCorner = SKSpriteNode(texture:smallBorder.getCell(0.5, 0, 0.5, 0.5))
        smallCorner.anchorPoint = CGPoint(x: 0, y: 1)
        node.addChild(smallCorner)
        return view.texture(from: node)!
    }
    
    func horizontalBorder() -> SKTexture {
        let view = SKView()
        let node = SKSpriteNode(texture:_border.getCell(0.5, 0))
        let smallBorder = _border.getCell(0.5, 1)
        var smallCorner = SKSpriteNode(texture:smallBorder.getCell(0, 0, 0.5, 0.5))
        smallCorner.anchorPoint = CGPoint(x: 1, y: 1)
        node.addChild(smallCorner)
        smallCorner = SKSpriteNode(texture:smallBorder.getCell(0.5, 0, 0.5, 0.5))
        smallCorner.anchorPoint = CGPoint(x: 0, y: 1)
        node.addChild(smallCorner)
        return view.texture(from: node)!
    }
    
}
