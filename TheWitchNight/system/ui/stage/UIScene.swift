//
//  UIScene.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/2/23.
//  Copyright © 2018年 Chen. All rights reserved.
//

import SpriteKit
class UIScene:SKSpriteNode {
    internal var _sha = SKTexture(imageNamed: "wall_deep.png")
    var _curX = 0
    internal var _level = 1
    var isRandomScene = false
    var hasInitialized = false
    internal func createTopWall() {
        let node = SKSpriteNode()
        for i in 0...xSize.toInt() - 1 {
            var wallTexture = _groundSets.wallConnect()
            if 0 == i {
                wallTexture = _groundSets.wallStart()
            }
            if (xSize - 1).toInt() == i {
                wallTexture = _groundSets.wallEnd()
            }
            let wall = SKSpriteNode(texture: wallTexture)
            wall.position.x = cellSize * i.toFloat()
            wall.anchorPoint = CGPoint(x: 0.5, y: 1)
            wall.zPosition = UIStage.LAYER1
            node.addChild(wall)
        }
        
        let t = node.toTexture()
        let _wall = SKSpriteNode()
        
        //        node.removeFromParent()
        _wall.anchorPoint = CGPoint(x: 0, y: 0.5)
        _wall.position.x = -cellSize * 0.5
        _wall.texture = t
        _wall.position.y = cellSize * (_groundSize + 1).toFloat()
        _wall.size = t.size()
        _wall.zPosition = UIStage.LAYER1
        addChild(_wall)
    }
    internal var _groundSize = 3
//    var stage:UIStage = Data.instance.stage
    internal func createGround(start:Int, end:Int) {
        let node = SKSpriteNode()
        var _end = end
        if end > xSize.toInt() {
            _end = xSize.toInt()
        }
        let size = _groundSize
        for i in start..._end - 1 {
            var groundTexture = _groundSets.groundConnect(size)
            var wallTexture = _groundSets.wallConnect()
            if 0 == i {
                groundTexture = _groundSets.groundStart(size)
                wallTexture = _groundSets.wallStart()
            }
            if (xSize - 1).toInt() == i {
                groundTexture = _groundSets.groundEnd(size)
                wallTexture = _groundSets.wallEnd()
            }
            let ground = SKSpriteNode(texture: groundTexture)
            let wall = SKSpriteNode(texture: wallTexture)
            let sha = SKSpriteNode(texture: _sha)
            ground.position.x = cellSize * (i - start).toFloat()
            wall.position.x = cellSize * (i - start).toFloat()
            sha.position.x = cellSize * (i - start).toFloat()
            
//            ground.position.y = cellSize * 0.5
//            wall.position.y = cellSize * 0.5
//            sha.position.y = cellSize * 0.5
            
            ground.anchorPoint = CGPoint(x: 0.5, y: 0)
            wall.anchorPoint = CGPoint(x: 0.5, y: 1)
            sha.anchorPoint = CGPoint(x: 0.5, y: 1)
//            sha.alpha = 0.85
            
            ground.zPosition = UIStage.LAYER1
            wall.zPosition = UIStage.LAYER1
            sha.zPosition = UIStage.LAYER4
            
            node.addChild(ground)
            node.addChild(wall)
            node.addChild(sha)
            
            
        }
//        addChild(node)
        let t = node.toTexture()
//        node.removeFromParent()
        _ground.anchorPoint = CGPoint(x: 0, y: 0.5)
        _ground.position.x = -cellSize * 0.5
        _ground.texture = t
        if 3 == size {
            _ground.position.y = cellSize * 0.5
        }
        _ground.size = t.size()
        _ground.zPosition = UIStage.LAYER1
        addChild(_ground)
        
        
//        let gate = Gate()
//        gate.position.x = cellSize * 2
//        gate.position.y = cellSize * 2
//        addItem(x: 4, item: gate)
        
//        createItems(start: start, end: _end)
//        let tt = SmallHouse()
//        tt.position.x = -cellSize * 0.5 + cellSize * 2
//        tt.position.y = cellSize * 2
//        tt.zPosition = UIStage.LAYER2
//        _ground.addChild(tt)
    }
    
