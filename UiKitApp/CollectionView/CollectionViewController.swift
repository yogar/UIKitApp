//
//  CollectionViewController.swift
//  UiKitApp
//
//  Created by Егор Пехота on 06.11.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    let persistenceController: PersistenceController
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
    
    init(collectionViewLayout layout: UICollectionViewLayout, persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        applyDataSource()
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func registerListCell() {
        //Register Cell
        let listCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SFSymbolItem> { (cell, indexPath, item) in
            
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
            let cell = collectionView.dequeueConfiguredReusableCell(using: listCellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            // Configure cell appearance
            cell.accessories = [.disclosureIndicator()]
            
            return cell
        }
    }
    
    func registerCell() {
        let cellRegistration = UICollectionView.CellRegistration<CollectionViewCell, SFSymbolItem> { (cell, indexPath, item) in
            cell.backgroundColor = .lightGray
            cell.titleLabel.text = item.name
            cell.imageView.image = item.image
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, SFSymbolItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: SFSymbolItem) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            cell.modalDelegate = self
            cell.pin(to: collectionView)
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


extension CollectionViewController: ModalViewContollerDelegate {
    
    func presentViewController() {
        let viewController = ModalViewContoller()
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: false)
    }

}

extension CollectionViewController {
    

}
