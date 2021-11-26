//
//  EntriesListViewController.swift
//  UiKitApp
//
//  Created by Егор Пехота on 23.11.2021.
//

import UIKit
import CoreData
import Combine

class EntriesListViewController: UIViewController {
    let entryProvider: EntryProvider
    var dataSource: UICollectionViewDiffableDataSource<Int, NSManagedObjectID>!
    var cancellables = Set<AnyCancellable>()
    
    init(entryProvider: EntryProvider) {
        self.entryProvider = entryProvider
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
