//
//  DetalleViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/20/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController {

    @IBOutlet weak var lblnombre: UILabel!
    @IBOutlet weak var lblDescripcion: UITextView!
    @IBOutlet weak var lblCoordenadas: UILabel!
    
    @IBAction func reproduceAudio(_ sender: UIButton) {
    }
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var nombre = ""
    var descripcion = ""
    var latitud = 0.0
    var longitud = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblnombre.text = nombre
        lblDescripcion.text = descripcion
        lblCoordenadas.text = String(format: "Lat: %4f // Lon: %4f", latitud,longitud)
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
