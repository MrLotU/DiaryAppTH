//
//  EntryDataSource.swift
//  Today
//
//  Created by Jari Koopman on 19/09/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import CoreLocation

class EntryDataSource: NSObject {
    fileprivate let tableView: UITableView
    fileprivate let managedObjectContext = CoreDataController.sharedInstance.managedObjectContext
    fileprivate let fetchedResultsController: EntryFetchResultsController
    
    init(fetchRequest: NSFetchRequest<NSFetchRequestResult>, tableView: UITableView) {
        self.tableView = tableView
        
        self.fetchedResultsController = EntryFetchResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, tableView: self.tableView)
        
        super.init()
    }
    
    func performFetch(withPredicate predicate: NSPredicate?) {
        self.fetchedResultsController.performFetch(withPredicate: predicate)
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate

extension EntryDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let entry = fetchedResultsController.object(at: indexPath) as! Entry
        
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
    
    func heightForString(_ string:String, withWidth width: CGFloat, andFontSize size: CGFloat) -> CGFloat {
        let attributes: [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: size)]
        
        let attributedString: NSAttributedString = NSAttributedString(string: string, attributes: attributes)
        
        let rect: CGRect = attributedString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        return rect.height
    }
}

//MARK: - UITableViewDataSource

extension EntryDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as! EntryTableViewCell
        let entry = fetchedResultsController.object(at: indexPath) as! Entry
        cell.isSelected = false
        
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

}
