//
//  SuperFood.swift
//  Snake
//
//  Created by Maxim Skorynin on 08.12.2020.
//

import SpriteKit

final class SuperFood: Food {
    
    override var sprite: Game.Sprite {
        return .superFood
    }
    
    override var bodySize: CGSize {
        return Game.boxSize
    }
    
}
