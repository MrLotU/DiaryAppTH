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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let entry = entries[indexPath.row]
        
        let marginHeights: CGFloat = 37.0
        let titleHeight = heightForString(entry.title, withWidth: 283.0, andFontSize: 18.0)
        let contentHeight = heightForString(entry.content, withWidth: 283.0, andFontSize: 17.0)
        var locationHeight: CGFloat = 0
        if entry.location != nil {
            locationHeight = heightForString("\(entry.location!.location)", withWidth: 250.0, andFontSize: 17.0)
        }

        let totalHeight = marginHeights + titleHeight + contentHeight + locationHeight
        
        return totalHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as! EntryTableViewCell
        let entry = entries[indexPath.row]
        
        cell.title = entry.title
        cell.content = entry.title
        cell.stateImage = entry.stateImage
        cell.thumbnailImage = entry.photoImage
        cell.location = CLLocation(latitude: 100, longitude: 100)
        
        return cell
    }
    
    // MARK: Helper methods
    
    func heightForString(_ string:String, withWidth width: CGFloat, andFontSize size: CGFloat) -> CGFloat {
        let attributes: [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: size)]
        
        let attributedString: NSAttributedString = NSAttributedString(string: string, attributes: attributes)
        
        let rect: CGRect = attributedString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        return rect.height
    }
}
