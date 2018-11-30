//
//  AgregarPasajerosTableViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit
import SafariServices

class AgregarPasajerosTableViewController: UITableViewController {
    //2,4,3
    var countAdulto = 0
    var countNino = 0
    var countInapam = 0
    
    var touristNameArray:[String] = []
    var touristAgeArray:[String] = []
    var touristGenderArray:[String] = []
    
    var purchaseId = -1
    var tourDate = ""
    var totalPurchase = 0.0
    
    var totalPassenger = 0
    var currentPassenger = 0 {
        didSet {
            if(currentPassenger < totalPassenger) {
                print("\(currentPassenger) -> \(totalPassenger)")
                creaTicket()
            }
            else{
                currentPassenger = 0
                let dad = self.parent as! AgregarPasajerosViewController
                dad.performSegue(withIdentifier: "CompletaPagoSegue", sender: nil)
            }
        }
    }
     /*
     0 -> headerCcell "comienza tu tour"
     1
     2              <---aqui acaban los adultos
     3
     4
     5
     6            <-----aqui acaban los niños
     7
     8
     9               <-----aqui acaban los inapam
     10   siguiente cell
     11
     12
     13
     */
    
    var idRuta = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sumOfTouristRows = countAdulto + countNino + countInapam
        for i in 0..<sumOfTouristRows {
            //MARK: - BORRA-ENTRADA
            //print("\(i) ->\(sumOfTouristRows) ")
            touristNameArray.append("")
            touristAgeArray.append("")
            touristGenderArray.append("")
        }
        print("Cuenta Adulto")
        print(countAdulto)
        print("Cuenta Nino")
        print(countNino)
        print("Cuenta Inapam")
        print(countInapam)
        
        totalPassenger = countAdulto + countNino + countInapam
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return countAdulto + countNino + countInapam + 2
    }

    func validaCampos() -> Bool {
        for index in 0..<touristNameArray.count {
            print("NOMBRE")
            print(touristNameArray[index])
            print("AGE")
            print(touristAgeArray[index])
            print("GENDER")
            print(touristGenderArray[index])
            
            if (touristNameArray[index].isEmpty) || (touristAgeArray[index].isEmpty) || (touristGenderArray[index].isEmpty){
                
                return false
            }
            
        }
        return true
    }
    
    func creaTicket() {
        print("CPASSANGER")
        print(currentPassenger)
        //var requestResult = false // Pa' cambiar el registerResult y asegurar que todo termino
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.addTicketPath
        guard let url = urlComponents.url else { return } // guard para ver si se hace, si no, se muere el metodo
        var request = URLRequest(url: url) // Crea opeticion a partir del url
        request.httpMethod = "POST" // Le dices que tipo de metodo es
        var headers = request.allHTTPHeaderFields ?? [:] // Es como esto: x-www-form-urlencoded
        headers["Content-Type"] = "application/json" // Tiene que ser un json porque recibe un json
        request.allHTTPHeaderFields = headers // Se lo asignas el arreglo del url
        
        
        let addTickets = AddTickets(purchase_id: String(purchaseId), client_name: touristNameArray[currentPassenger], client_age: touristAgeArray[currentPassenger], client_genre: touristGenderArray[currentPassenger], tour_date: tourDate, total: String(totalPurchase))
        //aqui va la peticion
        currentPassenger += 1
        
        let encoder = JSONEncoder() // Instancias el encoder
        do {
            let jsonData = try encoder.encode(addTickets)  // Lo encodea a tipo dato (lo parsea)
            request.httpBody = jsonData // Le metes el json parseado en la peticion
            print(addTickets)
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
                    
                    // Casteas el dataMap de un data a un json de tipo string a cualquier cosa
                    let dataMap = try JSONSerialization.jsonObject(with: dataUnwrapped, options: .mutableContainers) as! [String: Any]
                    
                    print("HAGO ALGO")
                    
                    /*if let id = dataMap["id"] as? Int {
                        let alert = UIAlertController(title: "Aviso", message: "Se han generado tus tickets", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                        self.present(alert, animated: true)
                        //self.ticketId = id
                        
                    }*/
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "comienzaTourCell", for: indexPath) as! ComenzarViajeTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else if(indexPath.row == (countAdulto + countNino + countInapam + 1)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "siguienteCell", for: indexPath) as! SiguienteTableViewCell
            cell.selectTerms.backgroundColor = .clear
            cell.selectTerms.layer.cornerRadius = 5
            cell.selectTerms.layer.borderWidth = 2
            cell.selectTerms.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            
            cell.linkTermsAndConditions.titleLabel?.adjustsFontSizeToFitWidth = true
            cell.nextButton.backgroundColor = .clear
            cell.nextButton.layer.cornerRadius = 15
            cell.nextButton.layer.borderWidth = 2
            cell.nextButton.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            cell.selectionStyle = .none
            
            cell.delegate = self
            
            return cell
        }
        else{
            print("tableview linea 93")
            let cell = tableView.dequeueReusableCell(withIdentifier: "tipoTuristaCell", for: indexPath) as! DatosPasajeroTableViewCell
            if indexPath.row <= countAdulto {
                cell.userType.text = "Adulto"
                print("Adulto")
            }
            else if indexPath.row <= countNino + countAdulto{
                cell.userType.text = "Niño"
                print("Niño")
            }
            else {
                cell.userType.text = "INAPAM"
                print("INAPAM")
            }
            print("tableview linea 107")
            //cell.userType.text = userType[indexPath.row-1]
            cell.genderButtons[0].backgroundColor = .clear
            cell.genderButtons[0].layer.cornerRadius = 5
            cell.genderButtons[0].layer.borderWidth = 2
            cell.genderButtons[0].layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            cell.genderButtons[1].backgroundColor = .clear
            cell.genderButtons[1].layer.cornerRadius = 5
            cell.genderButtons[1].layer.borderWidth = 2
            cell.genderButtons[1].layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            print("tableview linea 117")
            cell.cellId = indexPath.row-1
            
            cell.name = touristNameArray[cell.cellId]
            cell.age = touristAgeArray[cell.cellId]
            cell.gender = touristGenderArray[cell.cellId]
            cell.touristName.text = cell.name
            cell.touristAge.text = cell.age
            
            //print("now cell gender is \(cell.gender)")
            if (cell.gender == "male") {
                cell.genderButtons[0].backgroundColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            } else if (cell.gender == "female"){
                cell.genderButtons[1].backgroundColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            } else {
                cell.genderButtons[0].backgroundColor = .clear
                cell.genderButtons[1].backgroundColor = .clear
            }
            print("tableview linea 123")
            cell.delegate = self
            
            cell.selectionStyle = .none
            // #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            return cell
        }

        
    }
    
    
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == countAdulto + countNino + countInapam + 1) {
            let dad = self.parent as! AgregarPasajerosViewController
            dad.performSegue(withIdentifier: "CompletaPagoSegue", sender: nil)
        }
        
    }*/


}

