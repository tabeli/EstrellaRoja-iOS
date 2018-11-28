//
//  IniciaSesionViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class IniciaSesionViewController: UIViewController {
    
    var loginResult = false {
        didSet{ //checa cada vez que cambia el valor de loginResult para que cuando sea true realice el segue
            if(loginResult){
                performSegue(withIdentifier: "RutaMenuSegue", sender: nil)
            }
        }
    }
    
    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var ingresar: UIButton!
    
    
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ingresarAction(_ sender: UIButton) {
        
        if self.verifyUsernameInput(usernameStr: self.username.text!) && self.verifyPasswordInput(passwordStr: self.password.text!) {
            loginRequest()
        }
        else{
            //Muestra alerta de que los inputs estan mal
            let alert = UIAlertController(title: "Error", message: "Correo o contraseña inválido", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
            self.present(alert, animated: true)
        }
    }
    
    func verifyUsernameInput(usernameStr: String) -> Bool {
        return usernameStr.count > 5
    }
    
    func verifyPasswordInput(passwordStr: String) -> Bool {
        //Aqui verificar que la contraseña sea correcta
        return passwordStr.count > 4
    }
    
    func loginRequest(){
        var requestResult = false // Pa' cambiar el loginResult y asegurar que todo termino
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.loginPath
        guard let url = urlComponents.url else { return } // guard para ver si se hace, si no, se muere el metodo
        var request = URLRequest(url: url) // Crea opeticion a partir del url
        request.httpMethod = "POST" // Le dices que tipo de metodo es
        var headers = request.allHTTPHeaderFields ?? [:] // Es como esto: x-www-form-urlencoded
        headers["Content-Type"] = "application/json" // Tiene que ser un json porque recibe un json
        request.allHTTPHeaderFields = headers // Se lo asignas el arreglo del url
        
        let jsonParams = UserIniciaSesion(email: username.text!, password: password.text!) // Se le asignan los valores de acuerdo a lo que necesita la base
        
        let encoder = JSONEncoder() // Instancias el encoder
        do {
            let jsonData = try encoder.encode(jsonParams)  // Lo encodea a tipo dato (lo parsea)
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
                    // Checas si el valor con la llave message está ahí, si está mandas un alert del error
                    if let message = dataMap["message"] as? String {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                            self.present(alert, animated: true)
                        }
                    }
                    // Si no, sabes que se pudo hacer el login
                    else {
                        //Aquí lo guardas en la cosa global rara
                        UserDefaults.standard.set(dataMap["id"] as? Int, forKey: "id_user")
                        requestResult = true // Si se pudo entrar
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
                    self.loginResult = requestResult
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
    
    @IBAction func olvidarContrasena(_ sender: UIButton) {
        performSegue(withIdentifier: "recuperarPwdSegue", sender: nil)
    }
    
    func showResult(_ data: Data) {
        let str = NSString(data: data, encoding: String.Encoding.ascii.rawValue)
        let alert = UIAlertController(title: "Server Response", message: (str! as String), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - BORRA-ENTRADA
        username.text? = "admin@admin.com"
        password.text? = "admin"
        
        
        ingresar.layer.cornerRadius = 15
        ingresar.layer.borderWidth = 2
        ingresar.layer.borderColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        loginResult = false
        // Do any additional setup after loading the view.
        username.keyboardType = .emailAddress
        username.autocapitalizationType = .words
        username.returnKeyType = .done
        username.delegate = self
        
        password.keyboardType = .alphabet
        password.isSecureTextEntry = true
        password.returnKeyType = .done
        password.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension IniciaSesionViewController: UITextFieldDelegate {
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
