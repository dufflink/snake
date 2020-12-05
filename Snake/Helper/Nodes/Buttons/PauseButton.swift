//
//  PauseButton.swift
//  Snake
//
//  Created by Maxim Skorynin on 05.12.2020.
//

import SpriteKit

final class PauseButton: ButtonNode {
    
    let pauseTexture = SKTexture(imageNamed: "Pause")
    let startTexture = SKTexture(imageNamed: "Start")
    
    init() {
        super.init(imageName: "Pause")
        name = "Pause Button"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("ButtonNode. Required init did call")
    }
    
    func setState(onPause: Bool) {
        texture = onPause ? startTexture : pauseTexture
    }
    
}
