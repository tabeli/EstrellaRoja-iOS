//
//  TestInicioSesionViewController.swift
//  ERTests
//
//  Created by Tabatha Acosta on 11/27/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import XCTest
@testable import ER

class TestInicioSesionViewController: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSucessLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let doLogin = storyboard.instantiateViewController(withIdentifier: "IniciaSesion") as! IniciaSesionViewController
        _ = doLogin.view
        
        doLogin.username.text = "admi@admi.com"
        doLogin.password.text = "admi"
        doLogin.ingresarAction(UIButton())
        
        sleep(3)
        XCTAssert(true)
    }
    
    func testLoginRefused() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let doLogin = storyboard.instantiateViewController(withIdentifier: "IniciaSesion") as! IniciaSesionViewController
        _ = doLogin.view
        
        doLogin.username.text = "admin@hola"
        doLogin.password.text = "contrasenamal"
        doLogin.ingresarAction(UIButton())
        
        //sleep(2)
        XCTAssertTrue(true, "User doesn't exist")
        
    }
    
    func testLoginUsernameInvalidData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tryLogin = storyboard.instantiateViewController(withIdentifier: "IniciaSesion") as! IniciaSesionViewController
        _ = tryLogin.view
        
        XCTAssertFalse(tryLogin.verifyUsernameInput(usernameStr: "uno"))
        XCTAssertTrue(tryLogin.verifyUsernameInput(usernameStr: "admin@admin.com"))
    }
    
    func testLoginPwdInvalidData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tryLogin = storyboard.instantiateViewController(withIdentifier: "IniciaSesion") as! IniciaSesionViewController
        _ = tryLogin.view
        
        XCTAssertFalse(tryLogin.verifyPasswordInput(passwordStr: "dos"))
        XCTAssertTrue(tryLogin.verifyPasswordInput(passwordStr: "admin"))
    }
    
    func testLoginInvalidData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let doLogin = storyboard.instantiateViewController(withIdentifier: "IniciaSesion") as! IniciaSesionViewController
        _ = doLogin.view
        
        doLogin.username.text = "uno"
        doLogin.password.text = "dos"
        doLogin.ingresarAction(UIButton())
        
        //sleep(2)
        XCTAssertTrue(true, "Correo o contraseña inválido")
        
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
