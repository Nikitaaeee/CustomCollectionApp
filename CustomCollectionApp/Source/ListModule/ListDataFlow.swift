//
//  ListDataFlow.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

enum ListDataFlow {
    enum PresentationCollectionView {
        struct Response {
            let employees: [Employee]
        }
        struct ViewModel {
            let cells: [CellViewModel]
        }
    }
}

extension ListDataFlow {
    struct CellViewModel {
        let employeeName: String
        let phoneNumber: String
        let skills: String
    }
}
