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
    
    lazy var dataSource: EntryDataSource = {
        return EntryDataSource(fetchRequest: Entry.allEntriesRequest, tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
        
        for _ in 1...10 {
            let entry = Entry.entryWith(content: "Woah! Some content! That's pretty cool eh? Now, let's add some more so that it will spread over multiple lines.")
//            entries.append(entry)
        }
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        
        self.title = dateFormatter.string(from: Date())
    }
    
    // MARK: - Table view delegate
    
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
        
        if totalHeight < 140.0 {
            return 140.0
        } else {
            return totalHeight
        }
    }
        
    // MARK: - Helper methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewPost" {
            let destVC = segue.destination as! NewPostTableViewController
            destVC.entries = self.entries
        }
    }
    
    func heightForString(_ string:String, withWidth width: CGFloat, andFontSize size: CGFloat) -> CGFloat {
        let attributes: [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: size)]
        
        let attributedString: NSAttributedString = NSAttributedString(string: string, attributes: attributes)
        
        let rect: CGRect = attributedString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        return rect.height
    }
}
