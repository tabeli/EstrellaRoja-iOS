//
//  AgregarPasajerosViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class AgregarPasajerosViewController: UIViewController {
    
    @IBOutlet weak var cuatro: UIButton!
    @IBOutlet weak var topTitle: UILabel!
    
    //Datos: Selecciona pasajeros
    var idRuta = 0
    
    var countAdulto = 0
    var countNino = 0
    var countInapam = 0
    
    var purchaseId = -1
    var tourDate = ""
    var totalPurchase = 0.0
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTitle.adjustsFontSizeToFitWidth = true
        cuatro.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "datosPasajeros"{
            let vc = segue.destination as! AgregarPasajerosTableViewController
            vc.idRuta = self.idRuta
            vc.countAdulto = self.countAdulto
            vc.countNino = self.countNino
            vc.countInapam = self.countInapam
            
            vc.purchaseId = self.purchaseId
            vc.tourDate = self.tourDate
            vc.totalPurchase = self.totalPurchase
        }
        
        if segue.identifier == "CompletaPagoSegue"{
            let vc = segue.destination as! CompletaPagoViewController
            vc.idRuta = self.idRuta
        }
        
        /*if segue.identifier == "CompletaPagoSegue"{
            let vc = segue.destination as! CompletaPagoViewController
            vc.idRuta = self.idRuta
            vc.countAdulto = self.countAdulto
            vc.countNino = self.countNino
            vc.countInapam = self.countInapam
            
            vc.purchaseId = self.purchaseId
            vc.tourDate = self.tourDate
            
        }*/
    }
}
