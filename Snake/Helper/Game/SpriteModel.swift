//
//  SpriteType.swift
//  Snake
//
//  Created by Maxim Skorynin on 09.02.2021.
//

enum SpriteModel: String {
    
    case snakeHead
    case snakeBody
    
    case food
    case superFood
    
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
            case .superFood:
                return 0x2 << 3
            case .wall:
                return 0x1 << 4
            case .none:
                return 0
        }
    }

}
