//
//  CGFloat+Extension.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 17.11.2022.
//

import Foundation

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
