//
//  EntryProvider.swift
//  UiKitApp
//
//  Created by Егор Пехота on 23.11.2021.
//

import Foundation
import CoreData
import UIKit

class EntriesProvider: NSObject {
    let controller: PersistenceController
    
    fileprivate let fetchedResultsController: NSFetchedResultsController<Entry>
    @Published var snapshot: NSDiffableDataSourceSnapshot<Int,NSManagedObjectID>?
    
    init(controller: PersistenceController) {
        self.controller = controller
        
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Entry.date, ascending: false)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: controller.containter.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        super.init()
        
        fetchedResultsController.delegate = self
        try! fetchedResultsController.performFetch()
    }
    
    func object(at indexPath: IndexPath) -> Entry {
        return fetchedResultsController.object(at: indexPath)
    }
    
    func createEntry(situation: String) {
        let entry = Entry(context: controller.containter.viewContext)
        entry.situation = situation
        
        do {
            try controller.containter.viewContext.save()
            print("Entry created successfully")
        } catch let error {
            print("Failed to create entry: ", error.localizedDescription)
        }
    }
}

extension EntriesProvider: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        var newSnapshot = snapshot as NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>
        
        let idsToReload = newSnapshot.itemIdentifiers.filter({ identifier in
        // check if this identifier is in the old snapshot
        // and that it didn't move to a new position
        guard let oldIndex = self.snapshot?.indexOfItem(identifier),
              let newIndex = newSnapshot.indexOfItem(identifier),
              oldIndex == newIndex else { return false }
        
        // check if we need to update this object
        guard (try? controller.managedObjectContext.existingObject(with: identifier))?.isUpdated == true else { return false }
        
        return true
        })
        
        newSnapshot.reloadItems(idsToReload)
        self.snapshot = newSnapshot
    }
}


