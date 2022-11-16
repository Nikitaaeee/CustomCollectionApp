//
//  Date+Extension.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 16.11.2022.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
