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
        
        if self.verifyInputs() {
            loginRequest()
        }
        else{
            //Muestra alerta de que los inputs estan mal
        }
        
        
        
    }
    
    func verifyInputs() -> Bool {
        //Aqui verificar que la contraseña y el mail sean correctos
        
        return true
    }
    
    func loginRequest(){
        var requestResult = false
        var urlComponents = URLComponents()
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.loginPath
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let jsonParams = ["email":username.text, "password":password.text]
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(jsonParams)
            request.httpBody = jsonData
        } catch { return }
        
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Imposible conectar al servidor", message: "Comprueba conexión a internet", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                    self.present(alert, animated: true)
                }
                return
            }
            if let dataUnwrapped = data, let stringData = String(data: dataUnwrapped, encoding: .utf8) {
                print(stringData)
                do{
                    /*{"message":"User doesn't exist"}
                     {"id":73,"user_type":"administrator","name":"admin","last_name":"admin","email":"admin@admin.com","birthdate":"2018-01-01","password":"$2a$10$V5VrefdMkZu31i8f6KnvRuxdKBuOZHlvDADgxq3slEzekiaItPHTi","postal_code":"77777","phone_number":"2222222222","createdAt":"2018-11-09T18:42:10.000Z","updatedAt":"2018-11-14T03:55:27.000Z"}*/
                    let dataMap = try JSONSerialization.jsonObject(with: dataUnwrapped, options: .mutableContainers) as! [String: Any]
                    if let message = dataMap["message"] as? String {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                            self.present(alert, animated: true)
                        }
                    }
                    else {
                        UserDefaults.standard.set(dataMap["id"] as? Int, forKey: "id_user")
                        requestResult = true
                        //Para guardar en user default
                        //UserDefaults.standard.set(nombre_variable, forKey: "key")
                        
                        //Para obtener el valor
                        //UserDefaults.standard.tipo_de_dato(forKey: "key")
                        
                        //Para borrar un dato
                        //UserDefaults.removeObject(forKey: "key")
                    }
                } catch {
                    print("ERROR: \(error)")
                }
                DispatchQueue.main.async {
                    self.loginResult = requestResult
                }
            }
            else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "No hubo datos de respuesta", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                    self.present(alert, animated: true)
                }
            }
        }
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
        ingresar.layer.cornerRadius = 15
        ingresar.layer.borderWidth = 2
        ingresar.layer.borderColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        loginResult = false
        // Do any additional setup after loading the view.
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
