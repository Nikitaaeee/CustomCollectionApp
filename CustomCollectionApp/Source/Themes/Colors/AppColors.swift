//
//  AppColors.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import UIKit

enum AppColors {
    case lightGray
    
    var color: UIColor {
        switch self {
        case .lightGray:
            return UIColor(red: 245/250, green: 245/250, blue: 245/250, alpha: 1)
        }
    }
}
