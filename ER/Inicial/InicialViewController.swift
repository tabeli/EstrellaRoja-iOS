//
//  InicialViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class InicialViewController: UIViewController {
    @IBOutlet weak var iniciaSesion: UIButton!
    @IBOutlet weak var registro: UIButton!
    
    @IBAction func iniciaSesionAction(_ sender: UIButton) {
        performSegue(withIdentifier: "iniciaSesionSegue", sender: nil)
    }
    
    @IBAction func registroAction(_ sender: UIButton) {
        performSegue(withIdentifier: "registrateSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        iniciaSesion.titleLabel?.adjustsFontSizeToFitWidth = true
        iniciaSesion.layer.cornerRadius = 10
        iniciaSesion.layer.borderWidth = 3
        //iniciaSesion.layer.borderColor = UIColor.white.cgColor
        iniciaSesion.titleEdgeInsets = UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
        
        registro.titleLabel?.adjustsFontSizeToFitWidth = true
        registro.layer.cornerRadius = 10
        registro.layer.borderWidth = 3
        //registro.layer.borderColor = UIColor.white.cgColor
        iniciaSesion.titleEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
