//
//  GameScene.swift
//  Snake
//
//  Created by Maxim Skorynin on 30.11.2020.
//

import SpriteKit

final class GameScene: SKScene {
    
    var food: Food?
    var wall: WallFrame!
    
    var map: MapNode!
    var snake: Snake!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        initScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        restartGame()
    }
    
    // MARK: - Private Fucntions
    
    private func initScene() {
        map = MapNode(scene: self)
        map.addToScene()
        
        wall = WallFrame(map: map, color: .gray)
        wall.addToScene()

        snake = Snake(map: map, color: .green)
        snake.addToScene()
        
        map.snake = snake

        food = Food(map: map, color: .red)
        resetFood()
    }
    
    private func restartGame() {
        resetFood()
        
        snake.reset()
        snake.addToScene()
    }
    
    private func resetFood() {
        food?.reset()
        food?.addToScene()
    }
    
}
