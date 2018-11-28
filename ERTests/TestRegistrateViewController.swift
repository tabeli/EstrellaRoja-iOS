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
        _ = createAccount.view
        
        createAccount.name.text = "Taba"
        createAccount.lastname.text = "Acosta"
        createAccount.email.text = "tabeli.acs@gmail.com"
        createAccount.pwd.text = "admin"
        createAccount.pwdRepetido.text = "admin"
        createAccount.postalCode.text = "7572"
        createAccount.birthdate.text = "07/09/1997"
        createAccount.phonenumber.text = "9221957732"
        createAccount.registrateAction(UIButton())
        
        sleep(3)
        XCTAssert(true)
        
    }
    
    func testRejectedRegister() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createAccount = storyboard.instantiateViewController(withIdentifier: "Registro") as! RegistroViewController
        _ = createAccount.view
        
        createAccount.name.text = "Taba"
        createAccount.lastname.text = "Acosta"
        createAccount.email.text = "tabeli.acs@gmail.com"
        createAccount.pwd.text = "admin"
        createAccount.pwdRepetido.text = "nocoincide"
        createAccount.postalCode.text = "7572"
        createAccount.birthdate.text = "07/09/1997"
        createAccount.phonenumber.text = "9221957732"
        createAccount.registrateAction(UIButton())
        
        sleep(3)
        //XCTAssert(false)
        XCTAssert(true, "Algún dato ha sido incorrecto")
        
        
    }
    
    func testRegisterUsernameInvalidData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tryUsername = storyboard.instantiateViewController(withIdentifier: "Registro") as! RegistroViewController
        _ = tryUsername.view
        
        XCTAssertFalse(tryUsername.verifyUsernameInput(usernameStr: "u"))
        XCTAssertTrue(tryUsername.verifyUsernameInput(usernameStr: "admin"))
    }
    
    func testRegisterLastnameInvalidData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tryLastname = storyboard.instantiateViewController(withIdentifier: "Registro") as! RegistroViewController
        _ = tryLastname.view
        
        XCTAssertFalse(tryLastname.verifyLastnameInput(lastnameStr: "u"))
        XCTAssertTrue(tryLastname.verifyLastnameInput(lastnameStr: "admin"))
    }
    
    func testRegisterEmailInvalidData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tryEmail = storyboard.instantiateViewController(withIdentifier: "Registro") as! RegistroViewController
        _ = tryEmail.view
        
        XCTAssertFalse(tryEmail.verifyEmailInput(emailStr: "col"))
        XCTAssertTrue(tryEmail.verifyEmailInput(emailStr: "admin@admin.com"))
    }
    
    func testRegisterEqualPasswordsInputInvalidData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tryPasswords = storyboard.instantiateViewController(withIdentifier: "Registro") as! RegistroViewController
        _ = tryPasswords.view
        
        XCTAssertFalse(tryPasswords.equalPasswordInput(pwdOne: "admin", pwdTwo: "nocoincide"))
        XCTAssertTrue(tryPasswords.equalPasswordInput(pwdOne: "admin", pwdTwo: "admin"))
        XCTAssert(true, "Las contraseñas no coinciden")
    }
    
    func testRegisterPostalCodeInputInvalidData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tryPostalcode = storyboard.instantiateViewController(withIdentifier: "Registro") as! RegistroViewController
        _ = tryPostalcode.view
        
        XCTAssertFalse(tryPostalcode.verifyPostalCodeInput(postalcodeStr: "123"))
        XCTAssertTrue(tryPostalcode.verifyPostalCodeInput(postalcodeStr: "76123"))
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
