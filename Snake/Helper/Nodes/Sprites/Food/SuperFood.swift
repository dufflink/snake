//
//  SuperFood.swift
//  Snake
//
//  Created by Maxim Skorynin on 08.12.2020.
//

import SpriteKit

final class SuperFood: Food {
    
    override var model: SpriteModel {
        return .superFood
    }
    
    override var bodySize: CGSize {
        return Constants.boxSize
    }
    
}
