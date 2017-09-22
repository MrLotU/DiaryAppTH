//
//  EntriesTableViewController.swift
//  Today
//
//  Created by Jari Koopman on 01/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import CoreLocation

class EntriesTableViewController: UITableViewController {
    
    lazy var dataSource: EntryDataSource = {
        return EntryDataSource(fetchRequest: Entry.allEntriesRequest, tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
        
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "icn_write"), style: .plain, target: self, action: #selector(newPostButtonPressed))
        
        self.navigationItem.setRightBarButton(barButtonItem, animated: false)
        
        for _ in 1...10 {
            _ = Entry.entryWith(content: "Woah! Some content! That's pretty cool eh? Now, let's add some more so that it will spread over multiple lines.")
        }
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        
        self.title = dateFormatter.string(from: Date())
    }

    // MARK: - Helper methods
    
    func newPostButtonPressed() {
        performSegue(withIdentifier: "createNewPost", sender: nil)
    }
}
