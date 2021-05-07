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

extension Design {
    
    enum Color {
        
        case red
        case green
        case blue
        case yellow
        
        case lightGray
        case darkGrey
        
        case background
        case box
        
        var value: UIColor {
            switch self {
                case .red:
                    return #colorLiteral(red: 1, green: 0.6509803922, blue: 0.6196078431, alpha: 1)
                case .green:
                    return #colorLiteral(red: 0.7215686275, green: 0.9490196078, blue: 0.9019607843, alpha: 1)
                case .blue:
                    return #colorLiteral(red: 0.7330129743, green: 0.8780248761, blue: 0.9025623798, alpha: 1)
                case .yellow:
                    return #colorLiteral(red: 0.9818401933, green: 0.954026401, blue: 0.8664388061, alpha: 1)
                    
                case .lightGray:
                    return #colorLiteral(red: 0.368627451, green: 0.3921568627, blue: 0.4470588235, alpha: 1)
                case .darkGrey:
                    return #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2196078431, alpha: 1)
                    
                case .background:
                    return #colorLiteral(red: 0.2223047018, green: 0.238258481, blue: 0.2790471315, alpha: 1)
                case .box:
                    return #colorLiteral(red: 0.2784800231, green: 0.2978506684, blue: 0.3323064744, alpha: 1)
            }
        }
        
    }
    
}
