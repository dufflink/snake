//
//  PauseButton.swift
//  Snake
//
//  Created by Maxim Skorynin on 05.12.2020.
//

import SpriteKit

final class PauseButton: ButtonNode {
    
    init() {
        super.init(imageName: "Pause")
        name = Name.pause.rawValue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("ButtonNode. Required init did call")
    }
    
}
