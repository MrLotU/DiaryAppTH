//
//  EntryFetchResultController.swift
//  Today
//
//  Created by Jari Koopman on 19/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import CoreData

class EntryFetchResultsController: NSFetchedResultsController<NSFetchRequestResult>, NSFetchedResultsControllerDelegate {
    fileprivate let tableView: UITableView
    
    init(fetchRequest: NSFetchRequest<NSFetchRequestResult>, managedObjectContext: NSManagedObjectContext, tableView: UITableView) {
        self.tableView = tableView
        
        super.init(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.delegate = self
        
        executeFetch()
    }
    
    func executeFetch() {
        do {
            try performFetch()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func performFetch(withPredicate predicate: NSPredicate?) {
        NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: nil)
        fetchRequest.predicate = predicate
        executeFetch()
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
