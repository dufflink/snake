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
    
    var score: ScoreLabelNode!
    var engine: GameEngine!
    
    var pauseButton: PauseButton!
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        engine.update(with: currentTime)
        
        if engine.canUpdate {
            snake.move()
        }
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        engine = GameEngine(mode: .classic)
        
        configureScene()
        configureNodes()
        
        configureButton()
        configureScoreLabel()
    }
    
    // MARK: - Private Fucntions
    
    private func configureScene() {
        backgroundColor = #colorLiteral(red: 0.2223047018, green: 0.238258481, blue: 0.2790471315, alpha: 1)

        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        view?.ignoresSiblingOrder = true
    }
    
    private func configureButton() {
        pauseButton = PauseButton()
        
        let dx = (Game.boxSize.width * 1.7)
        let dy = (Game.boxSize.width * 1.5)
        
        let x = frame.width - dx
        let y = frame.height - dy
        
        pauseButton.position = CGPoint(x: x, y: y)
        addChild(pauseButton)
    }
    
    private func configureScoreLabel() {
        score = ScoreLabelNode()
        
        let x = Game.boxSize.width / 1.9
        let y = frame.height - (Game.boxSize.height * 1.9)
        
        score.position = CGPoint(x: x, y: y)
        addChild(score)
    }
    
    private func configureNodes() {
        map = MapNode(scene: self)
        map.addToScene()
        
        if engine.mode == .box {
            wall = WallFrame(map: map, color: #colorLiteral(red: 0.368627451, green: 0.3921568627, blue: 0.4470588235, alpha: 1))
            wall.addToScene()
        }

        snake = Snake(map: map, color: #colorLiteral(red: 0.7215686275, green: 0.9490196078, blue: 0.9019607843, alpha: 1))
        snake.addToScene()
        
        map.snake = snake

        food = Food(map: map, color: #colorLiteral(red: 1, green: 0.6509803922, blue: 0.6196078431, alpha: 1))
        resetFood()
    }
    
    private func restartGame() {
        score.reset()
        resetFood()
        
        snake.reset()
        snake.addToScene()
    }
    
    private func resetFood() {
        food?.reset()
        food?.addToScene()
    }
    
}

// MARK: - SKPhysics Contact Delegate

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        switch contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask {
            case Game.Sprite.snakeHead.bitMask | Game.Sprite.food.bitMask:
                resetFood()
                
                score.increment()
                snake.addBox()
            case Game.Sprite.wall.bitMask | Game.Sprite.snakeHead.bitMask, Game.Sprite.snakeBody.bitMask | Game.Sprite.snakeHead.bitMask:
                restartGame()
            default:
                print("Contacts nouse objects")
        }
    }
    
}

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "Pause Button" {
                engine.changePauseState()
                pauseButton.setState(onPause: engine.onPause)
            }
         }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else {
            return
        }
        
        let newLocation = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        
        let dx = newLocation.x - previousLocation.x
        let dy = newLocation.y - previousLocation.y
        
        if let newDirection = Snake.MovingDirection(dx: dx, dy: dy) {
            self.snake.addMovingDirection(newDirection)
        }
    }
    
}
