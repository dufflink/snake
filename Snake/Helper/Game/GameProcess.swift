//
//  GameProcess.swift
//  Snake
//
//  Created by Maxim Skorynin on 16.12.2020.
//

import Foundation

protocol GameProcessDelegate: class {
    
    func scoreDidChange(_ score: Int)
    
    func superFoodTimerDidStart()
    
    func superFoodTimerDidStop()
    
    func superFoodTimerValueDidChange(timeLeft: TimeInterval)
    
    func needPlaceSuperFood()
    
}

final class GameProcess {
    
    weak var delegate: GameProcessDelegate?
    
    private var totalEatCount = 0
    private var score = 0
    
    private var foodPrice = 4
    
    private var superFoodTimer: Timer?
    private var timeStep: TimeInterval = 0.1
    
    private var superFoodLeftTime: TimeInterval = 10.0
    
    // MARK: - Life Cycle
    
    init(delegate: GameProcessDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Public Functions
    
    func foodDidEat() {
        totalEatCount += 1
        score += foodPrice
        
        delegate?.scoreDidChange(score)
        
        if totalEatCount % 5 == 0 {
            delegate?.needPlaceSuperFood()
            startSuperFoodTimer()
        }
    }
    
    func superFoodDidEat() {
        let points = Int(superFoodLeftTime * 10)
        score += points
        
        delegate?.scoreDidChange(score)
        stopSuperFoodTimer()
    }
    
    // MARK: - Private Functions
    
    private func startSuperFoodTimer() {
        delegate?.superFoodTimerDidStart()
        
        superFoodTimer = Timer.scheduledTimer(withTimeInterval: timeStep, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.superFoodLeftTime -= self.timeStep
            self.superFoodLeftTime = round(10 * self.superFoodLeftTime) / 10
            
            self.delegate?.superFoodTimerValueDidChange(timeLeft: self.superFoodLeftTime)
            
            if self.superFoodLeftTime == 0.0 {
                self.stopSuperFoodTimer()
            }
        }
    }
    
    private func stopSuperFoodTimer() {
        superFoodTimer?.invalidate()
        superFoodTimer = nil
        
        superFoodLeftTime = 10
        delegate?.superFoodTimerDidStop()
    }
    
}
