//
//  MapNode.swift
//  Snake
//
//  Created by Maxim Skorynin on 01.12.2020.
//

import SpriteKit

final class MapNode: GameNode {
    
    var bodySize: CGSize?
    var texture: SKTexture?
    
    unowned var scene: SKScene
    weak var snake: Snake?
    
    var elements: [Box] = []
    var color: UIColor = #colorLiteral(red: 0.2784800231, green: 0.2978506684, blue: 0.3323064744, alpha: 1)
    
    var mode: GameMode
    
    // MARK: - Public Properties
    
    var midIndex: Int {
        return (elements.count - 1) / 2
    }
    
    var minX: Int = 0
    var maxX: Int = 0
    
    var minY: Int = 0
    var maxY: Int = 0
    
    // MARK: - Life Cycle
    
    init(scene: SKScene, mode: GameMode) {
        self.scene = scene
        self.mode = mode
        
        reset()
    }
    
    // MARK: - Public Functions
    
    func reset() {
        let sceneWidth = scene.width
        
        let boxSide = sceneWidth / Constants.mapColumns
        Constants.boxSide = boxSide
        
        let sceneHeight = scene.height - (2 * boxSide)
        Constants.mapRows = sceneHeight / Constants.boxSide
        
        var i = 0
        let boxesCount = (Constants.mapRows - 1) * (Constants.mapColumns - 1)
        
        for y in stride(from: boxSide, to: sceneHeight - boxSide, by: boxSide) {
            for x in stride(from: boxSide, to: sceneWidth - boxSide, by: boxSide) {
                let box = createBox(x: x, y: y)
                elements.append(box)
                if i == 0 {
                    minX = x
                    minY = y
                }
                
                if i == boxesCount - 1 {
                    maxX = x
                    maxY = y
                }
                
                i += 1
            }
        }
    }
    
    lazy var rows: [[Box]] = {
        var result: [[Box]] = []
        
        let columns = Constants.mapColumns - 1
        let rows = Constants.mapRows - 1
        
        for i in 0 ..< rows {
            let min = i * columns
            let max = min + columns
             
            let array = Array(elements[min ..< max])
            result.append(array)
        }
        
        return result
    }()
    
    // Use `edgeBoxes` for WallFrame.init()
    
    lazy var edgeBoxes: [Box] = {
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
    }()
    
    // Use `clearBoxes` for Food.init()
    
    var clearBoxes: [Box] {
        var usedBoxed = snake?.elements ?? []
        
        if mode == .box {
            usedBoxed += edgeBoxes
        }
        
        return elements.filter { element in
            !usedBoxed.contains(where: { element == $0 })
        }
    }
    
}
