//
//  Food.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

class Food: Sprite {
    
    override var model: SpriteModel{
        return .food
    }
    
    override var bodySize: CGSize {
        let side = Constants.boxSide / 2
        return CGSize(width: side, height: side)
    }
    
    override func reset() {
        super.reset()
        
        let clearBoxes = map.clearBoxes
        let randomIndex = Int.random(in: 0 ..< clearBoxes.count)
        
        let mapBox = clearBoxes[randomIndex]
        let box = createBox(x: mapBox.x, y: mapBox.y)
        
        box.node.name = model.rawValue
        
        box.node.physicsBody = SKPhysicsBody(rectangleOf: box.node.size)
        box.node.physicsBody?.allowsRotation = false
        
        box.node.physicsBody?.pinned = true
        box.node.physicsBody?.categoryBitMask = model.bitMask
        
        box.node.zPosition = 0.0
        elements.append(box)
    }
    
}
