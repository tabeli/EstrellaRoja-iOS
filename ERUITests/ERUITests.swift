//
//  ERUITests.swift
//  ERUITests
//
//  Created by Tabatha Acosta on 11/27/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import XCTest
@testable import ER

class ERUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuccessfulOperation() {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.button, identifier:"Acepto terminos y condiciones")/*[[".cells.containing(.button, identifier:\"Siguiente\")",".cells.containing(.button, identifier:\"Acepto terminos y condiciones\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .button).element(boundBy: 0).tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).tap()
        app.buttons["Siguiente"].tap()
        //algo
    }
    
    func testGoToMap() {
        
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
