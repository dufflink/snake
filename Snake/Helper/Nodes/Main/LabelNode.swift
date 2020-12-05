//
//  LabelNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 04.12.2020.
//

import SpriteKit

final class ScoreLabelNode: SKLabelNode {
    
    private var score: Int = 0
    
    // MARK: - Life Cycle
    
    override init() {
        super.init()
        fontName = "anotherCastle3"
        fontSize = CGFloat(Game.boxSide)
        
        horizontalAlignmentMode = .left
        setScore()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Functions
    
    func increment() {
        score += 1
        setScore()
    }
    
    func reset() {
        score = 0
        setScore()
    }
    
    // MARK: - Private Functions
    
    private func setScore() {
        text = "Score: \(score)  "
    }
    
}
