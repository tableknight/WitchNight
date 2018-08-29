//
//  exts.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/20.
//  Copyright © 2018年 Chen. All rights reserved.
//
import SpriteKit
extension CGFloat {
    func toInt() -> Int {
        return Int(self)
    }
}
extension Int {
    func toFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension Array {
    func one() -> Element {
        let c = Core()
        let index = c.seed(max: self.count)
        return self[index]
    }
    
    
}

extension SKSpriteNode {
    var left:CGFloat {
        set {
            position.x = -cellSize * 7 + newValue
        }
        get {
            return position.x - cellSize * 7
        }
    }
    
    var top:CGFloat {
        set {
            position.y = cellSize * 4 - newValue
        }
        get {
            return position.y + cellSize * 4
        }
    }
    var cellSize:CGFloat {
        set {
            print("set cell size")
        }
        get {
            return Data.instance.cellSize
        }
    }
    
    func seed(min:Int = 0, max:Int = 100) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    func toTexture() -> SKTexture {
        let view = SKView()
        return view.texture(from: self)!
    }
}

extension SKTexture {
    func getCell(_ x:CGFloat, _ y:CGFloat, _ wSize:CGFloat = 1, _ hSize:CGFloat = 1) -> SKTexture {
        let cellSize = Data.instance.cellSize
        let w = size().width
        let h = size().height
        let _y = h / cellSize - y - 1
        let width = cellSize / w
        let height = cellSize / h
        
        let rect = CGRect(x: x * width, y: _y * height, width: width * wSize, height: height * hSize)
//        let rect = CGRect(x: 1 / 3, y: 1 / 4, width: 1 / 3, height: 1 / 4)
        let node = SKSpriteNode(texture: SKTexture(rect: rect, in: self))
        let view = SKView()
        return view.texture(from: node)!
    }
    
}
