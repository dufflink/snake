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
    
    private let gameCenterHelper = GameCenterHelper.shared
    private let localStorage = LocaleStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !localStorage.isUserCanceledGameCenter else {
            return
        }
        
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
        gameCenterHelper.auth { [weak self] vc, isAuth  in
            guard let vc = vc else {
                print("Game Center View Controller is nil")
                self?.localStorage.isUserCanceledGameCenter = !isAuth
                
                if !isAuth {
                    // TODO: Сообщить, что результаты не будут записаны в таблицу лидеров
                }
                
                return
            }
            
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
    }
    
}
