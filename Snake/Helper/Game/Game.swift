//
//  Game.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

struct Game {
    
    // MARK: - Global Properties
    
    static var boxSize = CGSize(width: boxSide - 1, height: boxSide - 1)
    static var boxSide = 30
    
    static var mapColumns = 12
    
}

// MARK: - Sprite

extension Game {
    
    enum Sprite: String {
        
        case snakeHead
        case snakeBody
        
        case food
        case wall
        
        case none
        
        var bitMask: UInt32 {
            switch self {
                case .snakeHead:
                    return 0x1 << 0
                case .snakeBody:
                    return 0x1 << 1
                case .food:
                    return 0x1 << 2
                case .wall:
                    return 0x1 << 3
                case .none:
                    return 0
            }
        }

    }
    
}
