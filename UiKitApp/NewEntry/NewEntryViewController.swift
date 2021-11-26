//
//  CollectionViewController.swift
//  UiKitApp
//
//  Created by Егор Пехота on 06.11.2021.
//

import UIKit
import Combine
import CoreData

class NewEntryViewController: UICollectionViewController {
    var dataSource: UICollectionViewDiffableDataSource<Section, SFSymbolItem>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, SFSymbolItem>!
    
    let dataItems: [SFSymbolItem] = [
        SFSymbolItem(name: "drop"),
        SFSymbolItem(name: "flame"),
        SFSymbolItem(name: "bolt"),
        SFSymbolItem(name: "allergens"),
        SFSymbolItem(name: "ladybug"),
    ]
    
    enum Section {
        case main
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = makeDataSource()
        applyDataSource()
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func makeDataSource( ) -> UICollectionViewDiffableDataSource<Section, SFSymbolItem> {
        let cellRegistration = UICollectionView.CellRegistration<NewEntryViewCell, SFSymbolItem> { (cell, indexPath, item) in
            cell.backgroundColor = .lightGray
            cell.titleLabel.text = item.name
            cell.imageView.image = item.image
        }
        
        return UICollectionViewDiffableDataSource<Section, SFSymbolItem>(collectionView: collectionView) {
            collectionView, indexPath, identifier in
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
                cell.modalDelegate = self
                print(cell.frame, cell.bounds)
                return cell
        }
    }
    
    func applyDataSource() {
        // Create a snapshot that define the current state of data source's data
        snapshot = NSDiffableDataSourceSnapshot<Section, SFSymbolItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dataItems, toSection: .main)

        // Display data in the collection view by applying the snapshot to data source
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}


extension NewEntryViewController: ModalViewContollerDelegate {
    
    func presentViewController() {
        let viewController = ModalViewContoller()
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: false)
    }

}
