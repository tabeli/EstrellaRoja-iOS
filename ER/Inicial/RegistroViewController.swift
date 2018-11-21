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
}

