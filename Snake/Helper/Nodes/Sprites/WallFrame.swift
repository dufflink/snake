//
//  WallFrame.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

final class WallFrame: Sprite {
    
    override func reset() {
        super.reset()
        for mapBox in map.edgeBoxes {
            let box = createBox(x: mapBox.x, y: mapBox.y)
            elements.append(box)
        }
    }
    
}
