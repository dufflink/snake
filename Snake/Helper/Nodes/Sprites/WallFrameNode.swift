//
//  WallFrameNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

final class WallFrameNode: GameNode {
    
    var color: UIColor = .gray
    
    var elements: [Box] = []
    
    unowned var scene: SKScene
    
    // MARK: - Life Cycle
    
    required init(scene: SKScene) {
        self.scene = scene
        reset()
    }
    
    func reset() {
        clear()
        
        let sceneWidth = scene.width
        let sceneHeight = scene.height
        
        let dx = Game.boxSide / 2
        let dy = dx
        
        createHorisontalWall(y: 0, minX: dx, maxX: sceneWidth)
        createHorisontalWall(y: sceneHeight, minX: dx, maxX: sceneWidth)
        
        createVerticalWall(x: 0, minY: dy, maxY: sceneHeight)
        createVerticalWall(x: sceneWidth, minY: dy, maxY: sceneHeight)
    }
    
    // MARK: - Private Functions
    
    private func createHorisontalWall(y: Int, minX: Int, maxX: Int) {
        for i in stride(from: minX, to: maxX, by: Game.boxSide) {
            let box = createBox(x: i, y: y)
            elements.append(box)
        }
    }
    
    private func createVerticalWall(x: Int, minY: Int, maxY: Int) {
        for i in stride(from: minY, to: maxY, by: Game.boxSide) {
            let box = createBox(x: x, y: i)
            elements.append(box)
        }
    }
    
}
