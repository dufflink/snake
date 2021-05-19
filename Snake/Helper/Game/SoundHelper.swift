//
//  SoundHelper.swift
//  Snake
//
//  Created by Maxim Skorynin on 19.05.2021.
//

import SpriteKit

final class SoundHelper {
    
    private let node: SKNode
    
    let foodSound = SKAction.playSoundFileNamed(Sound.food.sourceName, waitForCompletion: false)
    let superFoodSound = SKAction.playSoundFileNamed(Sound.superFood.sourceName, waitForCompletion: false)
    
    // MARK: - Life Cycle
    
    init(node: SKNode) {
        self.node = node
    }
    
    // MARK: - Public Functions
    
    func playFoodSound() {
        node.run(foodSound)
    }
    
    func playSuperFoodSound() {
        node.run(superFoodSound)
    }
    
}
