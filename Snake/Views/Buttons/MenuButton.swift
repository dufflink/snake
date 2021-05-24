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
        
        labelView = SLabel()
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
        
        labelView.font = nil ?? Design.getFont(size: fontSize)
        buttonColor = nil ?? buttonColor
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
    
    @IBInspectable var fontSize: CGFloat = 28 {
        didSet {
            labelView?.font = Design.getFont(size: fontSize)
        }
    }
    
    @IBInspectable var buttonColor: UIColor? = Design.Color.darkGrey.value {
        didSet {
            backgroundColor = buttonColor
        }
    }
    
}
