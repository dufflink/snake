//
//  GameMode.swift
//  Snake
//
//  Created by Maxim Skorynin on 13.02.2021.
//

import UIKit

enum GameMode {
    
    case classic
    case wall
    
    var title: String {
        switch self {
            case .classic:
                return "Classic"
            case .wall:
                return "Wall"
        }
    }
    
    var image: UIImage? {
        switch self {
            case .classic:
                return UIImage(named: "Classic Mode")
            case .wall:
                return UIImage(named: "Wall Mode")
        }
    }
    
    var color: UIColor? {
        switch self {
            case .classic:
                return Design.Color.darkGrey.value
            case .wall:
                return Design.Color.darkGrey.value
        }
    }
    
}
