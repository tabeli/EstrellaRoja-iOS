//
//  SeleccionaCamionTableViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/26/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class SeleccionaCamionTableViewController: UITableViewController {

    var busId:[Int] = []
    var busMuralId:[Int] = []
    var tourId = 2
    
    func obtenerBusesRequest() {
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.getAllBusesPath
        guard let url = urlComponents.url else { return } // guard para ver si se hace, si no, se muere el metodo
        var request = URLRequest(url: url) // Crea opeticion a partir del url
        request.httpMethod = "GET" // Le dices que tipo de metodo es
        var headers = request.allHTTPHeaderFields ?? [:] // Es como esto: x-www-form-urlencoded
        headers["Content-Type"] = "application/json" // Tiene que ser un json porque recibe un json
        request.allHTTPHeaderFields = headers // Se lo asignas el arreglo del url
        
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
                    let dataArr = try JSONSerialization.jsonObject(with: dataUnwrapped, options: .mutableContainers) as! [Any]
                    // Checas si el valor con se agrego el id
                    for element in dataArr {
                        print("SI ENTRO A CHECAR LOS BUSES")
                        if let mapElement = element as? [String:Any] {
                            if let tourId = mapElement["tour_id"] as? Int, let status = mapElement["status"] as? String {
                                print(self.tourId)
                                if tourId == self.tourId && status == "in_service" {
                                    print("Alguno cumple con esto")
                                    if let id = mapElement["id"] as? Int {
                                        self.busId.append(id)
                                    }
                                    if let muralId = mapElement["mural_id"] as? Int {
                                        self.busMuralId.append(muralId)
                                    }
                                }
                            }
                        }
                    }
                    
                    print("ACABE DE JALAR LOS DATOS DE LOS ID DEL MURAL")
                    print(self.busId)
                } catch {
                    print("ERROR: \(error)") //Por si se muere si no puedes parser el data a un json
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerBusesRequest()
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
        return self.busId.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SeccionCamionesTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "busData", for: indexPath) as! SeccionCamionesTableViewCell
        cell.numeroCamionOutlet.titleLabel?.text = String(self.busId[indexPath.row])
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
