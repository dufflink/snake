//
//  GameEngine.swift
//  Snake
//
//  Created by Maxim Skorynin on 02.12.2020.
//

import Foundation

protocol GameEngineProtocol: AnyObject {
    
    func gameEngineGameDidUpdate(_ canUpdate: Bool)
    
}

final class GameEngine {
    
    weak var delegate: GameEngineProtocol?
    
    private var timeDelta: TimeInterval = 0
    private var oldTime: TimeInterval = 0
    
    private var speed = 0.24
    private var canUpdate = false
    
    private var onPause = false
    
    var mode: GameMode = Options.gameMode
    
    // MARK: - Life Cycle
    
    init(delegate: GameEngineProtocol) {
        self.delegate = delegate
    }
    
    // MARK: - Public Functions
    
    func update(with time: TimeInterval) {
        defer {
            delegate?.gameEngineGameDidUpdate(canUpdate)
        }
        
        guard !onPause else {
            canUpdate = false
            return
        }
        
        timeDelta += time - oldTime
        oldTime = time
        
        if timeDelta > speed {
            canUpdate = true
            timeDelta = 0
        } else {
            canUpdate = false
        }
    }
    
    func setPauseState(_ onPause: Bool) {
        self.onPause = onPause
    }
    
}
