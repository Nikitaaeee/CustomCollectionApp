//
//  ListRouter.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 16.11.2022.
//

import UIKit

protocol ListRoutes {
    func didRequestAlert(title: String, message: String)
}

final class ListRouter {
    
    // MARK: - Properties

    weak var viewController: ListViewController?
}

    // MARK: - ListRoutes

extension ListRouter: ListRoutes {
    func didRequestAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: Constants.titleText,
                                     style: .default)
        alertController.addAction(okAction)
        self.viewController?.present(alertController,
                                     animated: true,
                                     completion: nil)
    }
}

    // MARK: - Constants

private extension ListRouter {
    enum Constants {
        static let titleText: String = "Ok"
    }
}


