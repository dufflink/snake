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
    let weeklyClassicModeLeaderboardID = "com.maximskorynin.Snake.weekly.classic.leaderboard"
    
    let wallModeLeaderboardID = "com.maximskorynin.Snake.wall.leaderboard"
    let weeklyWallModeLeaderboardID = "com.maximskorynin.Snake.weekly.wall.leaderboard"
    
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
        var scores: [GKScore] = []
        
        if mode == .classic {
            scores = [
                GKScore(leaderboardIdentifier: classicModeLeaderboardID),
                GKScore(leaderboardIdentifier: weeklyClassicModeLeaderboardID)
            ]
        } else {
            scores = [
                GKScore(leaderboardIdentifier: wallModeLeaderboardID),
                GKScore(leaderboardIdentifier: weeklyWallModeLeaderboardID)
            ]
        }
        
        scores.forEach {
            $0.value = Int64(score)
        }
        
        GKScore.report(scores) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
    
}
