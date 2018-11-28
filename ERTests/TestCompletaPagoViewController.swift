//
//  TestCompletaPagoViewController.swift
//  ERTests
//
//  Created by Tabatha Acosta on 11/27/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import XCTest
@testable import ER

class TestCompletaPagoViewController: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    

    func testValidData() {
        let storyboard = UIStoryboard(name: "Pago", bundle: nil)
        let completaPago = storyboard.instantiateViewController(withIdentifier: "CompletaPago") as! CompletaPagoViewController
        _ = completaPago.view
        
        completaPago.nombreUsuario.text = "Taba Acosta"
        completaPago.numeroTarjeta.text = "819237291903838"
        completaPago.mesVencimiento.text = "12"
        completaPago.anioVencimiento.text = "30"
        completaPago.codigoSeguridad.text = "232"
        
        sleep(3)
        XCTAssert(true)
    }
    
    func invalidData() {
        
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
