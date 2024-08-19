//
//  UIFont+extensions.swift
//  mobileUp
//
//  Created by Alexander Kozharin on 19.08.24.
//

import UIKit

extension CGFloat {
    func fontSizeForDevice() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width

        switch screenWidth {
        case 320.0: // iPhone SE (1st generation), iPhone 5, 5s, 5c
            return 25
        case 375.0: // iPhone 6/7/8, iPhone SE (2nd generation), iPhone X/XS, iPhone 11 Pro
            return 30
        case 414.0: // iPhone 6/7/8 Plus, iPhone XR, iPhone 11, iPhone 11 Pro Max
            return 35
        default: // Default for larger screens like iPhone 12/13/14 Pro Max or other unhandled devices
            return 44
        }
    }
}
