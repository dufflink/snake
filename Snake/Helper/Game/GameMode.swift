//
//  GameMode.swift
//  Snake
//
//  Created by Maxim Skorynin on 13.02.2021.
//

import UIKit

enum GameMode {
    
    case classic
    case box
    
    var title: String {
        switch self {
            case .classic:
                return "Classic"
            case .box:
                return "Box"
        }
    }
    
    var image: UIImage? {
        switch self {
            case .classic:
                return UIImage(named: "Start")
            case .box:
                return UIImage(named: "Pause")
        }
    }
    
    var color: UIColor? {
        switch self {
            case .classic:
                return Design.Color.green.value
            case .box:
                return Design.Color.green.value
        }
    }
    
}
