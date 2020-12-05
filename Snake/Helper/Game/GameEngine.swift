//
//  GameEngine.swift
//  Snake
//
//  Created by Maxim Skorynin on 02.12.2020.
//

import Foundation

struct GameEngine {
    
    var timeDelta: TimeInterval = 0
    var oldTime: TimeInterval = 0
    
    var speed = 0.4
    var canUpdate = false
    
    var onPause = false
    
    mutating func update(with time: TimeInterval) {
        guard !onPause else {
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
    
    mutating func changePauseState() {
        onPause.toggle()
    }
    
}
