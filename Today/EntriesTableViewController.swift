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
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icn_write"), for: .normal)
        button.addTarget(self, action: #selector(newPostButtonPressed), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        
        self.navigationItem.setRightBarButton(barButtonItem, animated: false)
        
        for _ in 1...10 {
            Entry.entryWith("Woah! Some content! That's pretty cool eh? Now, let's add some more so that it will spread over multiple lines.", location: nil, image: nil, state: nil)
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
