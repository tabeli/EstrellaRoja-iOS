//
//  IniciaSesionViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class IniciaSesionViewController: UIViewController {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var ingresar: UIButton!
    
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ingresarAction(_ sender: UIButton) {
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let usr =
            username.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let pwd =
            password.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        print(usr)
        print(password)
        
        let url = NSURL(string: "http://www.iroseapps.com/moviles/login.php?username=\(usr)&password=\(pwd)")
        let request = URLRequest(url: url! as URL)
        dataTask = defaultSession.dataTask(with: request) {
            data, response, error in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            if let error = error {
                print(error.localizedDescription)
            }
            else if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.showResult(data!)
                    }
                }
            }
        }
        dataTask?.resume()
        performSegue(withIdentifier: "RutaMenuSegue", sender: nil)
        
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
