//
//  ListViewPresenter.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import Foundation

protocol ListPresentationLigic: AnyObject {
    func presentData(response: ListDataFlow.PresentationCollectionView.Response)

}

final class ListPresenter {
    weak var viewController: ListViewDisplayLogic?
}

extension ListPresenter: ListPresentationLigic {
    func presentData(response: ListDataFlow.PresentationCollectionView.Response) {
        let modelForCell = response.employees.compactMap({ makeCellViewModel(from: $0)})
        viewController?.displayEmployeeData(with: ListDataFlow.PresentationCollectionView.ViewModel(cells: modelForCell.sorted(by: {$0.employeeName < $1.employeeName})))
    }
}

private extension ListPresenter {
    func makeCellViewModel(from response: Employee) -> ListDataFlow.CellViewModel {
        ListDataFlow.CellViewModel.init(
            employeeName: response.name,
            phoneNumber: response.phoneNumber,
            skills: response.skills.joined(separator: Constants.skillsSeparator))
    }
}

private extension ListPresenter {
    enum Constants {
        static let skillsSeparator: String = ", "
    }
}
