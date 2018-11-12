//
//  RutaDetalleViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/19/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class RutaDetalleViewController: UIViewController {
    var idRuta = -1
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(idRuta)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "compraSegue"{
            
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
