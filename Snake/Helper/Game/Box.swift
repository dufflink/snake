//
//  Box.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

struct Box: Equatable {
    
    var node: SKSpriteNode
    
    var x: Int
    var y: Int
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
}
