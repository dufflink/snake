//
//  Snake.MovingDirection.swift
//  Snake
//
//  Created by Maxim Skorynin on 02.12.2020.
//

import UIKit

extension Snake {
    
    enum MovingDirection {
        
        case up
        case down
        
        case left
        case right
        
        init(swipeDirection: UISwipeGestureRecognizer.Direction) {
            switch swipeDirection {
                case .up:
                    self = .up
                case .down:
                    self = .down
                case .left:
                    self = .left
                case .right:
                    self = .right
                default:
                    self = .up
            }
        }
        
    }
    
}
