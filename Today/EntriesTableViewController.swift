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
    
    var entries: [Entry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //TODO: Actually make this work with sorting entries into months
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Actually make this work with sorting entries into months
        return entries.count
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as! EntryTableViewCell
//        
//        let marginHeights: CGFloat = 37.0
//        let titleHeight = cell.titleLabel.frame.height
//        let contentHeight = cell.contentLabel.frame.height
//        let locationHeight = cell.locationlabel.frame.height
//        
//        let totalHeight = marginHeights + titleHeight + contentHeight + locationHeight
//        
//        if totalHeight < 100 {
//            return 100
//        } else {
//            return totalHeight
//        }
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as! EntryTableViewCell
        
        cell.title = Date().timeIntervalSince1970.debugDescription
        cell.content = "Hi! This is some content"
        cell.stateImage = UIImage(named: "icn_happy")
        cell.thumbnailImage = UIImage(named: "icn_noimage")
        cell.location = CLLocation(latitude: 100, longitude: 100)
        
        return cell
    }
}
