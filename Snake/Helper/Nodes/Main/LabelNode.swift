//
//  LabelNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 04.12.2020.
//

import SpriteKit

final class ScoreLabelNode: SKLabelNode {
    
    // MARK: - Life Cycle
    
    convenience init(fontSize: CGFloat) {
        self.init()
        
        self.fontSize = fontSize
        reset()
    }
    
    override init() {
        super.init()
        fontName = "anotherCastle3"
        fontSize = Game.boxSize.height * 2
        
        horizontalAlignmentMode = .left
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Functions
    
    func set(score: Int) {
        text = "\(score)"
    }
    
    func reset() {
        set(score: 0)
    }
    
}