    func clean() {
        _ground.removeAllChildren()
        removeAllChildren()
        
    }
//    private var _itemlist = Dictionary<String, UIItem>()
    
    internal func getEvil(id:Int = -1) -> UIEvil {
        return UIEvil()
    }
    var evilIn = Array<Int>()
    var eventIn = Array<Int>()
    
    internal func createEvils() {
        let evilsCount = seed(min: 1, max: (xSize * 0.1).toInt())
        for _ in 0...evilsCount - 1 {
            let xPos = seed(min: 3, max:xSize.toInt() - 3)
            createEvil(xPos: xPos)
        }
    }
    
    internal func createEvil(xPos:Int) {
        let evil = getEvil()
        evil.position.x = xPos.toFloat() * cellSize + cellSize * 0.5
        evil.zPosition = UIStage.LAYER3
        evil.position.y = cellSize * 0.75
        evil.name = "evil\(xPos)";
        //            print(evil.name)
        _ground.addChild(evil)
        evilIn.append(xPos)
    }
    
    func getGate() -> UIItem {
//        if hasNextScene() && !hasNextGate {
//            hasNextGate = true
//            return Gate()
//
//        } else {
//        }
        return UIItem()
    }
    
    func getUIEvil(id:Int = -1) -> UIEvil {
        let evil = getEvil(id:id)
        //            evil._xSize = 1
        //            evil._ySize = 1
        evil._charNode.anchorPoint = CGPoint(x: 0, y: 0.5)
        evil._sha.anchorPoint = CGPoint(x: 0, y: 0.5)
        evil.faceSouth()
        
        return evil
    }
    
    func addItem(x:CGFloat, line:CGFloat = -1, item:UIItem, z:CGFloat = 0) {
        item.position.x = x * cellSize + item.size.width * 0.5
        item.position.y = item._ySize.toFloat() * cellSize + cellSize * 0.5
        item.anchorPoint = CGPoint(x: 0.5, y: 1)
        if -1 != line {
            var plus = cellSize * 0.5
            if _groundSize == 2 {
                plus = 0
            }
            item.position.y = line * cellSize - plus
        }
        if z > 0 {
            item.zPosition = z
        } else {
            item.zPosition = UIStage.LAYER2
        }
        item.name = "item\(x.toInt())\(line.toInt())"
        _ground.addChild(item)
        
    }
    
    func getItemByName(name:String) -> UIItem {
        return _ground.childNode(withName: name) as! UIItem
    }
    
    func addSingleCellItem(x:CGFloat, line:CGFloat = 2, texture:SKTexture, y:CGFloat = 0, z:CGFloat = 0) {
        let item = SKSpriteNode(texture: texture)
        item.position.x = x * cellSize + item.size.width * 0.5
        var plus = cellSize * 0.5
        if _groundSize == 2 {
            plus = 0
        }
        item.position.y = line * cellSize - plus
        if 0 != y {
            item.position.y = y
        }
        item.anchorPoint = CGPoint(x: 0.5, y: 1)
        if z > 0 {
            item.zPosition = z
        } else {
            item.zPosition = UIStage.LAYER2
        }
        _ground.addChild(item)
    }
    
    func setItem(x:CGFloat, line:CGFloat = 2, texture:SKTexture, y:CGFloat = 0, z:CGFloat = 0) -> SKSpriteNode {
        let item = SKSpriteNode(texture: texture)
        item.position.x = x * cellSize + item.size.width * 0.5
        item.position.y = line * cellSize - cellSize * 0.5
        if 0 != y {
            item.position.y = y
        }
        item.anchorPoint = CGPoint(x: 0.5, y: 1)
        if z > 0 {
            item.zPosition = z
        } else {
            item.zPosition = UIStage.LAYER2
        }
        _ground.addChild(item)
        
        return item
    }
    
