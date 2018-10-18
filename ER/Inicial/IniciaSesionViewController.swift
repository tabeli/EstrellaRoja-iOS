//
//  IniciaSesionViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class IniciaSesionViewController: UIViewController {
    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var ingresar: UIButton!
    
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ingresarAction(_ sender: UIButton) {
        performSegue(withIdentifier: "RutaMenuSegue", sender: nil)
    }
    
    @IBAction func olvidarContrasena(_ sender: UIButton) {
        performSegue(withIdentifier: "recuperarPwdSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ingresar.layer.cornerRadius = 15
        ingresar.layer.borderWidth = 2
        ingresar.layer.borderColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        
        // Do any additional setup after loading the view.
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
