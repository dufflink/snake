//
//  Food.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

final class Food: Sprite {
    
    override func reset() {
        super.reset()
        let clearBoxes = map.clearBoxes
        let randomIndex = Int.random(in: 0 ..< map.clearBoxes.count)
        
        let mapBox = clearBoxes[randomIndex]
        let box = createBox(x: mapBox.x, y: mapBox.y)
        
        let sprite = Game.Sprite.food
        box.node.name = sprite.rawValue
        
        box.node.physicsBody = SKPhysicsBody(rectangleOf: box.node.size)
        box.node.physicsBody?.allowsRotation = false
        
        box.node.physicsBody?.pinned = true
        box.node.physicsBody?.categoryBitMask = sprite.bitMask
        
        elements.append(box)
    }
    
}
