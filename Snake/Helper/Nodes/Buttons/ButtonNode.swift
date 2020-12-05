//
//  ButtonNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 04.12.2020.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
    
    init(imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        let size = CGSize(width: 48, height: 48)
        
        super.init(texture: texture, color: .white, size: size)
        zPosition = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("ButtonNode. Required init did call")
    }
    
}
