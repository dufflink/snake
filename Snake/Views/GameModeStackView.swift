//
//  GameModeStackView.swift
//  Snake
//
//  Created by Maxim Skorynin on 13.02.2021.
//

import UIKit

protocol GameModeStackViewDelegate: class {
    
    func modeDidChanged(_ selectedMode: GameMode)
    
}

@IBDesignable
final class GameModeStackView: UIStackView {
    
    private var buttons: [GameModeButton] = []
    private var currentIndex: Int = 1
    
    weak var delegate: GameModeStackViewDelegate?
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Private Functions
    
    private func configure() {
        axis = .horizontal
        distribution = .fillEqually
        
        spacing = 8
        
        buttons = [
            GameModeButton(gameMode: .box, action: { [weak self] in
                self?.currentIndex = 0
                self?.updateButtons()
                
                self?.delegate?.modeDidChanged(.box)
            }),
            GameModeButton(gameMode: .classic, action: { [weak self] in
                self?.currentIndex = 1
                self?.updateButtons()
                
                self?.delegate?.modeDidChanged(.classic)
            })
        ]
        
        buttons.forEach { button in
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 150)
            ])
            
            insertArrangedSubview(button, at: 0)
        }
        
        updateButtons()
    }
    
    private func updateButtons() {
        for i in 0 ..< buttons.count {
            i == currentIndex ? buttons[i].setSelected() : buttons[i].setDeselected()
        }
    }
    
}
