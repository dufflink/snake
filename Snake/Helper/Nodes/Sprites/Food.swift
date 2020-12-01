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
        
        let randomIndex = Int.random(in: 0 ..< map.elements.count)
        let mapBox = map.elements[randomIndex]
        
        let box = createBox(x: mapBox.x, y: mapBox.y)
        elements.append(box)
    }
    
    
}
