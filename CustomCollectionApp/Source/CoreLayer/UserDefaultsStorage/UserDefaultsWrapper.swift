//
//  UserDefaultsWrapper.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 16.11.2022.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    public let key: String
    private let userDefaults: UserDefaults
    public let defaultValue: T

    public init(key: String, userDefaults: UserDefaults = UserDefaults.standard, defaultValue: T) {
        self.key = key
        self.userDefaults = userDefaults
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}
