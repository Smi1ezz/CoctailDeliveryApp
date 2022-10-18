//
//  File.swift
//  CocktailDeliveryApp
//
//  Created by admin on 17.10.2022.
//

import Foundation
import UIKit

enum AppColors {
    case appCategHeaderDeselectedPink, appCategHeaderSelectedBackgroundPink, appCategHeaderSelectedTextPink, appTextGray, appNaviBarBackground, appShadowGray, appSeporatorGray
}

extension UIColor {
    static func appColor(name: AppColors) -> UIColor {
        switch name {
        case .appCategHeaderDeselectedPink:
            return UIColor(named: "CategHeaderDeselectedPink") ?? .systemPink
        case .appCategHeaderSelectedBackgroundPink:
            return UIColor(named: "CategHeaderSelectedBackgroundPink") ?? .systemPink
        case .appCategHeaderSelectedTextPink:
            return UIColor(named: "CategHeaderSelectedTextPink") ?? .systemPink
        case .appTextGray:
            return UIColor(named: "TextGray") ?? .systemGray
        case .appNaviBarBackground:
            return UIColor(named: "NaviBarBackground") ?? .systemGray
        case .appShadowGray:
            return UIColor(named: "ShadowGray") ?? .systemGray
        case .appSeporatorGray:
            return UIColor(named: "SeporatorGray") ?? .systemGray
        }
    }
}
