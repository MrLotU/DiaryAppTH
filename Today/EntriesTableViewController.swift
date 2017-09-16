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
        let entry = Entry.entryWith(content: "Woah, I did a thing!")
        entry.addImage(UIImage(named: "icn_noimage")!)
//        entry.addLocation(CLLocation(latitude: 52.428842, longitude:  6.230866))
        entry.setState(.happy)
        entries.append(entry)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        
        self.title = dateFormatter.string(from: Date())
        
        self.tableView.reloadData()
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
        
        if totalHeight < 88 {
            return 88.0
        } else {
            return totalHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as! EntryTableViewCell
        let entry = entries[indexPath.row]
        
        cell.title = entry.title
        cell.content = entry.content
        cell.stateImage = entry.stateImage
        cell.thumbnailImage = entry.photoImage
        
        if let loc = entry.location {
            let location = loc.location
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
                guard let placemarks = placemarks else { return }
        
                let placemark = placemarks[0]
        
                guard let name = placemark.name, let city = placemark.locality, let area = placemark.administrativeArea else { return }
                        
                cell.location = "\(name), \(city), \(area)"
            }
        }
        
        return cell
    }
    
    // MARK: - Helper methods
    
    func heightForString(_ string:String, withWidth width: CGFloat, andFontSize size: CGFloat) -> CGFloat {
        let attributes: [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: size)]
        
        let attributedString: NSAttributedString = NSAttributedString(string: string, attributes: attributes)
        
        let rect: CGRect = attributedString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        return rect.height
    }
}
