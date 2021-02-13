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
    
    // MARK: - Life Cycle
    
    static func create() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: skView.frame.size)
        scene.specificDelegate = self
        
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
