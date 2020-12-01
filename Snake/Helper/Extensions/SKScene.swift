//
//  SKScene.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

extension SKScene {
    
    var height: Int {
        return Int(frame.height)
    }
    
    var width: Int {
        return Int(frame.width)
    }
    
    var midX: Int {
        return Int(frame.midX)
    }
    
    var midY: Int {
        return Int(frame.midY)
    }
    
}
