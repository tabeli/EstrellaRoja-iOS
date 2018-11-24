//
//  CompraUnoReservaBoletosViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/12/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class CompraUnoReservaBoletosViewController: UIViewController {
    
     let rutas = ["Puebla fascinante","Cholula milenaria","Otra ruta"]
    
    var rutaSeleccionada: String?
    
//    @IBOutlet weak var eligeRuta: UITextField!
    @IBOutlet weak var eligeFecha: UITextField!
    @IBOutlet weak var eligeHora: UITextField!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var siguienteOutlet: UIButton!
    @IBOutlet weak var nombreRuta: UILabel!
    
    @IBOutlet weak var uno: UIButton!
    var idRuta = -1
    var nameRuta = ""
    var ruta = ""
    var fecha = Date()
    var horario = ""
    
    @IBAction func backArrow(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func siguienteAction(_ sender: Any) {
        
        //eligeRuta.text = nameRuta
        //fecha = eligeFecha.text!
        horario = eligeHora.text!
        if(eligeFecha.text!.isEmpty || horario.isEmpty) {
            let title = "Error"
            let message = "Ingresar datos faltantes"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "SeleccionarPasajerosSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        
        //MARK: - BORRA-ENTRADA
        eligeFecha.text = "23/07/2018"
        eligeHora.text = "23:57"
        
        print(nameRuta)
        super.viewDidLoad()
        crearToolbar()
        //creaRutasPicker()
        eligeFechaPicker()
        eligeHoraPicker()
        topTitle.adjustsFontSizeToFitWidth = true
        
        nombreRuta.text = nameRuta
        nombreRuta.adjustsFontSizeToFitWidth = true
        
        uno.layer.cornerRadius = 15
        siguienteOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        siguienteOutlet.layer.cornerRadius = 15
        siguienteOutlet.layer.borderWidth = 2
        siguienteOutlet.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
        
        let title = "¡Te esperamos!"
        let message = "Nuestros horarios son de 8:00 AM a 8:00 PM"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    /*func creaRutasPicker() {
        let rutasPicker = UIPickerView()
        rutasPicker.delegate = self
        eligeRuta.inputView = rutasPicker
        
        rutasPicker.backgroundColor = .white
    }*/
    
    func eligeFechaPicker() {
        let fechaPicker = UIDatePicker()
        fechaPicker.datePickerMode = .date
        eligeFecha.inputView = fechaPicker
        fechaPicker.addTarget(self, action: #selector(CompraUnoReservaBoletosViewController.dataChanged(fechaPicker:)), for: .valueChanged)
        fechaPicker.backgroundColor = .white
    }
    
    func eligeHoraPicker() {
        let horaPicker = UIDatePicker()
        horaPicker.datePickerMode = .time
        eligeHora.inputView = horaPicker
        horaPicker.addTarget(self, action: #selector(CompraUnoReservaBoletosViewController.timeChanged(horaPicker:)), for: .valueChanged)
        horaPicker.backgroundColor = .white
        
    }
    
    func crearToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        toolBar.barTintColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
        toolBar.tintColor = .white
        
        
        let doneButton = UIBarButtonItem(title: "Listo", style: .plain, target: self, action: #selector(CompraUnoReservaBoletosViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        //eligeRuta.inputAccessoryView = toolBar
        eligeFecha.inputAccessoryView = toolBar
        eligeHora.inputAccessoryView = toolBar
    }
    
    @objc func dataChanged(fechaPicker: UIDatePicker){
        let formatoFecha = DateFormatter()
        formatoFecha.dateFormat = "dd/MM/yyyy"
        eligeFecha.text = formatoFecha.string(from: fechaPicker.date)
        
        //let weekday = Calendar.current.component(.weekday, from: myDate)
        
        fecha = fechaPicker.date
    }
    
    @objc func timeChanged(horaPicker: UIDatePicker){
        let formatoHora = DateFormatter()
        formatoHora.dateFormat = "HH:mm"
        
        let date = horaPicker.date
       
        eligeHora.text = formatoHora.string(from: date)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SeleccionarPasajerosSegue") {
            let vc = segue.destination as! DosSeleccionaPasajerosViewController
            vc.idRuta = self.idRuta
            vc.nameRuta = self.nameRuta
            vc.fecha = self.fecha
            vc.horario = self.horario
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension CompraUnoReservaBoletosViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rutas.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rutas[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rutaSeleccionada = rutas[row]
        //eligeRuta.text = rutaSeleccionada
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "", size: 18)
        
        label.text = rutas[row]
        
        return label
    }
}

