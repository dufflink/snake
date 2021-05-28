//
//  MenuViewController.swift
//  Snake
//
//  Created by Maxim Skorynin on 09.02.2021.
//

import Haptico
import GameKit

final class MenuViewController: UIViewController {
    
    @IBOutlet private weak var gameModeStackView: GameModeStackView!
    @IBOutlet private weak var leaderboardButton: MenuButton!
    
    private let gameCenterHelper = GameCenterHelper.shared
    private let localStorage = LocaleStorage()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        openGameCenterAuth()
    }
    
    // MARK: - IBAction Functions
    
    @IBAction func startGameButtonDidPress(_ sender: Any) {
        guard let gameViewController = GameViewController.instance() else {
            return
        }
        
        gameViewController.modalPresentationStyle = .overFullScreen
        gameViewController.modalTransitionStyle = .crossDissolve
        
        present(gameViewController, animated: true)
    }
    
    @IBAction func leaderboardButtonDidPress(_ sender: Any) {
        if gameCenterHelper.isAuth {
            let vc = GKGameCenterViewController()
            
            vc.gameCenterDelegate = self
            vc.viewState = .leaderboards
            
            vc.leaderboardIdentifier = gameCenterHelper.classicModeLeaderboardID
            present(vc, animated: true)
        } else {
            openGameCenterAuth()
        }
    }
    
    // MARK: - Private Functions
    
    private func configure() {
        gameModeStackView.delegate = self
    }
    
    private func openGameCenterAuth() {
        gameCenterHelper.auth { [weak self] vc, isAuth, error  in
            guard let vc = vc as? GKGameCenterViewController else {
                print("Game Center View Controller is nil")
                DispatchQueue.main.async {
                    self?.leaderboardButton.isActive = isAuth
                }
                
                return
            }
            
            vc.gameCenterDelegate = self
            self?.present(vc, animated: true)
        }
    }
    
}

// MARK: - GameMode StackView Delegate

extension MenuViewController: GameModeStackViewDelegate {
    
    func modeDidChanged(_ selectedMode: GameMode) {
        if Options.gameMode != selectedMode {
            Haptico.shared().generate(.medium)
            Options.gameMode = selectedMode
        }
    }
    
}

// MARK: - GKGame Center Controller Delegate

extension MenuViewController: GKGameCenterControllerDelegate {
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
        
        if !gameCenterHelper.isAuth {
            SAlert(title: "You should enable Game Center otherwise your results won't be recorded on the leaderboard").present()
        }
    }
    
}
