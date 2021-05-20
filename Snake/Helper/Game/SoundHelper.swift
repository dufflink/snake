//
//  SoundHelper.swift
//  Snake
//
//  Created by Maxim Skorynin on 19.05.2021.
//

import SpriteKit

final class SoundHelper {
    
    private let node: SKNode
    var isOnSound: Bool = true
    
    let foodSound = SKAction.playSoundFileNamed(Sound.food.sourceName, waitForCompletion: false)
    let superFoodSound = SKAction.playSoundFileNamed(Sound.superFood.sourceName, waitForCompletion: true)
    
    // MARK: - Life Cycle
    
    init(node: SKNode, soundState: Bool) {
        self.node = node
        self.isOnSound = soundState
    }
    
    // MARK: - Public Functions
    
    func playFoodSound() {
        if isOnSound {
            node.run(foodSound)
        }
    }
    
    func playSuperFoodSound() {
        if isOnSound {
            node.run(superFoodSound)
        }
    }
    
    func changeSoundState() {
        isOnSound.toggle()
    }
    
}
