//
//  SnakeNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import GameplayKit

extension Snake {
    
    enum MovingDirection {
        
        case up
        case down
        
        case left
        case right
        
        init(swipeDirection: UISwipeGestureRecognizer.Direction) {
            switch swipeDirection {
                case .up:
                    self = .up
                case .down:
                    self = .down
                case .left:
                    self = .left
                case .right:
                    self = .right
                default:
                    self = .up
            }
        }
        
    }
    
}

final class Snake: Sprite {
    
    private var defaultLenght = 3
    private var step = GameOptions.boxSide
    
    private var currentMovingDirection: MovingDirection = .right
    private var movingDirections: [MovingDirection] = []
    
    override func reset() {
        super.reset()
        var index = map.midIndex
        
        for _ in 0 ..< defaultLenght {
            index -= 1

            let mapBox = map.elements[index]
            let box = createBox(x: mapBox.x, y: mapBox.y)
            
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
