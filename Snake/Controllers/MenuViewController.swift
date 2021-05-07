//
//  MenuViewController.swift
//  Snake
//
//  Created by Maxim Skorynin on 09.02.2021.
//

import UIKit

final class MenuViewController: UIViewController {
    
    @IBOutlet private weak var gameModeStackView: GameModeStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func startGameButtonDidPress(_ sender: Any) {
        guard let gameViewController = GameViewController.create() else {
            return
        }
        
        gameViewController.modalPresentationStyle = .overFullScreen
        gameViewController.modalTransitionStyle = .crossDissolve
        
        present(gameViewController, animated: true)
    }
    
    // MARK: - Private Functions
    
    private func configure() {
        gameModeStackView.delegate = self
    }
    
}

// MARK: - GameMode StackView Delegate

extension MenuViewController: GameModeStackViewDelegate {
    
    func modeDidChanged(_ selectedMode: GameMode) {
        Options.gameMode = selectedMode
    }
    
}
