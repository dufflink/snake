//
//  UIView.swift
//  Snake
//
//  Created by Maxim Skorynin on 24.05.2021.
//

import UIKit

extension UIView {
    
    func addSubviewWithConstraints(_ subview: UIView, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailing),
            
            subview.topAnchor.constraint(equalTo: topAnchor, constant: top),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom)
        ])
    }
    
}
