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
        
        return entry
    }
    
    func addImage(_ image: UIImage) {
        self.image = UIImageJPEGRepresentation(image, 1.0)
    }
    
//    class func entryWith(_ content: String, image: UIImage) -> Entry {
//        let entry = entryWith(content)
//        
//        entry.image = UIImageJPEGRepresentation(image, 1.0)!
//        
//        return entry
//    }
    
    func addLocation(_ location: CLLocation) {
        self.location = Location.locationWith(location.coordinate.latitude, andLong: location.coordinate.longitude)
    }
    
//    class func entryWith(_ content: String, location: CLLocation) -> Entry {
//        let entry = entryWith(content)
//        
//        entry.location = Location.locationWith(location.coordinate.latitude, andLong: location.coordinate.longitude)
//        
//        return entry
//    }
    
//    class func entryWith(_ content: String, location: CLLocation, image: UIImage) -> Entry {
//        let entry = entryWith(content, image: image)
//        entry.location = Location.locationWith(location.coordinate.latitude, andLong: location.coordinate.longitude)
//        return entry
//    }
    
    class func entryWith(_ content: String, location: CLLocation?, image: UIImage?, state: EntryState?) -> Entry {
        let entry = entryWith(content: content)
        if let loc = location {
            entry.addLocation(loc)
        }
        if let image = image {
            entry.addImage(image)
        }
        if let state = state {
            entry.setState(state)
        }
        return entry
    }
    
    func setState(_ state: EntryState) {
        self.state = state.rawValue
    }
    
}

// MARK: - Variables and CoreData
extension Entry {
    
    enum EntryState: String {
        case happy = "Happy"
        case bad = "Bad"
        case average = "Average"
        case none = "none"
    }
    
    @NSManaged var content: String
    @NSManaged var date: Date
    @NSManaged var image: Data?
    @NSManaged var location: Location?
    @NSManaged var title: String
    @NSManaged var state: String
    
    
//    func getLocationString() {
//        guard let loc = self.location else {
//            return
//        }
//        let location = loc.location
//        let geoCoder = CLGeocoder()
//        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
//            guard let placemarks = placemarks else { return }
//            
//            let placemark = placemarks[0]
//            
//            guard let name = placemark.name, let city = placemark.locality, let area = placemark.administrativeArea else { return }
//            
//            let locationString = "\(name), \(city), \(area)"
//        }
//    }
    
    var stateValue: EntryState {
        get { return EntryState(rawValue: self.state) ?? .none }
//        set { self.state = stateValue.rawValue }
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
