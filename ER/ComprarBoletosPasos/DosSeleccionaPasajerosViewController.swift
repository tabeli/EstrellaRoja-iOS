//
//  DosSeleccionaPasajerosViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/12/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class DosSeleccionaPasajerosViewController: UIViewController {

    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var siguienteOutlet: UIButton!
    @IBOutlet weak var dos: UIButton!
    
    @IBOutlet weak var adulto: UILabel!
    @IBOutlet weak var nino: UILabel!
    @IBOutlet weak var inapam: UILabel!
    
    @IBOutlet weak var inapamDesfasado: UILabel!
    
    var countAdulto = 0
    var countNino = 0
    var countInapam = 0
    
    var costoTotalAdulto = 65
    var costoTotalNino = 45
    var costoTotalInapam = 45
    
    var precioTotal = 0
    
    //Datos: Reserva boletos
    var idRuta = 0
    var nameRuta = ""
    var fecha = Date()
    var horario = ""
    
    
    @IBAction func backArrow(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func plusAdulto(_ sender: UIButton) {
        if(countAdulto < 10) {
            countAdulto+=1
            adulto.text = String(countAdulto)
        }
        
    }
    @IBAction func minusAdulto(_ sender: UIButton) {
        if(countAdulto > 0) {
            countAdulto-=1
            adulto.text = String(countAdulto)
        }
    }
    
    @IBAction func plusNino(_ sender: UIButton) {
        if(countNino < 10) {
            countNino+=1
            nino.text = String(countNino)
        }
    }
    @IBAction func minusNino(_ sender: UIButton) {
        if(countNino > 0) {
            countNino-=1
            nino.text = String(countNino)
        }
    }
    
    @IBAction func plusInapam(_ sender: UIButton) {
        if(countInapam < 10) {
            countInapam+=1
            inapam.text = String(countInapam)
        }
    }
    @IBAction func minusInapam(_ sender: UIButton) {
        if(countInapam > 0) {
            countInapam-=1
            inapam.text = String(countInapam)
        }
    }
    
    
    @IBAction func siguienteAction(_ sender: UIButton) {
        
        if(countNino > 0) && ((countAdulto + countInapam == 0)) {
            let title = "Error"
            let message = "Los niños deben de ir acompañados de un adulto"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        else if(countAdulto + countNino + countInapam) > 10 {
            let title = "Error"
            let message = "Se permiten compras de hasta 10 boletos"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
       
        else if (countAdulto + countNino + countInapam == 0) {
            let title = "Error"
            let message = "Ingresa cuantos boletos deseas comprar"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        else {
            performSegue(withIdentifier: "DetalleCompraSegue", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTitle.adjustsFontSizeToFitWidth = true
        inapamDesfasado.adjustsFontSizeToFitWidth = true
        dos.layer.cornerRadius = 15
        siguienteOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        siguienteOutlet.layer.cornerRadius = 15
        siguienteOutlet.layer.borderWidth = 2
        siguienteOutlet.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetalleCompraSegue") {
            let vc = segue.destination as! TresDetalleCompraViewController
            vc.idRuta = self.idRuta
            vc.nameRuta = self.nameRuta
            vc.fecha = self.fecha
            vc.horario = self.horario
            vc.countAdulto = self.countAdulto
            vc.countNino = self.countNino
            vc.countInapam = self.countInapam
            
            vc.precioTotal = (countAdulto * costoTotalAdulto) + (countNino * costoTotalNino) + (countInapam * costoTotalInapam)
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
