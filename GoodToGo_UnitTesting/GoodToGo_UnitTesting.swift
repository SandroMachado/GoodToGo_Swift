//
//  GoodToGo_UnitTesting.swift
//  GoodToGo_UnitTesting
//
//  Created by Ricardo Santos on 15/03/16.
//  Copyright © 2016 Ricardo Santos. All rights reserved.
//

import XCTest

import UIKit // http://mathijskadijk.nl/post/101529113209/the-bundle-couldnt-be-loaded-because-it-is

class GoodToGo_UnitTesting: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        if(true) {
            // Put setup code here. This method is called before the invocation of each test method in the class.
            
            // In UI tests it is usually best to stop immediately when a failure occurs.
            continueAfterFailure = false
            // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
            XCUIApplication().launch()
            
            // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        }

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample1() {
        XCTAssertEqual(true, true, "asd")
    }
    
    
}
