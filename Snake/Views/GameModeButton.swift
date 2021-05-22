//
//  GameModeButton.swift
//  Snake
//
//  Created by Maxim Skorynin on 13.02.2021.
//

import UIKit

final class GameModeButton: SView {
    
    @IBOutlet private weak var rootView: SView!
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var labelView: UILabel!
    
    private var action: (() -> Void)?
    
    // MARK: - Life Cycle
    
    override func getParentNib() -> UINib? {
        return UINib(nibName: "GameModeButton", bundle: nil)
    }
    
    convenience init(gameMode: GameMode, action: (() -> Void)?) {
        self.init()
        
        imageView.image = gameMode.image
        labelView.text = gameMode.title
        
        rootView.backgroundColor = gameMode.color
        translatesAutoresizingMaskIntoConstraints = false
        
        self.action = action
    }
    
    // MARK: - Builder Actions
    
    @IBAction func bodyViewDidPress(_ sender: Any) {
        action?()
    }
    
    // MARK: - Public Functions
    
    func setSelected() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
            self.transform = .identity
        }
    }
    
    func setDeselected() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.alpha = 0.25
            self.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
}