    func meetEvils(firstEvil:Int) -> Array<Creature> {
        var evils = Array<Creature>();
        let max = seed(min: 1, max:4)
        let anotherEvil = seed(max:4)
        let evilIds = [firstEvil, anotherEvil]
        for _ in 0...max - 1 {
            let evil = getEvilById(evilIds[seed(max:2)])
            var level = _level - 2 + seed(max: 4)
            if level < 1 {
                level = 1
            }
            evil.create(level: level.toFloat())
            evils.append(evil)
        }
        
        return evils
    }
    
    internal func getItem() -> UIItem {
        return UIItem()
    }
    
    internal func removeEvent(x:Int) {
        let index = eventIn.index(of: x)
        if index != nil {
            eventIn.remove(at: index!)
        }
    }
    
    func create() {
        hasInitialized = true
//        addChild(_items)
    }
    
    func createNextScenePortal() {
        let pn = PortalNext()
        pn.name = "item\(xSize - 1)"
        addItem(x: xSize - 1, item: pn)
        pn.position.y = cellSize + 6
    }
    
    func createPrevScenePortal() {
        let pn = PortalPrev()
        pn.name = "item0"
        addItem(x: 0, item: pn)
        pn.position.y = cellSize + 6
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        zPosition = UIStage.LAYER2
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getEvilById(_ id: Int) -> Creature {
        return Creature()
    }
    
    var curX:Int {
        set {
            _curX = newValue
        }
        get {
            return _curX
        }
    }
    
    func createXSzie() {
        xSize = seed(min: 20, max: 35).toFloat()
    }
    
    func getCurX() -> CGFloat {
        return round(abs(position.x)) / cellSize
    }
    
    func firstCellEvent() {
        
    }
    var hasNextGate = false
    internal func hasNextScene() -> Bool {
        let stage = Data.instance.stage!

        for scn in stage._scenes {
            if scn.hasNextGate {
                return false
            }
        }
        return true
    }
    func lastCellEvent() {
        
    }
    func triggerEvent(pos:Int) {
        
    }
    func stopedPointEvent(pos:Int) {
        
    }
    func getItemByX(x:Int) -> UIItem {
        let item = _ground.childNode(withName: "item\(x)")
        if nil == item {
            return UIItem()
        }
        
        return item as! UIItem
    }
    var _towerlist = [0,1,2,3,4,5,6,7,8,9,10]
    func getTowerById(id:Int) -> Tower {
        switch id {
        case 0:
            return FireEnergeTower()
        case 1:
            return WaterEnergeTower()
        case 2:
            return ThunderEnergeTower()
        case 3:
            return TimeReduceTower()
        case 4:
            return PhysicalPowerTower()
        case 5:
            return MagicalPowerTower()
        case 6:
            return AttackPowerTower()
        case 7:
            return MindPowerTower()
        case 8:
            return DefencePowerTower()
        case 9:
            return LuckyPowerTower()
        case 10:
            return SpeedPowerTower()
        default:
            return AttackPowerTower()
        }
    }
    func getSpecialEventItem() -> UIItem {
        return UIItem()
    }
    func getTower() -> Tower {
        return getTowerById(id: _towerlist.one())
    }
    func setPos(pos:Int) {
        _curX = pos
        position.x = -cellSize * pos.toFloat()
    }
    var xSize:CGFloat = 0
    internal var _groundSets:GroundSets!
    internal var _ground = SKSpriteNode()
    var MIN_X_SIZE = 18;
    var _items = Array<Int>()
    var _name = ""
    var _index = 1
    var _id = 0
    var _status = Array<Status>()
    var _speaking = [
        "今天天气不错，挺风和日丽的。",
        "好想养只吸血鬼啊。",
        "什么时候才能发大财呢？",
        "什么时候才能换把好一点的武器呢？",
        "升级升级再升级。",
        "我今天想挑战下大魔王。",
        "我好像闻到了一股奇怪的味道。",
    ]
//    internal var _items = SKSpriteNode()
}


