//
//  ModuleAssembly.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import UIKit

protocol ModuleAssembly {
    associatedtype Context
    associatedtype ViewController: UIViewController

    func build(with context: Self.Context) throws -> ViewController
}

extension ModuleAssembly where Context == Void {
    func build() throws -> ViewController {
        try build(with: ())
    }
}

extension ModuleAssembly where Context == Any? {
    func build() throws -> ViewController {
        try build(with: nil)
    }
}