extension AgregarPasajerosTableViewController: DatosPasajerosCellDelegate {
    func didSelectGender(cellId: Int, gender: String) {
        self.touristGenderArray[cellId] = gender
        print("touristegender arr now is: \(self.touristGenderArray) with \(cellId) and \(gender)")
    }
    func didUpdateTextFields(cellId: Int, name:String, age: String) {
        self.touristAgeArray[cellId] = age
        self.touristNameArray[cellId] = name
    }
}

extension AgregarPasajerosTableViewController: SiguienteTableViewCellDelegate {
    
    func didTapAcceptTerms(cell: UITableViewCell) {
        if let celda = cell as? SiguienteTableViewCell {
            celda.didAcceptTerms.toggle()
            if celda.didAcceptTerms {
                celda.selectTerms.backgroundColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
                celda.selectTerms.layer.cornerRadius = 5
            } else {
                celda.selectTerms.backgroundColor = .clear
                celda.selectTerms.layer.cornerRadius = 5
                celda.selectTerms.layer.borderWidth = 2
                celda.selectTerms.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            }
            
        }
    }
    func didTapSeeTerms(url: String) {
        let webPageURL = URL(string: url)!
        let safariVC = SFSafariViewController(url: webPageURL)
        present(safariVC, animated: true, completion: nil)
    }
    func didTapContinueWithPayment(cell: UITableViewCell) {
        if let celda = cell as? SiguienteTableViewCell {
            
            if celda.didAcceptTerms == false {
                let alert = UIAlertController(title: "Error", message: "Favor de aceptar los términos y condiciones", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                self.present(alert, animated: true)
            }
            else {
                if validaCampos() {
                    creaTicket()
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Faltan campos por llenar", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in }))
                    self.present(alert, animated: true)
                }
                
            }
        }
    }
    
}
