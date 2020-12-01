//
//  GameScene.swift
//  Snake
//
//  Created by Maxim Skorynin on 30.11.2020.
//

import SpriteKit

final class GameScene: SKScene {
    
    var food: Food?
    
    override func sceneDidLoad() {
        configureScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetFood()
    }
    
    // MARK: - Private Fucntions
    
    private func configureScene() {
        let map = MapNode(scene: self)
        map.addToScene()
        
//        let wall = WallFrameNode(scene: self)
//        wall.addToScene()
//
        let snake = Snake(map: map, color: .green)
        snake.addToScene()

        food = Food(map: map, color: .red)
        resetFood()
    }
    
    private func resetFood() {
        food?.reset()
        food?.addToScene()
    }
    
}
