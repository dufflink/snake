//
//  GameCenterHelper.swift
//  Snake
//
//  Created by Maxim Skorynin on 21.05.2021.
//

import GameKit

final class GameCenterHelper {
    
    static let shared = GameCenterHelper()
    
    private let player = GKLocalPlayer.local
    
    let classicModeLeaderboardID = "com.maximskorynin.Snake.classic.leaderboard"
    let boxModeLeaderboardID = "com.maximskorynin.Snake.wall.leaderboard"
    
    // MARK: - Public Properties
    
    var isAuth: Bool {
        return player.isAuthenticated
    }
    
    // MARK: - Life Cycle
    
    private init() { }
    
    // MARK: - Public Functions
    
    func auth(completion: @escaping (_ vc: UIViewController?, _ isAuth: Bool, _ error: Error?) -> Void) {
        player.authenticateHandler = { [weak self] vc, error in
            guard let isAuth = self?.isAuth else {
                return
            }
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil, isAuth, error)
                return
            }
            
            completion(vc, isAuth, nil)
        }
    }
    
    func addScore(_ score: Int, mode: GameMode, completion: @escaping (Error?) -> Void) {
        let leaderboardID = mode == .classic ? classicModeLeaderboardID : boxModeLeaderboardID
        let gkScore = GKScore(leaderboardIdentifier: leaderboardID)
        gkScore.value = Int64(score)
        
        GKScore.report([gkScore]) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
    
}
