//
//  CambiaContrasenaViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class CambiaContrasenaViewController: UIViewController {
    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailRepetido: UITextField!
    @IBOutlet weak var aceptar: UIButton!
    
    @IBAction func aceptarAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        head.adjustsFontSizeToFitWidth = true
        aceptar.titleLabel?.adjustsFontSizeToFitWidth = true
        aceptar.layer.cornerRadius = 15
        aceptar.layer.borderWidth = 2
        aceptar.layer.borderColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
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
