//
//  GameScene.swift
//  Snake
//
//  Created by Maxim Skorynin on 30.11.2020.
//

import Haptico
import SpriteKit

protocol GameSceneDelegate: AnyObject {
    
    func gameDidFinish(score: Int)
    
    func gameDidPause(score: Int)
    
    func gameDidResume()
    
}

final class GameScene: SKScene {
    
    private var food: Food?
    private var superFood: SuperFood?
    
    private var wall: WallFrame!
    
    private var map: MapNode!
    private var snake: Snake!
    
    private var scoreLabel: ScoreLabelNode!
    private var pauseButton: PauseButton!
    private var soundButton: SoundButton!
    
    private var engine: GameEngine!
    private var gameProcess: GameProcess!
    
    private var progressBar: UIProgressView!
    
    weak var specificDelegate: GameSceneDelegate?

    // MARK: - Life Cycle
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        engine.update(with: currentTime)
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        engine = GameEngine(delegate: self)
        gameProcess = GameProcess(node: self, delegate: self)
        
        configureScene()
        configureNodes()
        
        configureActionButtons()
        configureScoreLabel()
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        configureProgressBar()
    }
    
    // MARK: - Public Functions
    
    func restartGame() {
        scoreLabel.reset()
        food?.respawn()
        
        snake.reset()
        snake.addToScene()
        
        superFood?.remove()
        gameProcess.restart()
    }
    
    func resumeGame() {
        gameProcess.setState(onPause: false)
        engine.setPauseState(false)
        
        specificDelegate?.gameDidResume()
    }
    
    func setInterfaceHiddenState(_ isHidden: Bool) {
        let alpha: CGFloat = isHidden ? 0 : 1
        
        UIView.animate(withDuration: 0.25) {
            self.pauseButton.alpha = alpha
            self.scoreLabel.alpha = alpha
            self.soundButton.alpha = alpha
        }
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
        
        progressBar.tintColor = Design.Color.blue.value
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
        
        progressBar.progress = 1.0
        progressBar.isHidden = true
        
        view.addSubview(progressBar)
    }
    
    private func configureScene() {
        backgroundColor = Design.Color.background.value

        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        view?.ignoresSiblingOrder = true
    }
    
    private func configureActionButtons() {
        pauseButton = PauseButton()
        
        let dx = (Constants.boxSize.width * 1.7)
        let dy = (Constants.boxSize.width * 1.6)
        
        let x = frame.width - dx
        let y = frame.height - dy
        
        pauseButton.position = CGPoint(x: x, y: y)
        addChild(pauseButton)
        
        soundButton = SoundButton(soundIsEnabled: true)
        
        let x1 = pauseButton.position.x - soundButton.frame.width - 8
        let y1 = pauseButton.position.y
        
        soundButton.position = CGPoint(x: x1, y: y1)
        addChild(soundButton)
    }
    
    private func configureScoreLabel() {
        let fontSize = pauseButton.frame.height + 10
        scoreLabel = ScoreLabelNode(fontSize: fontSize)
        
        let x = Constants.boxSize.width / 1.9
        let y = pauseButton.frame.minY + 8
        
        scoreLabel.position = CGPoint(x: x, y: y)
        addChild(scoreLabel)
    }
    
    private func configureNodes() {
        map = MapNode(scene: self, mode: engine.mode)
        map.addToScene()
        
        if engine.mode == .box {
            wall = WallFrame(map: map, color: Design.Color.lightGray.value)
            wall.addToScene()
        }

        snake = Snake(map: map, color: Design.Color.green.value)
        snake.addToScene()
        
        map.snake = snake

        food = Food(map: map, color: Design.Color.red.value)
        food?.respawn()
        
        superFood = SuperFood(map: map, color: Design.Color.yellow.value)
    }

    private func pauseGame() {
        setInterfaceHiddenState(true)
        
        gameProcess.setState(onPause: true)
        engine.setPauseState(true)
        
        let score = gameProcess.score
        specificDelegate?.gameDidPause(score: score)
    }
    
    private func finishGame() {
        Haptico.shared().generate(.error)
        setInterfaceHiddenState(true)
        
        gameProcess.setState(onPause: true)
        engine.setPauseState(true)
        
        let score = gameProcess.score
        specificDelegate?.gameDidFinish(score: score)
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
    
    func soundStateDidChange(_ isOnSound: Bool) {
        soundButton.setSoundState(isEnabled: isOnSound)
    }
    
}

// MARK: - Game Engine Delegate

extension GameScene: GameEngineProtocol {
    
    func gameEngineGameDidUpdate(_ canUpdate: Bool) {
        if canUpdate {
            snake.move()
        }
    }
    
}

// MARK: - SKPhysics Contact Delegate

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        switch contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask {
            case SpriteModel.snakeHead.bitMask | SpriteModel.food.bitMask:
                food?.respawn()
                
                gameProcess.foodDidEat()
                snake.addBox()
            case SpriteModel.snakeHead.bitMask | SpriteModel.superFood.bitMask:
                gameProcess.superFoodDidEat()
                
                superFood?.remove()
                snake.addBox()
            case SpriteModel.snakeHead.bitMask | SpriteModel.wall.bitMask, SpriteModel.snakeBody.bitMask | SpriteModel.snakeHead.bitMask:
                finishGame()
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
            
            guard let buttonName = ButtonNode.Name(rawValue: touchedNode.name ?? "") else {
                return
            }
            
            switch buttonName {
                case .pause:
                    pauseGame()
                case .sound:
                    gameProcess.changeSoundState()
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
