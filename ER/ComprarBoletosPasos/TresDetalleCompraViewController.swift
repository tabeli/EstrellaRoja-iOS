//
//  TresDetalleCompraViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/13/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class TresDetalleCompraViewController: UIViewController {

    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var tres: UIButton!
    @IBOutlet weak var siguienteOutlet: UIButton!
    @IBOutlet weak var cambiaFecha: UILabel!
    @IBOutlet weak var cambiaNumeroTuristas: UILabel!
    @IBOutlet weak var cambiaNombreRuta: UILabel!
    @IBOutlet weak var cambiaTipoTurista: UILabel!
    @IBOutlet weak var cambiaTotal: UILabel!
    
    //Datos: Selecciona pasajeros
    var countAdulto = 0
    var countNino = 0
    var countInapam = 0
    
    //Datos: Reserva boletos
    var ruta = ""
    var fecha = ""
    var horario = ""
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func siguienteAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTitle.adjustsFontSizeToFitWidth = true
        tres.layer.cornerRadius = 15
        siguienteOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        siguienteOutlet.layer.cornerRadius = 15
        siguienteOutlet.layer.borderWidth = 2
        siguienteOutlet.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
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
