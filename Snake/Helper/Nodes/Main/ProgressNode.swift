//
//  ProgressNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 16.12.2020.
//

import SpriteKit

final class ProgressNode: SKCropNode {
    
    override init() {
        super.init()
        
        maskNode = SKSpriteNode(color: .white, size: CGSize(width: 400, height: 50))
        
        let sprite = SKSpriteNode(imageNamed: "Pause")
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setProgress(progress: CGFloat) {
        maskNode?.xScale = progress
    }
    
}
