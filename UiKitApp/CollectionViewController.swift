//
//  CollectionViewController.swift
//  UiKitApp
//
//  Created by Егор Пехота on 06.11.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
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
        
        //Register Cell
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SFSymbolItem> { (cell, indexPath, item) in
            
            // Define how data should be shown using content configuration
            var content = cell.defaultContentConfiguration()
            content.image = item.image
            content.text = item.name
            
            // Assign content configuration to cell
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, SFSymbolItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: SFSymbolItem) -> UICollectionViewCell? in
            
            // Dequeue reusable cell using cell registration (Reuse identifier no longer needed)
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            // Configure cell appearance
            cell.accessories = [.disclosureIndicator()]
            
            return cell
        }
        
        // Create a snapshot that define the current state of data source's data
        snapshot = NSDiffableDataSourceSnapshot<Section, SFSymbolItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dataItems, toSection: .main)

        // Display data in the collection view by applying the snapshot to data source
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
}
