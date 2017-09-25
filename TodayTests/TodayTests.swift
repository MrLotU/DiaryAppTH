//
//  TodayTests.swift
//  TodayTests
//
//  Created by Jari Koopman on 27/08/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Today

class TodayTests: XCTestCase {
    
    var fakeEntry: Entry!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fakeEntry = Entry.entryWith(content: "Fake Entry 1")
        CoreDataController.save()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        CoreDataController.deleteAll()
        CoreDataController.save()
        super.tearDown()
    }
    
    func testEntryCreation() {
        XCTAssertNotNil(fakeEntry, "Entry is NIL - Creation failed!")
    }
    
    func testEntryInsertion() {
        Entry.entryWith("Fake Entry 2", location: nil, image: nil, state: nil)
        CoreDataController.save()
        XCTAssert(CoreDataController.sharedInstance.managedObjectContext.registeredObjects.count == 2, "we have more or less than 2 entries")
    }
    
    func testEntryDeletion() {
        CoreDataController.sharedInstance.managedObjectContext.delete(fakeEntry)
        XCTAssert(fakeEntry.isDeleted, "Entry is not DELETED - Deletion failed!")
    }
    
    func testEntryEditting() {
        
    }
}
