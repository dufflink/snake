//
//  MapNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

final class MapNode: GameNode {
    
    unowned var scene: SKScene
    weak var snake: Snake?
    
    var elements: [Box] = []
    var color: UIColor = #colorLiteral(red: 0.2784800231, green: 0.2978506684, blue: 0.3323064744, alpha: 1)
    
    // MARK: - Public Properties
    
    var midIndex: Int {
        return (elements.count - 1) / 2
    }
    
    // MARK: - Life Cycle
    
    init(scene: SKScene) {
        self.scene = scene
        reset()
    }
    
    // MARK: - Public Functions
    
    func reset() {
        let sceneWidth = scene.width
        let sceneHeight = scene.height
        
        let boxSide = sceneWidth / Game.mapColumns
        Game.boxSide = boxSide
        
        for y in stride(from: boxSide, to: sceneHeight - boxSide, by: boxSide) {
            for x in stride(from: boxSide, to: sceneWidth - boxSide, by: boxSide) {
                let box = createBox(x: x, y: y)
                elements.append(box)
            }
        }
    }
    
    var rows: [[Box]] {
        var result: [[Box]] = []
        
        let columns = Game.mapColumns - 1
        let rows = (scene.height / Game.boxSide) - 1
        
        for i in 0 ..< rows {
            let min = i * columns
            let max = min + columns
             
            let array = Array(elements[min ..< max])
            result.append(array)
        }
        
        return result
    }
    
    // Use `edgeBoxes` for WallFrame.init()
    
    var edgeBoxes: [Box] {
        var result: [Box] = []
        
        if let bottomEdge = rows.first, let topEdge = rows.last {
            result += bottomEdge + topEdge
        }
        
        for row in rows {
            if let firstInRow = row.first, let lastInRow = row.last {
                result += [firstInRow, lastInRow]
            }
        }
        
        return result
    }
    
    // Use `clearBoxes` for Food.init()
    
    var clearBoxes: [Box] {
        let snakeBoxes = snake?.elements ?? []
        
        return elements.filter { element in
            !edgeBoxes.contains(where: { element == $0 }) && !snakeBoxes.contains(where: { element == $0 })
        }
    }
    
}

