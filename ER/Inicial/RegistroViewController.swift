//
//  RegistroViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var pwdRepetido: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    @IBOutlet weak var phonenumber: UITextField!

    var nombre = ""
    var apellido = ""
    var correo = ""
    var contrasena = ""
    var codigoPostal = ""
    var fecha = Date()
    var numeroTelefono = ""
    
    @IBOutlet weak var registrate: UIButton!
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registrateAction(_ sender: UIButton) {
        performSegue(withIdentifier: "RutaMenuSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crearToolbar()
        eligeFechaNacimientoPicker()
        name.adjustsFontSizeToFitWidth = true
        lastname.adjustsFontSizeToFitWidth = true
        email.adjustsFontSizeToFitWidth = true
        pwd.adjustsFontSizeToFitWidth = true
        pwdRepetido.adjustsFontSizeToFitWidth = true
        postalCode.adjustsFontSizeToFitWidth = true
        birthdate.adjustsFontSizeToFitWidth = true
        
        phonenumber.adjustsFontSizeToFitWidth = true
        registrate.titleLabel?.adjustsFontSizeToFitWidth = true
        registrate.layer.cornerRadius = 15
        registrate.layer.borderWidth = 2
        registrate.layer.borderColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
        
        name.keyboardType = .alphabet
        name.autocapitalizationType = .words
        name.returnKeyType = .done
        name.delegate = self
        
        lastname.keyboardType = .alphabet
        lastname.autocapitalizationType = .words
        lastname.returnKeyType = .done
        lastname.delegate = self
        
        email.keyboardType = .emailAddress
        email.autocapitalizationType = .words
        email.returnKeyType = .done
        email.delegate = self
        
        pwd.keyboardType = .alphabet
        pwd.isSecureTextEntry = true
        pwd.returnKeyType = .done
        pwd.delegate = self
        
        pwdRepetido.keyboardType = .alphabet
        pwdRepetido.isSecureTextEntry = true
        pwdRepetido.returnKeyType = .done
        pwdRepetido.delegate = self
        
        postalCode.keyboardType = .numberPad
        postalCode.delegate = self
        
        phonenumber.keyboardType = .numberPad
        phonenumber.delegate = self
        
        birthdate.delegate = self
     
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    
    }
    
    func eligeFechaNacimientoPicker() {
        let fechaNacimientoPicker = UIDatePicker()
        fechaNacimientoPicker.datePickerMode = .date
        birthdate.inputView = fechaNacimientoPicker
        fechaNacimientoPicker.addTarget(self, action: #selector(RegistroViewController.dataChanged(fechaNacimientoPicker:)), for: .valueChanged)
        fechaNacimientoPicker.backgroundColor = .white
    }
    
    func crearToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        
        let doneButton = UIBarButtonItem(title: "Listo", style: .plain, target: self, action: #selector(RegistroViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        birthdate.inputAccessoryView = toolBar
        postalCode.inputAccessoryView = toolBar
        phonenumber.inputAccessoryView = toolBar
    }
    @objc func dataChanged(fechaNacimientoPicker: UIDatePicker){
        let formatoFecha = DateFormatter()
        formatoFecha.dateFormat = "dd/MM/yyyy"
        birthdate.text = formatoFecha.string(from: fechaNacimientoPicker.date)
        
        //let weekday = Calendar.current.component(.weekday, from: myDate)
        
        fecha = fechaNacimientoPicker.date
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RegistroViewController: UITextFieldDelegate {
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

