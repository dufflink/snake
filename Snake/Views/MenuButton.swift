//
//  MenuButton.swift
//  Snake
//
//  Created by Maxim Skorynin on 07.05.2021.
//

import UIKit

@IBDesignable final class MenuButton: SView {
    
    private var labelView: SLabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Functions
    
    private func configure() {
        isResponsive = true
        cornersRadius = 8
        backgroundColor = Design.Color.darkGrey.value
        
        labelView = SLabel()
        
        labelView?.font = Design.getFont(size: 28)
        labelView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(labelView)
        NSLayoutConstraint.activate([
            labelView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2),
            labelView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        updateProperties()
    }
    
    private func updateProperties() {
        textLabel = nil ?? textLabel
        textColor = nil ?? textColor
    }
    
    // MARK: - Inspected Properties
    
    @IBInspectable var textLabel: String? {
        didSet {
            labelView?.text = textLabel
        }
    }
    
    @IBInspectable var textColor: UIColor? = Design.Color.yellow.value {
        didSet {
            labelView?.textColor = textColor
        }
    }
    
}
