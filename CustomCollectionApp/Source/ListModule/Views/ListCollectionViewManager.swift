//
//  ListCollectionViewManager.swift
//  CustomCollectionApp
//
//  Created by Nikita Kirshin on 13.11.2022.
//

import UIKit

protocol ManageListCollection: UICollectionViewDelegate, UICollectionViewDataSource {
    var cells: [ListDataFlow.CellViewModel] { get set }
    var delegate: ListCollectionManagerDelegate? { get set }
}

protocol ListCollectionManagerDelegate {
}

final class ListCollectionManager: NSObject {
    
    // MARK: - Properties

    var cells = [ListDataFlow.CellViewModel]()
    var delegate: ListCollectionManagerDelegate?

}

// MARK: - ManageListCollection

extension ListCollectionManager: ManageListCollection {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.identifier, for: indexPath) as? ListViewCell
        else {
            return UICollectionViewCell()
        }
        let viewModel = cells[indexPath.item]
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ListCollectionManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - Constants.widthOffset
        let height: CGFloat = Constants.cellHeight
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - Constants

private extension ListCollectionManager {
    private enum Constants {
        static let identifier = "ListCollectionViewCell"
        static let widthOffset: CGFloat = 40
        static let cellHeight: CGFloat = 100
        static let minimumSpacing: CGFloat = 10
    }
}

