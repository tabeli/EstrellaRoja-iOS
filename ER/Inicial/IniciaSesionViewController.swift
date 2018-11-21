//
//  IniciaSesionViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class IniciaSesionViewController: UIViewController {
    
    var requestResult = false {
        didSet{
            if(requestResult){
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
        
        let usr =
            username.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let pwd =
            password.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
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
        requestResult = false
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
