//
//  Entry.swift
//  Today
//
//  Created by Jari Koopman on 27/08/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import CoreLocation

class Entry: NSManagedObject {
    static let entityName = "\(Entry.self)"
    
    static var allEntriesRequest: NSFetchRequest = { () -> NSFetchRequest<NSFetchRequestResult> in
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entry.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }()
    
    class func entryWith(content: String) -> Entry {
        let entry = NSEntityDescription.insertNewObject(forEntityName: Entry.entityName, into: CoreDataController.sharedInstance.managedObjectContext) as! Entry
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d, yyyy"
        
        entry.content = content
        entry.date = Date()
        entry.title = dateFormatter.string(from: entry.date)
        entry.addImage(UIImage(named: "icn_noimage")!)
        entry.addLocation(CLLocation())
        entry.setState(.none)
        return entry
    }
    
    class func entryWith(_ content: String, location: CLLocation?, image: UIImage?, state: EntryState?) {
        let entry = entryWith(content: content)
        if let loc = location {
            entry.addLocation(loc)
        }
        if let image = image {
            entry.addImage(image)
        } else {
            entry.addImage(UIImage(named: "icn_noimage")!)
        }
        if let state = state {
            entry.setState(state)
        }
    }
}

// MARK: - Variables and CoreData
extension Entry {
    
    // MARK: Entry state enum
    enum EntryState: String {
        case happy = "Happy"
        case bad = "Bad"
        case average = "Average"
        case none = "none"
    }
    
    // MARK: Managed vars
    @NSManaged var content: String
    @NSManaged var date: Date
    @NSManaged var image: Data?
    @NSManaged var location: Location?
    @NSManaged var title: String
    @NSManaged var state: String

    // MARK: Functions
    func setState(_ state: EntryState) {
        self.state = state.rawValue
    }
    
    func addLocation(_ location: CLLocation) {
        self.location = Location.locationWith(location.coordinate.latitude, andLong: location.coordinate.longitude)
    }
    
    func addImage(_ image: UIImage) {
        self.image = UIImageJPEGRepresentation(image, 1.0)
    }
    
    //MARK: Helper vars
    var stateValue: EntryState {
        get { return EntryState(rawValue: self.state) ?? .none }
        set { self.state = stateValue.rawValue }
    }
    
    var stateImage: UIImage? {
        switch self.stateValue {
        case .happy: return UIImage(named: "icn_happy")
        case .bad: return UIImage(named: "icn_bad")
        case .average: return UIImage(named: "icn_average")
        default: return nil
        }
    }
    
    var photoImage: UIImage {
        if (image != nil) {
            return UIImage(data: image!)!
        } else {
            return UIImage(named: "icn_noimage")!
        }
    }
}
