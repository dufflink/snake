//
//  Design.swift
//  Snake
//
//  Created by Maxim Skorynin on 13.02.2021.
//

import UIKit

final class Design {
    
    static var fontName = "kroftsmann"
    
    static func getFont(size: CGFloat) -> UIFont? {
        return UIFont(name: fontName, size: size)
    }
    
}
