//
//  GameProcess.swift
//  Snake
//
//  Created by Maxim Skorynin on 16.12.2020.
//

import SpriteKit
import Haptico

protocol GameProcessDelegate: AnyObject {
    
    func scoreDidChange(_ score: Int)
    
    func superFoodTimerDidStart(savedProgress: Float)
    
    func superFoodTimerDidRemove()
    
    func superFoodTimerValueDidChange(timeLeft: TimeInterval)
    
    func needPlaceSuperFood()
    
    func soundStateDidChange(_ isOnSound: Bool)
    
}

final class GameProcess {
    
    weak var delegate: GameProcessDelegate?
    
    private var totalEatCount = 0
    var score = 0
    
    private var foodPrice = 4
    
    private var superFoodTimer: Timer?
    private var timeStep: TimeInterval = 0.1
    
    private var superFoodTimeLeft: TimeInterval = 10.0
    private var needTimer = false
    
    // MARK: - Life Cycle
    
    init(node: SKNode, delegate: GameProcessDelegate) {
        self.delegate = delegate
        let isOnSound = LocaleStorage().isOnSound
        
        SoundHelper.shared.setNode(node)
        SoundHelper.shared.setSoundState(isOnSound)
    }
    
    // MARK: - Public Functions
    
    func foodDidEat() {
        totalEatCount += 1
        score += foodPrice
        
        delegate?.scoreDidChange(score)
        
        if totalEatCount % 5 == 0 {
            SoundHelper.shared.playSuperFoodSound()
            Haptico.shared().generate(.warning)
            
            needTimer = true
            
            delegate?.needPlaceSuperFood()
            startSuperFoodTimer()
        } else {
            SoundHelper.shared.playFoodSound()
            Haptico.shared().generate(.light)
        }
    }
    
    func setState(onPause: Bool) {
        guard needTimer else {
            return
        }
        
        if onPause  {
            stopSuperFoodTimer()
        } else {
            startSuperFoodTimer()
        }
    }
    
    func superFoodDidEat() {
        SoundHelper.shared.playFoodSound()
        Haptico.shared().generate(.light)
        
        let points = Int(superFoodTimeLeft * 10)
        score += points
        
        delegate?.scoreDidChange(score)
        removeSuperFoodTimer()
    }
    
    func restart() {
        score = 0
        totalEatCount = 0
        
        removeSuperFoodTimer()
    }
    
    func changeSoundState() {
        SoundHelper.shared.changeSoundState()
        LocaleStorage().isOnSound = SoundHelper.shared.isOnSound
        delegate?.soundStateDidChange(SoundHelper.shared.isOnSound)
    }
    
    // MARK: - Private Functions
    
    private func startSuperFoodTimer() {
        let savedProgress = Float(superFoodTimeLeft / 10)
        delegate?.superFoodTimerDidStart(savedProgress: savedProgress)
        
        superFoodTimer = Timer.scheduledTimer(withTimeInterval: timeStep, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.superFoodTimeLeft -= self.timeStep
            self.superFoodTimeLeft = round(10 * self.superFoodTimeLeft) / 10
            
            self.delegate?.superFoodTimerValueDidChange(timeLeft: self.superFoodTimeLeft)
            
            if self.superFoodTimeLeft == 0.0 {
                self.removeSuperFoodTimer()
            }
        }
    }
    
    private func removeSuperFoodTimer() {
        needTimer = false
        
        superFoodTimer?.invalidate()
        superFoodTimer = nil
        
        superFoodTimeLeft = 10
        delegate?.superFoodTimerDidRemove()
    }
    
    private func stopSuperFoodTimer() {
        superFoodTimer?.invalidate()
        superFoodTimer = nil
    }
    
}
