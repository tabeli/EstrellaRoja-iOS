//
//  TestNumeroPasajerosViewController.swift
//  ERTests
//
//  Created by Tabatha Acosta on 11/27/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import XCTest
@testable import ER

class TestNumeroPasajerosViewController: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuccessNumberPassenger() {
        let storyboard = UIStoryboard(name: "Pago", bundle: nil)
        let passengerNumber = storyboard.instantiateViewController(withIdentifier: "CompraDos") as! DosSeleccionaPasajerosViewController
        _ = passengerNumber.view
        
        passengerNumber.adulto.text = "2"
        passengerNumber.nino.text = "2"
        passengerNumber.inapam.text = "2"
        
        sleep(3)
        XCTAssert(true)
    }

    func testRejectNumberPassenger() {
        
    }
    
    /*func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
