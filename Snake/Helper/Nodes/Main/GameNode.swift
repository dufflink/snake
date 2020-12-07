//
//  GameNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

protocol GameNode: class {
    
    var scene: SKScene { get }
    
    var elements: [Box] { get set }
    
    var color: UIColor { get }
    
    var texture: SKTexture? { get }
    
    init(scene: SKScene)
    
    func createBox(x: Int, y: Int, color: UIColor?) -> Box
    
    func addToScene()
    
    func reset()
    
}

extension GameNode {
    
    func createBox(x: Int, y: Int, color: UIColor? = nil) -> Box {
        let node = SKSpriteNode(color: color ?? self.color, size: Game.boxSize)
        node.position = CGPoint(x: x, y: y)
        
        if let texture = texture {
            node.texture = texture
        }
        
        node.colorBlendFactor = 1.0
        
        let box = Box(node: node, x: x, y: y)
        
        return box
    }
    
    func addToScene() {
        elements.forEach { [weak self] in
            self?.scene.addChild($0.node)
        }
    }
    
    func clear() {
        elements.forEach { $0.node.removeFromParent() }
        elements.removeAll()
    }
    
    init(scene: SKScene) {
        self.init(scene: scene)
        reset()
    }
    
}
