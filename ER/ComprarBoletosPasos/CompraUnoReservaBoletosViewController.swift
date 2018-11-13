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
    
    @IBOutlet weak var eligeRuta: UITextField!
    @IBOutlet weak var eligeFecha: UITextField!
    @IBOutlet weak var eligeHora: UITextField!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var siguienteOutlet: UIButton!
    
    @IBOutlet weak var uno: UIButton!
    
    @IBAction func backArrow(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func siguienteAction(_ sender: Any) {
        performSegue(withIdentifier: "SeleccionarPasajerosSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crearToolbar()
        creaRutasPicker()
        topTitle.adjustsFontSizeToFitWidth = true
        
        uno.layer.cornerRadius = 15
        siguienteOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        siguienteOutlet.layer.cornerRadius = 15
        siguienteOutlet.layer.borderWidth = 2
        siguienteOutlet.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    func creaRutasPicker() {
        let rutasPicker = UIPickerView()
        rutasPicker.delegate = self
        eligeRuta.inputView = rutasPicker
        
        rutasPicker.backgroundColor = .white
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
        
        eligeRuta.inputAccessoryView = toolBar
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        eligeRuta.text = rutaSeleccionada
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
