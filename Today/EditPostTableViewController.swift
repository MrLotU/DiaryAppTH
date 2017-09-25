//
//  EditPostTableViewController.swift
//  Today
//
//  Created by Jari Koopman on 24/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class EditPostTableViewController: UITableViewController {
    
    var entry: Entry!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneButtonPressed() {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EditEntryTableViewCell
        cell.updateContent() { message in
            let alert = UIAlertController(title: "Something went wrong!", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true)
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editEntryCell", for: indexPath) as! EditEntryTableViewCell
        
        
        
        return cell
    }
}
