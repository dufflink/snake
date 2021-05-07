//
//  SLabel.swift
//  Snake
//
//  Created by Maxim Skorynin on 13.02.2021.
//

import UIKit

@IBDesignable final class SLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        font = Design.getFont(size: fontSize)
    }
    
    @IBInspectable var fontSize: CGFloat {
        get {
            return font.pointSize
        } set {
            font = Design.getFont(size: newValue)
        }
    }
    
}
