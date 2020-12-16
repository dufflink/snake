//
//  LabelNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 04.12.2020.
//

import SpriteKit

final class ScoreLabelNode: SKLabelNode {
    
    // MARK: - Life Cycle
    
    override init() {
        super.init()
        fontName = "anotherCastle3"
        fontSize = Game.boxSize.height * 1.6
        
        horizontalAlignmentMode = .left
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Functions
    
    func set(score: Int) {
        text = "Score: \(score)"
    }
    
    func reset() {
        set(score: 0)
    }
    
}
