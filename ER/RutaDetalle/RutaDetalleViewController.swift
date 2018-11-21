//
//  RutaDetalleViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/19/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class RutaDetalleViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    var idRuta = -1
    var nameRuta = ""
    var imageRuta = ""
    var descriptionRuta = ""
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        headerLabel.text = nameRuta
        super.viewDidLoad()
        print("-------------------------")
        print(idRuta)
        print(nameRuta)
        print(imageRuta)
        print(descriptionRuta)
        print("-------------------------")
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleRutaSegue"{
            let vc = segue.destination as! RutaDetalleTableViewController
            vc.idRuta = self.idRuta
            vc.nameRuta = self.nameRuta
            vc.imageRuta = self.imageRuta
            vc.descriptionRuta = self.descriptionRuta
        }
        
        
        if segue.identifier == "compraSegue"{
            let vc = segue.destination as! CompraUnoReservaBoletosViewController
            vc.idRuta = self.idRuta
            vc.nameRuta = self.nameRuta
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
