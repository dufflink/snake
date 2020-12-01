//
//  MapNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

final class MapNode: GameNode {
    
    unowned var scene: SKScene
    
    var elements: [Box] = []
    var color: UIColor = .darkGray
    
    init(scene: SKScene) {
        self.scene = scene
        reset()
    }
    
    func reset() {
        let sceneWidth = scene.width
        let sceneHeight = scene.height
        
        let boxSide = Game.boxSide
        let delta = boxSide + (boxSide / 2)
        
        for y in stride(from: delta, to: sceneHeight - boxSide, by: boxSide) {
            for x in stride(from: delta, to: sceneWidth - boxSide, by: boxSide) {
                let box = createBox(x: x, y: y)
                elements.append(box)
            }
        }
    }
    
}

