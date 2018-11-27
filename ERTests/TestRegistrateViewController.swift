//
//  TestRegistrateViewController.swift
//  ERTests
//
//  Created by Tabatha Acosta on 11/27/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import XCTest
@testable import ER

class TestRegistrateViewController: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSucessRegister() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createAccount = storyboard.instantiateViewController(withIdentifier: "Registro") as! RegistroViewController
        let vue = createAccount.view
        
        createAccount.name.text = "Taba"
        createAccount.lastname.text = "Acosta"
        createAccount.email.text = "tabeli.acs@gmail.com"
        createAccount.pwd.text = "admin"
        createAccount.pwdRepetido.text = "admin"
        createAccount.postalCode.text = "7572"
        createAccount.birthdate.text = "07/09/1997"
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
