//
//  NewPostTableViewController.swift
//  Today
//
//  Created by Jari Koopman on 18/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class NewPostTableViewController: UITableViewController {
    
    lazy var dataSource: NewEntryDataSource = {
        return NewEntryDataSource(fetchRequest: Entry.allEntriesRequest, tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        self.navigationItem.setRightBarButton(barButtonItem, animated: false)
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
    }
    
    func doneButtonPressed() {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! NewEntryTableViewCell
        cell.saveContent()
        
        self.navigationController?.popViewController(animated: true)
    }
}
