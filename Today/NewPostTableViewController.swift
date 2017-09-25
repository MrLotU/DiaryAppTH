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
        return NewEntryDataSource(fetchRequest: Entry.allEntriesRequest, tableView: self.tableView, controller: self)
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
        cell.saveContent() { message in
            let alert = UIAlertController(title: "Something went wrong!", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPost" {
            let destVC = segue.destination as! EditPostTableViewController
            destVC.entry = sender as! Entry
        }
    }
}









