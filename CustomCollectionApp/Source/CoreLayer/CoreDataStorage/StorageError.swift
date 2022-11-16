//
//  StorageError.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 16.11.2022.
//

import Foundation

public enum StorageError: String, Error {
    case saveError = "Saving Error"
    case deleteError = "Delete Error"
    case fetchError = "Fetching Error"
}
