//
//  Theme.swift
//  GitWorkshop
//
//  Created by David Para on 11/28/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class Theme {
    
    class Color {
        static var backgroundColor = UIColor.white
        static var popupBackgroundColor = UIColor(red:0.16, green:0.50, blue:0.90, alpha:1.00)
        static var popupTextColor = UIColor(red:0.88, green:0.89, blue:0.94, alpha:1.00)
    }
    
    class Font: UIFont {
        
        enum FontStyle {
            case bold
            case demiBold
            case medium
            case regular
        }
        
        static var titleFont = style(.bold, size: 22)
        static var popupTitleFont = style(.medium, size: 16)
        static var popupDescriptionFont = style(.regular, size: 14)
        static var body = style(.demiBold, size: 12)
        
        class func style(_ type: Theme.Font.FontStyle, size: CGFloat = 12) -> UIFont {
            switch type {
            case .bold:
                return UIFont(name: "AvenirNext-Bold", size: size)!
            case .demiBold:
                return UIFont(name: "AvenirNext-DemiBold", size: size)!
            case .medium:
                return UIFont(name: "AvenirNext-Medium", size: size)!
            case .regular:
                return UIFont(name: "AvenirNext-Regular", size: size)!
            }
        }
    }
}
