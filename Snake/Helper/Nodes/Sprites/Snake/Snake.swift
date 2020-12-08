//
//  SnakeNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import GameplayKit

final class Snake: Sprite {
    
    private let queue = OperationQueue()
    
    override var texture: SKTexture? {
        return nil
    }
    
    private var defaultLenght = 3
    private var step = Game.boxSide
    
    private var currentMovingDirection: MovingDirection = .right
    private var movingDirections: [MovingDirection] = []
    
    // MARK: - Life Cycle
    
    required init(map: MapNode, color: UIColor) {
        super.init(map: map, color: color)
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .background
    }
    
    // MARK: - Public Functions
    
    func addBox() {
        if let tail = elements.last {
            let box = createBodyBox(x: tail.x, y: tail.y)
            
            scene.addChild(box.node)
            elements.append(box)
        }
    }
    
    override func reset() {
        super.reset()
        var index = map.midIndex
        currentMovingDirection = .right
        
        for i in 0 ..< defaultLenght {
            index -= 1
            
            let mapBox = map.elements[index]
            var box: Box
            
            if i == 0 {
                box = createHeadBox(x: mapBox.x, y: mapBox.y)
            } else {
                box = createBodyBox(x: mapBox.x, y: mapBox.y)
            }
            
            elements.append(box)
        }
    }
    
    override func move() {
        queue.addOperation { [weak self] in
            guard let self = self else {
                return
            }
            
            var dX = 0
            var dY = 0
            
            let step = self.step
            
            if self.movingDirections.count > 0 {
                self.currentMovingDirection = self.movingDirections.removeFirst()
            }
            
            let direction = self.currentMovingDirection
            
            switch direction {
                case .up:
                    dX = 0
                    dY = step
                case .down:
                    dX = 0
                    dY = -step
                case .left:
                    dX = -step
                    dY = 0
                case .right:
                    dX = step
                    dY = 0
            }
            
            var x = 0.0
            var y = 0.0
            
            var head = true
            
            for box in self.elements {
                var action: SKAction
                
                let posX = Int(box.node.position.x)
                let posY = Int(box.node.position.y)
                
                if head {
                    var headX = 0
                    var headY = 0
                    
                    var isOppositeSide = true
                    let map = self.map
                    
                    // TODO: змейка уходит за экран
                    if posX > map.maxX - dX && direction == .right {
                        headX = map.minX
                        headY = box.y
                    } else if posX <= map.minX && direction == .left {
                        headX = map.maxX
                        headY = box.y
                    } else if posY <= map.minY && direction == .down {
                        headX = box.x
                        headY = map.maxY
                        // TODO: змейка уходит за экран
                    } else if posY > map.maxY - dY && direction == .up {
                        headX = box.x
                        headY = map.minY
                    } else {
                        isOppositeSide = false
                    }
                    
                    if isOppositeSide {
                        action = SKAction.move(to: CGPoint(x: headX, y: headY), duration: 0)
                    } else {
                        action = SKAction.move(by: CGVector(dx: dX, dy: dY), duration: 0)
                    }
                } else {
                    action = SKAction.move(to: CGPoint(x: x, y: y), duration: 0)
                }
                
                x = Double(box.node.position.x)
                y = Double(box.node.position.y)
                
                box.x = Int(x)
                box.y = Int(y)
                                
                head = false
                
                DispatchQueue.main.async {
                    box.node.run(action)
                }
            }
        }
    }
    
    func addMovingDirection(_ direction: MovingDirection) {
        queue.addOperation { [weak self] in
            guard let self = self else {
                return
            }
            
            func validateDirection(fd: MovingDirection, sd: MovingDirection) -> Bool {
                switch fd {
                    case .up, .down:
                        if sd == .up || sd == .down {
                            return false
                        }
                    case .left, .right:
                        if sd == .left || sd == .right {
                            return false
                        }
                }
                
                return true
            }
            
            var canAddNewDirection: Bool = true
            
            if self.movingDirections.count == 0 {
                canAddNewDirection = validateDirection(fd: direction, sd: self.currentMovingDirection)
            } else if self.movingDirections.count == 1, let sd = self.movingDirections.first {
                canAddNewDirection = validateDirection(fd: direction, sd: sd)
            } else {
                return
            }
            
            if canAddNewDirection {
                self.movingDirections += [direction]
            }
        }
    }
    
}

// MARK: - Private Functions

extension Snake {
    
    private func createHeadBox(x: Int, y: Int) -> Box {
        let box = createBox(x: x, y: y)
        
        box.node.physicsBody = SKPhysicsBody(rectangleOf: box.node.size)
        box.node.physicsBody?.isDynamic = false
        
        let sprite: Game.Sprite = .snakeHead
        
        box.node.zPosition = 1.0
        box.node.name = sprite.rawValue
        
        box.node.physicsBody?.categoryBitMask = sprite.bitMask
        box.node.physicsBody?.collisionBitMask = Game.Sprite.snakeBody.bitMask
        
        let contacts = Game.Sprite.food.bitMask | Game.Sprite.wall.bitMask | Game.Sprite.snakeBody.bitMask
        box.node.physicsBody?.contactTestBitMask = contacts
        
        return box
    }

    private func createBodyBox(x: Int, y: Int) -> Box {
        let box = createBox(x: x, y: y)
        
        box.node.physicsBody = SKPhysicsBody(rectangleOf: box.node.size)
        box.node.physicsBody?.collisionBitMask = Game.Sprite.snakeHead.bitMask
        
        let sprite: Game.Sprite = .snakeBody
        
        box.node.name = sprite.rawValue
        box.node.physicsBody?.categoryBitMask = sprite.bitMask
        
        return box
    }
    
}
