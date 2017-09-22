//
//  NewPostTableViewController.swift
//  Today
//
//  Created by Jari Koopman on 18/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class NewPostTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newEntryCell", for: indexPath)
        return cell
//        switch (indexPath.section, indexPath.row) {
//        case (0, 0):
//            let cell = tableView.dequeueReusableCell(withIdentifier: "newEntryCell", for: indexPath)
//            return cell
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
//            return cell
//        }
    }
}
