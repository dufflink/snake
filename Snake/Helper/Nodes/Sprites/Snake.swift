//
//  SnakeNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

final class Snake: Sprite {
    
    private var defaultLenght = 3
    
    override func reset() {
        super.reset()
        var index = map.elements.count / 2
        
        for _ in 0 ..< defaultLenght {
            index -= 1

            let mapBox = map.elements[index]
            let box = createBox(x: mapBox.x, y: mapBox.y)
            
            elements.append(box)
        }
    }
    
}
