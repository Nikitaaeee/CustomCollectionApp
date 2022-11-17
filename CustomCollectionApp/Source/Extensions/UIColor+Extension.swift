//
//  UIColor+Extension.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 17.11.2022.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
