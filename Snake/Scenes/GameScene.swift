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
    
    var engine = GameEngine()
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        engine.update(with: currentTime)
        
        if engine.canUpdate {
            snake.move()
        }
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        initScene()
    }
    
    override func didMove(to view: SKView) {
        addSwipeGestures(view: view)
    }
    
    // MARK: - Private Fucntions
    
    private func initScene() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
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
    
    private func addSwipeGestures(view: SKView) {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down, .right, .left]
        
        for direction in directions {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(changeSnakeMovingDirection(swipeGesture:)))
            swipe.direction = direction
            view.addGestureRecognizer(swipe)
        }
    }
    
    @objc
    private func changeSnakeMovingDirection(swipeGesture: UISwipeGestureRecognizer) {
        let newDirection = Snake.MovingDirection(swipeDirection: swipeGesture.direction)
        snake.addMovingDirection(newDirection)
    }
    
}

// MARK: - SKPhysics Contact Delegate

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        switch contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask {
            case Game.Sprite.snakeHead.bitMask | Game.Sprite.food.bitMask:
                resetFood()
                snake.addBox()
            case Game.Sprite.wall.bitMask | Game.Sprite.snakeHead.bitMask, Game.Sprite.snakeBody.bitMask | Game.Sprite.snakeHead.bitMask:
                restartGame()
            default:
                print("Contacts nouse objects")
        }
    }
    
}
