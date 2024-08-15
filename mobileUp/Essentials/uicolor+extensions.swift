//
//  uicolor+extensions.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 13.08.24.
//

import UIKit

extension UIColor {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }
}
