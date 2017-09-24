//
//  Location.swift
//  Today
//
//  Created by Jari Koopman on 27/08/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class Location: NSManagedObject {
    static let entityName = "\(Location.self)"
    
    class func locationWith(_ lat: Double, andLong long: Double) -> Location {
        let location = NSEntityDescription.insertNewObject(forEntityName: Location.entityName, into: CoreDataController.sharedInstance.managedObjectContext) as! Location
        
        location.longtitude = long 
        location.lattitude = lat
        
        return location
    }
}

extension Location {
    @NSManaged var lattitude: Double
    @NSManaged var longtitude: Double
    
    var location: CLLocation {
        return CLLocation(latitude: lattitude, longitude: longtitude)
    }
}
