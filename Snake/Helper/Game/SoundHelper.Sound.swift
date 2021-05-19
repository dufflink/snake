//
//  SoundHelper.Sound.swift
//  Snake
//
//  Created by Maxim Skorynin on 19.05.2021.
//

extension SoundHelper {
    
    enum Sound {
        
        case food
        case superFood
        
        var sourceName: String {
            switch self {
                case .food:
                    return "food.wav"
                case .superFood:
                    return "superfood.wav"
            }
        }
        
    }
    
}
