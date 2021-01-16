//
//  GameEngine.swift
//  Snake
//
//  Created by Maxim Skorynin on 02.12.2020.
//

import Foundation

protocol GameEngineProtocol: class {
    
    func gameEngineGameDidUpdate(_ canUpdate: Bool)
    
    func gameEnginePauseStateDidChange(_ onPause: Bool)
    
}

final class GameEngine {
    
    weak var delegate: GameEngineProtocol?
    
    private var timeDelta: TimeInterval = 0
    private var oldTime: TimeInterval = 0
    
    private var speed = 0.25
    private var canUpdate = false
    
    private var onPause = false
    
    var mode: Mode = .box
    
    // MARK: - Life Cycle
    
    init(mode: Mode, delegate: GameEngineProtocol) {
        self.mode = mode
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
    
    func changePauseState() {
        onPause.toggle()
        delegate?.gameEnginePauseStateDidChange(onPause)
    }
    
}

// MARK: - GameEngine.Mode

extension GameEngine {
    
    enum Mode {
        
        case classic
        case box
        
    }
    
}
