//
//  WallFrame.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

final class WallFrame: Sprite {
    
    override var texture: SKTexture? {
        return nil
    }
    
    override func reset() {
        super.reset()
        for mapBox in map.edgeBoxes {
            let box = createBox(x: mapBox.x, y: mapBox.y)
            let sprite = Game.Sprite.wall
            
            box.node.name = sprite.rawValue
            
            box.node.physicsBody = SKPhysicsBody(rectangleOf: box.node.size)
            box.node.physicsBody?.allowsRotation = false
            
            box.node.physicsBody?.pinned = true
            box.node.physicsBody?.categoryBitMask = sprite.bitMask
            
            elements.append(box)
        }
    }
    
}
