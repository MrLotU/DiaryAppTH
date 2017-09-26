//
//  TodayTests.swift
//  TodayTests
//
//  Created by Jari Koopman on 27/08/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import XCTest
import CoreLocation
import CoreData
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
        super.tearDown()
    }
    
    func testEntryCreation() {
        XCTAssertNotNil(fakeEntry, "Entry is NIL - Creation failed!")
    }
    
    func testEntryInsertion() {
        var results: [Any] = []
        do {
            results = try CoreDataController.sharedInstance.managedObjectContext.fetch(Entry.allEntriesRequest)
        } catch {
            XCTAssert(false, "Getting results failed!")
        }
        let entriesCount = results.count
        Entry.entryWith("Fake Entry 2", location: nil, image: nil, state: nil)
        do {
            results = try CoreDataController.sharedInstance.managedObjectContext.fetch(Entry.allEntriesRequest)
        } catch {
            XCTAssert(false, "Getting results failed!")
        }
        let newEntriesCount = results.count
        print("NewEntriesCount: \(newEntriesCount), oldEntriesCount: \(entriesCount), subtracted: \(newEntriesCount - entriesCount)")
        XCTAssert(newEntriesCount - entriesCount == 1, "More than 1 new entry got added to the ManagedObjectContext")
    }
    
    func testEntryDeletion() {
        CoreDataController.sharedInstance.managedObjectContext.delete(fakeEntry)
        XCTAssert(fakeEntry.isDeleted, "Entry is not DELETED - Deletion failed!")
    }
    
    func testEntryEditting() {
        fakeEntry.content = "Some new content -- Entry is now edited!"
        XCTAssert(fakeEntry.content == "Some new content -- Entry is now edited!", "Entry was not sucessfully edited or was edited to the wrong content")
    }
}
