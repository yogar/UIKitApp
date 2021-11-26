//
//  EntriesListViewController.swift
//  UiKitApp
//
//  Created by Егор Пехота on 23.11.2021.
//

import UIKit
import CoreData
import Combine

class EntriesListViewController: UICollectionViewController {
    let entriesProvider: EntriesProvider
    var dataSource: UICollectionViewDiffableDataSource<Int, NSManagedObjectID>!
    var cancellables = Set<AnyCancellable>()
    
    init(persistenceController: PersistenceController, collectionViewLayout: UICollectionViewLayout) {
        self.entriesProvider = EntriesProvider(controller: persistenceController)
        
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    override func viewDidLoad() {
        dataSource = makeDataSource()
        collectionView.dataSource = dataSource
        
        entriesProvider.$snapshot
            .sink(receiveValue: { [weak self] snapshot in
                if let snapshot = snapshot {
                    self?.dataSource.apply(snapshot)
                }
            })
            .store(in: &cancellables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Int, NSManagedObjectID> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, NSManagedObjectID> { [weak self] (cell, indexPath, item) in
            
            guard let entry = self?.entriesProvider.object(at: indexPath) else { return }
            
            var content = cell.defaultContentConfiguration()
            content.text = entry.situation
            cell.contentConfiguration = content
        }
        
        return UICollectionViewDiffableDataSource<Int, NSManagedObjectID>(collectionView: collectionView) { collectionView, indexPath, identifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }
}   
