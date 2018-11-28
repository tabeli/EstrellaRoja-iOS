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
        completaPago.numeroTarjeta.text = "81923729190"
        completaPago.mesVencimiento.text = "12"
        completaPago.anioVencimiento.text = "21"
        completaPago.codigoSeguridad.text = "232"
        
        sleep(3)
        XCTAssert(true)
    }
    
    func testInvalidName() {
        let storyboard = UIStoryboard(name: "Pago", bundle: nil)
        let tryUsername = storyboard.instantiateViewController(withIdentifier: "CompletaPago") as! CompletaPagoViewController
        _ = tryUsername.view
            
        XCTAssertFalse(tryUsername.verifyUsernameInput(usernameStr: "Admin"))
        XCTAssertTrue(tryUsername.verifyUsernameInput(usernameStr: "Taba Acosta"))
        
    }
    
    func testInvalidCardNumber() {
        let storyboard = UIStoryboard(name: "Pago", bundle: nil)
        let tryCardNumber = storyboard.instantiateViewController(withIdentifier: "CompletaPago") as! CompletaPagoViewController
        _ = tryCardNumber.view
        
        XCTAssertFalse(tryCardNumber.verifyCardNumberInput(cardnumberStr: "8192372919089120"))
        XCTAssert(true, "Tarjeta Inválida")
        XCTAssertTrue(tryCardNumber.verifyCardNumberInput(cardnumberStr: "81923729190"))
        
    }
    
    func testInvalidMesVencimiento() {
        let storyboard = UIStoryboard(name: "Pago", bundle: nil)
        let tryMesVencimiento = storyboard.instantiateViewController(withIdentifier: "CompletaPago") as! CompletaPagoViewController
        _ = tryMesVencimiento.view
        
        XCTAssertFalse(tryMesVencimiento.verifyMesVencimientoInput(mesVencimiento: "091"))
        XCTAssertTrue(tryMesVencimiento.verifyMesVencimientoInput(mesVencimiento: "02"))
        
    }
    
    func testInvalidAnioVencimiento() {
        let storyboard = UIStoryboard(name: "Pago", bundle: nil)
        let tryAnioVencimiento = storyboard.instantiateViewController(withIdentifier: "CompletaPago") as! CompletaPagoViewController
        _ = tryAnioVencimiento.view
        
        XCTAssertFalse(tryAnioVencimiento.verifyAnioVencimientoInput(anioVencimiento: "091"))
        XCTAssertTrue(tryAnioVencimiento.verifyAnioVencimientoInput(anioVencimiento: "02"))
    }
    
    func testVerifySecurecode() {
        let storyboard = UIStoryboard(name: "Pago", bundle: nil)
        let trySecurecode = storyboard.instantiateViewController(withIdentifier: "CompletaPago") as! CompletaPagoViewController
        _ = trySecurecode.view
        
        XCTAssertFalse(trySecurecode.verifySecureCodeInput(secureCode: "33333"))
        XCTAssert(true, "Código de seguridad inválido")
        XCTAssertTrue(trySecurecode.verifySecureCodeInput(secureCode: "323"))
    }
    
    func testCheckIfEmptyFields() {
        let storyboard = UIStoryboard(name: "Pago", bundle: nil)
        let completaPago = storyboard.instantiateViewController(withIdentifier: "CompletaPago") as! CompletaPagoViewController
        _ = completaPago.view
        
        completaPago.nombreUsuario.text = ""
        completaPago.numeroTarjeta.text = ""
        completaPago.mesVencimiento.text = "12"
        completaPago.anioVencimiento.text = "21"
        completaPago.codigoSeguridad.text = ""
        completaPago.siguienteAction(UIButton())
        
        XCTAssert(true, "Datos faltantes")
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
