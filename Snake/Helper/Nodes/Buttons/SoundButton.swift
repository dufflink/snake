//
//  SoundButton.swift
//  Snake
//
//  Created by Maxim Skorynin on 20.05.2021.
//

import SpriteKit

final class SoundButton: ButtonNode {
    
    let soundOnTexture = SKTexture(imageNamed: "Sound On")
    let soundOffTexture = SKTexture(imageNamed: "Sound Off")
    
    init(soundIsEnabled: Bool) {
        let imageName = soundIsEnabled ? "Sound On" : "Sound Off"
        super.init(imageName: imageName)
        
        name = Name.sound.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("ButtonNode. Required init did call")
    }
    
    func setSoundState(isEnabled: Bool) {
        texture = isEnabled ? soundOnTexture : soundOffTexture
    }
    
}
