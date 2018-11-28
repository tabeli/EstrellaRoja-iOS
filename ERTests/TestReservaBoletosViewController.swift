//
//  TestReservaBoletosViewController.swift
//  ERTests
//
//  Created by Tabatha Acosta on 11/27/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import XCTest
@testable import ER

class TestReservaBoletosViewController: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulReservaBoleto() {
        let storyboard = UIStoryboard(name: "Ruta", bundle: nil)
        let firstBuy = storyboard.instantiateViewController(withIdentifier: "CompraUno") as! CompraUnoReservaBoletosViewController
        _ = firstBuy.view
        
        firstBuy.eligeFecha.text = "23/12/2018"
        firstBuy.eligeHora.text = "08:00"
        
        sleep(3)
        XCTAssert(true)
    }
    
    func testRejectedReservaBoleto() {
        
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
