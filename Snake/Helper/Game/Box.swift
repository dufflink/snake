//
//  Box.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

final class Box: Equatable {
    
    var node: SKSpriteNode
    
    var x: Int
    var y: Int
    
    var prevX: Int?
    var prevY: Int?
    
    init(node: SKSpriteNode, x: Int, y: Int) {
        self.node = node
        
        self.x = x
        self.y = y
    }
    
    static func == (lhs: Box, rhs: Box) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
}
