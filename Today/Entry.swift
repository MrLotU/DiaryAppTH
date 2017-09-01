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
    
    class func entryWith(_ content: String) -> Entry {
        let entry = NSEntityDescription.insertNewObject(forEntityName: Entry.entityName, into: CoreDataController.sharedInstance.managedObjectContext) as! Entry
        
        entry.content = content
        entry.date = Date().timeIntervalSince1970
        
        return entry
    }
    
    class func entryWith(_ content: String, image: UIImage) -> Entry {
        let entry = entryWith(content)
        
        entry.image = UIImageJPEGRepresentation(image, 1.0)!
        
        return entry
    }
    
    class func entryWith(_ content: String, location: CLLocation) -> Entry {
        let entry = entryWith(content)
        
        entry.location = Location.locationWith(location.coordinate.latitude, longtitude: location.coordinate.longitude)
        
        return entry
    }
    
    class func entryWith(_ content: String, location: CLLocation, image: UIImage) -> Entry {
        let entry = entryWith(content, image: image)
        entry.location = Location.locationWith(location.coordinate.latitude, longtitude: location.coordinate.longitude)
        return entry
    }
}

extension Entry {
    @NSManaged var content: String
    @NSManaged var date: TimeInterval
    @NSManaged var image: Data?
    @NSManaged var location: Location?
    
    var photoImage: UIImage {
        if (image != nil) {
            return UIImage(data: image!)!
        } else {
            return UIImage(named: "icn_noimage")!
        }
    }
}
