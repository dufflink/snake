//
//  SpriteNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

protocol SpriteNode: GameNode {
    
    init(map: MapNode, color: UIColor)
    
    var map: MapNode { get }
    
    func move()
    
}

class Sprite: SpriteNode {
    
    unowned var scene: SKScene
    var map: MapNode
    
    var elements: [Box] = []
    var color: UIColor = .cyan
    
    // MARK: - Life Cycle
    
    required init(map: MapNode, color: UIColor) {
        self.scene = map.scene
        self.map = map
        
        self.color = color
        reset()
    }
    
    // MARK: - Public Functions
    
    func move() { }
    
    func reset() {
        clear()
    }
    
}
