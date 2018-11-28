//
//  RegistroViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {
    var registerResult = false {
        didSet{ //checa cada vez que cambia el valor de loginResult para que cuando sea true realice el segue
            if(registerResult){
                performSegue(withIdentifier: "RutaMenuSegue", sender: nil)
            }
        }
    }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var pwdRepetido: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var birthdate: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    var hola: UserRegister!
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
        if self.verifyInputs() {
            registerRequest()
        }
        else{
            //Muestra alerta de que los inputs estan mal
            #warning("Implementar mostrar error de inputs")
        }
    }
    
    func verifyInputs() -> Bool {
        //Aqui verificar que la contraseña y el mail sean correctos
        if self.verifyUsernameInput(usernameStr: self.name.text!) && self.verifyLastnameInput(lastnameStr: self.lastname.text!) {
            
            return true
        }
        #warning("Implementar verificacion de inputs")
        
        return true
    }
    
    func verifyUsernameInput(usernameStr: String) -> Bool {
        return usernameStr.count > 1
    }
    
    func verifyLastnameInput(lastnameStr: String) -> Bool {
        return lastnameStr.count > 1
    }
    
    func verifyEmailInput(emailStr: String) -> Bool {
        return emailStr.count > 3
    }
    
    func equalPasswordInput(pwdOne: String, pwdTwo: String) -> Bool {
        return pwdOne == pwdTwo
    }
    
    func verifyPostalCodeInput(postalcodeStr: String) -> Bool {
        return postalcodeStr.count > 3
    }
    
    
    
    func registerRequest() {
        var requestResult = false // Pa' cambiar el registerResult y asegurar que todo termino
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.registerPath
        guard let url = urlComponents.url else { return } // guard para ver si se hace, si no, se muere el metodo
        var request = URLRequest(url: url) // Crea opeticion a partir del url
        request.httpMethod = "POST" // Le dices que tipo de metodo es
        var headers = request.allHTTPHeaderFields ?? [:] // Es como esto: x-www-form-urlencoded
        headers["Content-Type"] = "application/json" // Tiene que ser un json porque recibe un json
        request.allHTTPHeaderFields = headers // Se lo asignas el arreglo del url
        
        let usrRegister = UserRegister(name: name.text!, last_name: lastname.text!, email: email.text!, password: pwd.text!, postal_code: postalCode.text!, phone_number: phonenumber.text!, user_type: "client")
        //let jsonParams = ["name":name.text, "last_name":lastname.text, "email":email.text, "birthdate":birthdate.text, "password":pwd.text, "postal_code": postalCode.text, "phone_number":phonenumber.text]
        let encoder = JSONEncoder() // Instancias el encoder
        do {
            let jsonData = try encoder.encode(usrRegister)  // Lo encodea a tipo dato (lo parsea)
            request.httpBody = jsonData // Le metes el json parseado en la peticion
        } catch { return }
        //Esto inicia una task que ejecuta la peticion
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) {
            (data, response, error) in // Los datos que responde, response es la respuesta http completa, o el erroe
            guard error == nil else { //Si no es nulo manda una alerta
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Imposible conectar al servidor", message: "Comprueba conexión a internet", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                    self.present(alert, animated: true)
                }
                return
            }
            // Te aseguras que data no sea nulo y toma la respuesta y la pasa a un string para que la puedas imprimir
            if let dataUnwrapped = data, let stringData = String(data: dataUnwrapped, encoding: .utf8) {
                print(stringData)
                do{
                    /*{"message":"User doesn't exist"}
                     {"id":73,"user_type":"administrator","name":"admin","last_name":"admin","email":"admin@admin.com","birthdate":"2018-01-01","password":"$2a$10$V5VrefdMkZu31i8f6KnvRuxdKBuOZHlvDADgxq3slEzekiaItPHTi","postal_code":"77777","phone_number":"2222222222","createdAt":"2018-11-09T18:42:10.000Z","updatedAt":"2018-11-14T03:55:27.000Z"}*/
                    
                    // Casteas el dataMap de un data a un json de tipo string a cualquier cosa
                    let dataMap = try JSONSerialization.jsonObject(with: dataUnwrapped, options: .mutableContainers) as! [String: Any]
                    // Checas si el valor con se agrego el id
                    if let usrData = dataMap["data"] as? [String:Any], let userId = usrData["id"] as? Int {
                        UserDefaults.standard.set(userId, forKey: "id_user")
                        requestResult = true
                    }
                    else {
                        print("Sin userID")
                        //Para guardar en user default
                        //UserDefaults.standard.set(nombre_variable, forKey: "key")
                        
                        //Para obtener el valor
                        //UserDefaults.standard.tipo_de_dato(forKey: "key")
                        
                        //Para borrar un dato
                        //UserDefaults.removeObject(forKey: "key")
                    }
                } catch {
                    print("ERROR: \(error)") //Por si se muere si no puedes parser el data a un json
                }
                DispatchQueue.main.async {
                    //Le dices que se ponga true si se pudo hacer la peticion y jalo al usuario pa que haga el segue
                    self.registerResult = requestResult
                }
            }
            else {
                DispatchQueue.main.async {
                    // Este solo sale si la peticion no te dice nada
                    let alert = UIAlertController(title: "Error", message: "No hubo datos de respuesta", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                    self.present(alert, animated: true)
                }
            }
        }
        // Ejecutas el task
        task.resume()
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

