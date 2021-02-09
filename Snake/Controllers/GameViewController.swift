//
//  GameViewController.swift
//  Snake
//
//  Created by Maxim Skorynin on 30.11.2020.
//

import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var skView: SKView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private(set) var mode: GameEngine.Mode = .classic
    
    // MARK: - Life Cycle
    
    static func create(mode: GameEngine.Mode) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController
        controller?.mode = mode
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: skView.frame.size)
        
        scene.specificDelegate = self
        scene.mode = mode
        
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true

        skView.showsFPS = true
        skView.showsNodeCount = true
    }
    
}

// MARK: - GameScene Delegate

extension GameViewController: GameSceneDelegate {
    
    func gameDidFinish() {
        dismiss(animated: true)
    }
    
}
