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
        
        init?(dx: CGFloat, dy: CGFloat) {
            let step: CGFloat = 10.0
            
            let isHorizontal = dy < step && dy > -step
            let isVertical = dx < step && dx > -step
            
            if dx > step && isHorizontal {
                self = .right
                return
            } else if dx < -step && isHorizontal {
                self = .left
                return
            }
            
            if dy > step && isVertical {
                self = .up
                return
            } else if dy < -step && isVertical {
                self = .down
                return
            }
            
            return nil
        }
        
    }
    
}
