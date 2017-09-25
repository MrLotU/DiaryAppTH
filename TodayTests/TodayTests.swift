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
    
    var entry: Entry!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        entry = MockEntry.mockEntryWith("Some content", location: CLLocation(), image: UIImage(), state: .none)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEntryCreation() {
        
        XCTAssertNotNil(entry, "Entry is NIL - Creation failed!")
    }
    
    func testEntryDeletion() {
        
    }
    
    func testEntryEditting() {
        
    }
    
    class MockEntry: Entry {
        class func mockEntryWith(_ content: String, location: CLLocation?, image: UIImage?, state: EntryState?) -> Entry {
            let entry = MockEntry.entryWith(content: content)
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
    }
    
}
