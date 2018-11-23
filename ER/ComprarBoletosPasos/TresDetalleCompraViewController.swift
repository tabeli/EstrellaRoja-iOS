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
    
    var precioTotal = 0.0
    
    var purchaseId = 0
    
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func siguienteAction(_ sender: UIButton) {
        performSegue(withIdentifier: "DatosPasajerosSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        purchaseRequest()
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
            let title = "Aviso"
            let message = "No olvides traer tu tarjeta INAPAM"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        cambiaTipoTurista.text = str
        cambiaTipoTurista.adjustsFontSizeToFitWidth = true
        
        cambiaTotal.text = "$\((precioTotal * 0.16)+precioTotal)"
        
        // Do any additional setup after loading the view.
    }
    
    func purchaseRequest() {
        var requestResult = false // Pa' cambiar el registerResult y asegurar que todo termino
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.performPurchasePath
        guard let url = urlComponents.url else { return } // guard para ver si se hace, si no, se muere el metodo
        var request = URLRequest(url: url) // Crea opeticion a partir del url
        request.httpMethod = "POST" // Le dices que tipo de metodo es
        var headers = request.allHTTPHeaderFields ?? [:] // Es como esto: x-www-form-urlencoded
        headers["Content-Type"] = "application/json" // Tiene que ser un json porque recibe un json
        request.allHTTPHeaderFields = headers // Se lo asignas el arreglo del url
        let userId = UserDefaults.standard.integer(forKey: "id_user")
        
        let usrPurchase = PerformPurchase(company_id: "1", user_id: String(userId), sub_total: String(precioTotal), total: String((precioTotal*0.16)+precioTotal))
        
        let encoder = JSONEncoder() // Instancias el encoder
        do {
            let jsonData = try encoder.encode(usrPurchase)  // Lo encodea a tipo dato (lo parsea)
            request.httpBody = jsonData // Le metes el json parseado en la peticion
            print("ESTO ESTOY MANDANDO")
            print(usrPurchase)
        } catch { return }
        //Esto inicia una task que ejecuta la peticion
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) {
            (data, response, error) in // Los datos que responde, response es la respuesta http completa, o el erroe
            guard error == nil else { //Si no es nulo manda una alerta
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Imposible conectar al servidor", message: "Comprueba conexión a internet", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                    self.present(alert, animated: true)
                }
                return
            }
            // Te aseguras que data no sea nulo y toma la respuesta y la pasa a un string para que la puedas imprimir
            if let dataUnwrapped = data, let stringData = String(data: dataUnwrapped, encoding: .utf8) {
                print(stringData)
                do{
                    /*{
                        "id": 28,
                        "company_id": "1",
                        "user_id": "81",
                        "sub_total": "100",
                        "total": "110",
                        "updatedAt": "2018-11-23T05:45:15.543Z",
                        "createdAt": "2018-11-23T05:45:15.543Z"
                    }*/
                    
                    // Casteas el dataMap de un data a un json de tipo string a cualquier cosa
                    let dataMap = try JSONSerialization.jsonObject(with: dataUnwrapped, options: .mutableContainers) as! [String: Any]
                    
                    print("HAGO ALGO")
                    
                    if let id = dataMap["id"] as? Int {
                        self.purchaseId = id
                    }
                    // Checas si el valor con se agrego el id
                    
                } catch {
                    print("ERROR: \(error)") //Por si se muere si no puedes parser el data a un json
                }
                DispatchQueue.main.async {
                    //Le dices que se ponga true si se pudo hacer la peticion y jalo al usuario pa que haga el segue
                    //self.registerResult = requestResult
                }
            }
            else {
                DispatchQueue.main.async {
                    // Este solo sale si la peticion no te dice nada
                    let alert = UIAlertController(title: "Error", message: "No hubo datos de respuesta", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                    self.present(alert, animated: true)
                }
            }
        }
        // Ejecutas el task
        task.resume()
        
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
