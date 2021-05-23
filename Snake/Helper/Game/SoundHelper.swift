//
//  SoundHelper.swift
//  Snake
//
//  Created by Maxim Skorynin on 19.05.2021.
//

import SpriteKit

final class SoundHelper {
    
    static let shared = SoundHelper()
    
    private var node: SKNode?
    var isOnSound: Bool = true
    
    let foodSound = SKAction.playSoundFileNamed(Sound.food.sourceName, waitForCompletion: false)
    let superFoodSound = SKAction.playSoundFileNamed(Sound.superFood.sourceName, waitForCompletion: true)
    
    // MARK: - Life Cycle
    
    private init() { }
    
    // MARK: - Public Functions
    
    func setSoundState(_ isOnSound: Bool) {
        self.isOnSound = isOnSound
    }
    
    func setNode(_ node: SKNode) {
        self.node = node
    }
    
    func playFoodSound() {
        if isOnSound {
            node?.run(foodSound)
        }
    }
    
    func playSuperFoodSound() {
        if isOnSound {
            node?.run(superFoodSound)
        }
    }
    
    func changeSoundState() {
        isOnSound.toggle()
    }
    
}
