//
//  GameScene.swift
//  Snake
//
//  Created by Maxim Skorynin on 30.11.2020.
//

import SpriteKit

final class GameScene: SKScene {
    
    var food: Food?
    var superFood: SuperFood?
    
    var wall: WallFrame!
    
    var map: MapNode!
    var snake: Snake!
    
    var scoreLabel: ScoreLabelNode!
    var pauseButton: PauseButton!
    
    var engine: GameEngine!
    var gameProcess: GameProcess!
    
    var progressBar: UIProgressView!
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        engine.update(with: currentTime)
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        engine = GameEngine(mode: .classic, delegate: self)
        gameProcess = GameProcess(delegate: self)
        
        configureScene()
        configureNodes()
        
        configureButton()
        configureScoreLabel()
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        configureProgressBar()
    }
    
    // MARK: - Private Fucntions
    
    private func configureProgressBar() {
        guard let view = view else {
            return
        }
        
        let leftPadding = scoreLabel.frame.minX
        let rightPadding = view.frame.width - pauseButton.frame.maxX
        
        progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftPadding),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -rightPadding)
        ])
        
        progressBar.tintColor = #colorLiteral(red: 0.7330129743, green: 0.8780248761, blue: 0.9025623798, alpha: 1)
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        
        progressBar.progress = 1.0
        progressBar.isHidden = true
        
        view.addSubview(progressBar)
    }
    
    private func configureScene() {
        backgroundColor = #colorLiteral(red: 0.2223047018, green: 0.238258481, blue: 0.2790471315, alpha: 1)

        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        view?.ignoresSiblingOrder = true
    }
    
    private func configureButton() {
        pauseButton = PauseButton()
        
        let dx = (Game.boxSize.width * 1.7)
        let dy = (Game.boxSize.width * 1.6)
        
        let x = frame.width - dx
        let y = frame.height - dy
        
        pauseButton.position = CGPoint(x: x, y: y)
        addChild(pauseButton)
    }
    
    private func configureScoreLabel() {
        let fontSize = pauseButton.frame.height + 24
        scoreLabel = ScoreLabelNode(fontSize: fontSize)
        
        let x = Game.boxSize.width / 1.9
        let y = pauseButton.frame.minY + 8
        
        scoreLabel.position = CGPoint(x: x, y: y)
        addChild(scoreLabel)
    }
    
    private func configureNodes() {
        map = MapNode(scene: self, mode: engine.mode)
        map.addToScene()
        
        if engine.mode == .box {
            wall = WallFrame(map: map, color: #colorLiteral(red: 0.368627451, green: 0.3921568627, blue: 0.4470588235, alpha: 1))
            wall.addToScene()
        }

        snake = Snake(map: map, color: #colorLiteral(red: 0.7215686275, green: 0.9490196078, blue: 0.9019607843, alpha: 1))
        snake.addToScene()
        
        map.snake = snake

        food = Food(map: map, color: #colorLiteral(red: 1, green: 0.6509803922, blue: 0.6196078431, alpha: 1))
        food?.respawn()
        
        superFood = SuperFood(map: map, color: #colorLiteral(red: 0.9818401933, green: 0.954026401, blue: 0.8664388061, alpha: 1))
    }
    
    private func restartGame() {
        scoreLabel.reset()
        food?.respawn()
        
        snake.reset()
        snake.addToScene()
        
        superFood?.remove()
        gameProcess.restart()
    }
    
}

// MARK: - Game Process Delegate

extension GameScene: GameProcessDelegate {
    
    func superFoodTimerDidStart(savedProgress: Float) {
        progressBar.setProgress(savedProgress, animated: false)
        progressBar.isHidden = false
    }
    
    func superFoodTimerDidRemove() {
        progressBar.isHidden = true
        superFood?.remove()
    }
    
    func superFoodTimerValueDidChange(timeLeft: TimeInterval) {
        DispatchQueue.main.async {
            let value = Float(timeLeft / 10)
            self.progressBar.setProgress(value, animated: true)
        }
    }
    
    func scoreDidChange(_ score: Int) {
        scoreLabel.set(score: score)
    }
    
    func needPlaceSuperFood() {
        superFood?.respawn()
    }
    
}

// MARK: - Game Engine Delegate

extension GameScene: GameEngineProtocol {
    
    func gameEngineGameDidUpdate(_ canUpdate: Bool) {
        if canUpdate {
            snake.move()
        }
    }
    
    func gameEnginePauseStateDidChange(_ onPause: Bool) {
        gameProcess.setState(onPause: onPause)
        pauseButton.setState(onPause: onPause)
    }
    
}

// MARK: - SKPhysics Contact Delegate

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        switch contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask {
            case Game.Sprite.snakeHead.bitMask | Game.Sprite.food.bitMask:
                food?.respawn()
                
                gameProcess.foodDidEat()
                snake.addBox()
            case Game.Sprite.snakeHead.bitMask | Game.Sprite.superFood.bitMask:
                gameProcess.superFoodDidEat()
                
                superFood?.remove()
                snake.addBox()
            case Game.Sprite.wall.bitMask | Game.Sprite.snakeHead.bitMask, Game.Sprite.snakeBody.bitMask | Game.Sprite.snakeHead.bitMask:
                restartGame()
            default:
                print("Contacts no use objects")
        }
    }
    
}

// MARK: - Touch Events

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name == "Pause Button" {
                engine.changePauseState()
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
