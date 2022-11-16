//
//  SceneDelegate.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        if let viewController = try? ListViewAssembly().build() {
            let navigationController = UINavigationController(rootViewController: viewController)
            window?.makeKeyAndVisible()
            window?.rootViewController = navigationController
            window?.overrideUserInterfaceStyle = .light
        }
    }
}

