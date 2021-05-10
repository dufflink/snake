//
//  GameViewController.swift
//  Snake
//
//  Created by Maxim Skorynin on 30.11.2020.
//

import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var skView: SKView!
    
    private var pauseMenuViewController: PauseMenuViewController?
    private var gameScene: GameScene?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Life Cycle
    
    static func instance() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: skView.frame.size)
        scene.specificDelegate = self
        
        gameScene = scene
        
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true

        skView.showsFPS = true
        skView.showsNodeCount = true
    }
    
    private func presentPauseMenuViewController(onPause: Bool, score: Int) {
        guard let controller = PauseMenuViewController.instance(score: score, onPause: onPause) else {
            return
        }
        
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        
        controller.delegate = self
        pauseMenuViewController = controller
        
        present(controller, animated: true)
    }
    
}

// MARK: - GameScene Delegate

extension GameViewController: GameSceneDelegate {
    
    func gameDidFinish(score: Int) {
        presentPauseMenuViewController(onPause: false, score: score)
    }
    
    func gameDidPause(score: Int) {
        presentPauseMenuViewController(onPause: true, score: score)
    }
    
    func gameDidResume() {
        pauseMenuViewController?.dismiss(animated: true)
    }
    
}

// MARK: - PauseMenu ViewController Delegate

extension GameViewController: PauseMenuViewControllerDelegate {
    
    func restartButtonDidPress(onPause: Bool) {
        gameScene?.setInterfaceHiddenState(false)
        
        pauseMenuViewController?.dismiss(animated: true) {
            self.gameScene?.restartGame()
            self.gameScene?.resumeGame()
        }
    }
    
    func resumeButtonDidPress() {
        gameScene?.setInterfaceHiddenState(false)
        
        pauseMenuViewController?.dismiss(animated: true) {
            self.gameScene?.resumeGame()
        }
    }
    
    func exitButtonDidPress(onPause: Bool) {
        pauseMenuViewController?.dismiss(animated: false) {
            self.dismiss(animated: true)
        }
    }
    
}
