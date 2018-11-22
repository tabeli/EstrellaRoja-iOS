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
    var idRuta = 0
    var nameRuta = ""
    var fecha = Date()
    var horario = ""
    
    var precioTotal = 0
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func siguienteAction(_ sender: UIButton) {
        performSegue(withIdentifier: "DatosPasajerosSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cambiaFecha.text = formatoFecha()
        cambiaFecha.adjustsFontSizeToFitWidth = true
        cambiaNumeroTuristas.text = String(countAdulto + countNino + countInapam)
        cambiaNombreRuta.text = nameRuta
        cambiaNombreRuta.adjustsFontSizeToFitWidth = true
        
        topTitle.adjustsFontSizeToFitWidth = true
        tres.layer.cornerRadius = 15
        siguienteOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        siguienteOutlet.layer.cornerRadius = 15
        siguienteOutlet.layer.borderWidth = 2
        siguienteOutlet.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
        
        var str = ""
        if(countAdulto != 0) {
            str += String(countAdulto) + " Adulto "
        }
        if(countNino != 0) {
            str += String(countNino) + " Niño "
        }
        if(countInapam != 0) {
            str += String(countInapam) + " INAPAM "
        }
        cambiaTipoTurista.text = str
        cambiaTipoTurista.adjustsFontSizeToFitWidth = true
        
        cambiaTotal.text = "$\(precioTotal)"
        
        // Do any additional setup after loading the view.
    }
    
    func formatoFecha() -> String{
        var res = ""
        let dayOfTheWeek = Calendar.current.component(.weekday, from: fecha)
        let dayOfTheMonth = Calendar.current.component(.day, from: fecha)
        let month = Calendar.current.component(.month, from: fecha)
        let year = Calendar.current.component(.year, from: fecha)
        
        
        switch dayOfTheWeek {
        case 0:
            res += "Lunes"
        case 1:
            res += "Martes"
        case 2:
            res += "Miércoles"
        case 3:
            res += "Jueves"
        case 4:
            res += "Viernes"
        case 5:
            res += "Sábado"
        case 6:
            res += "Domingo"
        default:
            res += ""
        }
        
        res += " \(dayOfTheMonth) "
        
        switch month {
        case 1:
            res += "Enero"
        case 2:
            res += "Febrero"
        case 3:
            res += "Marzo"
        case 4:
            res += "Abril"
        case 5:
            res += "Mayo"
        case 6:
            res += "Junio"
        case 7:
            res += "Julio"
        case 8:
            res += "Agosto"
        case 9:
            res += "Septiembre"
        case 10:
            res += "Octubre"
        case 11:
            res += "Noviembre"
        case 12:
            res += "Diciembre"
        default:
            res += ""
        }
        
        res += " \(year) "
        
        return res
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DatosPasajerosSegue") {
            let vc = segue.destination as! AgregarPasajerosViewController
            vc.idRuta = self.idRuta
            vc.countAdulto = self.countAdulto
            vc.countNino = self.countNino
            vc.countInapam = self.countInapam
            
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
