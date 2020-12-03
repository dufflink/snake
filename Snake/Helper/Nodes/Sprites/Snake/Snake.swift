//
//  SnakeNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import GameplayKit

final class Snake: Sprite {
    
    private var defaultLenght = 3
    private var step = Game.boxSide
    
    private var currentMovingDirection: MovingDirection = .right
    private var movingDirections: [MovingDirection] = []
    
    // MARK: - Public Functions
    
    func addBox() {
        if let tail = elements.last {
            let box = createBodyBox(x: tail.x + 1, y: tail.y + 1)
            
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
        var dX = 0
        var dY = 0
        
        if movingDirections.count > 0 {
            currentMovingDirection = movingDirections.removeFirst()
        }
        
        switch currentMovingDirection {
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
        
        for box in elements {
            let action = head ? SKAction.move(by: CGVector(dx: dX, dy: dY), duration: 0) : SKAction.move(to: CGPoint(x: x, y: y), duration: 0)
            
            x = Double(box.node.position.x)
            y = Double(box.node.position.y)
            
            box.x = Int(x)
            box.y = Int(y)
            
            box.node.run(action)
            head = false
        }
    }
    
    func addMovingDirection(_ direction: MovingDirection) {
        if movingDirections.count == 2 {
            return
        }
        
        switch direction {
            case .up, .down:
                if currentMovingDirection == .up || currentMovingDirection == .down {
                    return
                }
            case .left, .right:
                if currentMovingDirection == .left || currentMovingDirection == .right {
                    return
                }
        }
        
        movingDirections += [direction]
    }
    
}

// MARK: - Private Functions

extension Snake {
    
    private func createHeadBox(x: Int, y: Int) -> Box {
        let box = createBox(x: x, y: y)
        
        box.node.physicsBody = SKPhysicsBody(rectangleOf: box.node.size)
        box.node.physicsBody?.isDynamic = false
        
        let sprite: Game.Sprite = .snakeHead
        
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
