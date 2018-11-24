//
//  CompletaPagoViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/14/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class CompletaPagoViewController: UIViewController {

    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var uno: UIButton!
    @IBOutlet weak var siguienteOutlet: UIButton!
   
    @IBOutlet weak var nombreUsuario: UITextField!
    @IBOutlet weak var numeroTarjeta: UITextField!
    @IBOutlet weak var mesVencimiento: UITextField!
    @IBOutlet weak var anioVencimiento: UITextField!
    @IBOutlet weak var codigoSeguridad: UITextField!
    
    var idRuta = 0
    
    @IBOutlet var pagosOutlet: [UIButton]!
    
    @IBAction func choosePayment(_ sender: UIButton) {
        for button in pagosOutlet {
            button.backgroundColor = .clear
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 2
            button.layer.borderColor = #colorLiteral(red: 0.786775421, green: 0.1943393403, blue: 0.1217412519, alpha: 1)
        }
        sender.backgroundColor = #colorLiteral(red: 0.786775421, green: 0.1943393403, blue: 0.1217412519, alpha: 1)
    }
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func siguienteAction(_ sender: UIButton) {
        UserDefaults.standard.set(idRuta, forKey: "idRuta")
        
        performSegue(withIdentifier: "RutaDesbloqueadaSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crearToolbar()
        for button in pagosOutlet {
            button.backgroundColor = .clear
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 2
            button.layer.borderColor = #colorLiteral(red: 0.786775421, green: 0.1943393403, blue: 0.1217412519, alpha: 1)
        }
        
        topTitle.adjustsFontSizeToFitWidth = true
        uno.layer.cornerRadius = 15
        uno.titleLabel?.adjustsFontSizeToFitWidth = true
        siguienteOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        siguienteOutlet.layer.cornerRadius = 15
        siguienteOutlet.layer.borderWidth = 2
        siguienteOutlet.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
        // Do any additional setup after loading the view.
        
        nombreUsuario.keyboardType = .alphabet
        nombreUsuario.autocapitalizationType = .words
        nombreUsuario.returnKeyType = .done
        nombreUsuario.delegate = self
        
        numeroTarjeta.keyboardType = .numberPad
        numeroTarjeta.delegate = self
        
        mesVencimiento.keyboardType = .numberPad
        mesVencimiento.delegate = self
        
        anioVencimiento.keyboardType = .numberPad
        anioVencimiento.delegate = self
        
        codigoSeguridad.keyboardType = .numberPad
        codigoSeguridad.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    func crearToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        
        let doneButton = UIBarButtonItem(title: "Listo", style: .plain, target: self, action: #selector(CompletaPagoViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        numeroTarjeta.inputAccessoryView = toolBar
        mesVencimiento.inputAccessoryView = toolBar
        anioVencimiento.inputAccessoryView = toolBar
        codigoSeguridad.inputAccessoryView = toolBar
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    #warning("Hay que ver un video de como arreglar el paso de datos hacia un Tab Bar Controller")
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RutaDesbloqueadaSegue"{
            let vc = segue.destination as! MuestraRutaActualViewController
            vc.idRuta = self.idRuta
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }*/
    

}

extension CompletaPagoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboard = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue) else { return }
        var textField: UITextField!
        
        for field in self.view.subviews{
            if field.isFirstResponder {
                if let fieldTemp = field as? UITextField {
                    textField = fieldTemp
                }
            }
        }
        if textField != nil {
            let highestDotOfTextField = textField.frame.maxY
            var keyboardCoordinate = self.view.frame.maxY - keyboard.cgRectValue.height
            if let accesoryView = textField.inputAccessoryView {
                keyboardCoordinate -= accesoryView.frame.height
            }
            if highestDotOfTextField > keyboardCoordinate {
                let diff = highestDotOfTextField - keyboardCoordinate
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= diff
                }
            }
        }
        
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
