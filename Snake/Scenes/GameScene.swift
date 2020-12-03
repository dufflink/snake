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
        backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2, blue: 0.2196078431, alpha: 1)

        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        view?.ignoresSiblingOrder = true
        
        map = MapNode(scene: self)
        map.addToScene()
        
        wall = WallFrame(map: map, color: #colorLiteral(red: 0.368627451, green: 0.3921568627, blue: 0.4470588235, alpha: 1))
        wall.addToScene()

        snake = Snake(map: map, color: #colorLiteral(red: 0.7215686275, green: 0.9490196078, blue: 0.9019607843, alpha: 1))
        snake.addToScene()
        
        map.snake = snake

        food = Food(map: map, color: #colorLiteral(red: 1, green: 0.6509803922, blue: 0.6196078431, alpha: 1))
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
        DispatchQueue.global(qos: .background).async {
            let newDirection = Snake.MovingDirection(swipeDirection: swipeGesture.direction)
            self.snake.addMovingDirection(newDirection)
        }
    }
    
}

// MARK: - SKPhysics Contact Delegate

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        switch contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask {
            case Game.Sprite.snakeHead.bitMask | Game.Sprite.food.bitMask:
                DispatchQueue.main.async {
                    self.resetFood()
                }
                
                snake.addBox()
            case Game.Sprite.wall.bitMask | Game.Sprite.snakeHead.bitMask, Game.Sprite.snakeBody.bitMask | Game.Sprite.snakeHead.bitMask:
                restartGame()
            default:
                print("Contacts nouse objects")
        }
    }
    
}
