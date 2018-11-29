//
//  RutasTableViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/18/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class RutasTableViewController: UITableViewController {
    
    let numeroRutas = 3
    
    var tourIdArray:[Int] = []
    var tourNameArray:[String] = []
    var tourImageArray:[String] = []
    var tourDescriptionArray:[String] = []
    
    
    
    func tourRequest() {
        //var requestResult = false // Pa' cambiar el registerResult y asegurar que todo termino
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.getTourPath
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
                    /*{
                        "id": 17,
                        "name": "Puebla Fascinante",
                        "image_path": "https://storage.googleapis.com/principal-arena-219118/pueblafascinante.jpg",
                        "description": "Recorre la bella ciudad de los ángeles, en un autobús tipo europeo donde podrás disfrutar la Puebla tradicional con su arquitectura virreinal, así como la modernidad.  En el día un recorrido panorámico entre sus calles, monumentos y fachadas; y por la noche, sus cúpulas bellamente iluminadas lograrán cautivarte.",
                        "createdAt": "2018-11-06T15:56:41.000Z",
                        "updatedAt": "2018-11-20T02:55:29.000Z"
                    },*/
                    
                    // Casteas el dataMap de un data a un json de tipo string a cualquier cosa
                    let dataArr = try JSONSerialization.jsonObject(with: dataUnwrapped, options: .mutableContainers) as! [Any]
                    // Checas si el valor con se agrego el id
                    for element in dataArr {
                        if let mapElement = element as? [String:Any] {
                            if let id = mapElement["id"] as? Int {
                                self.tourIdArray.append(id)
                            }
                            if let name = mapElement["name"] as? String {
                                self.tourNameArray.append(name)
                            }
                            if let imagePath = mapElement["image_path"] as? String {
                                self.tourImageArray.append(imagePath)
                            }
                            if let description = mapElement["description"] as? String {
                                self.tourDescriptionArray.append(description)
                            }
                        }
                        
                    }
                    print("ACABE DE JALAR LOS DATOS")
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
        print("Hola")
        tourRequest()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 270
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
        print("numberOfRowsInSection")
        return tourIdArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("bye")
        print("indexPath:\(indexPath)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rutaCell", for: indexPath) as! RutaTableViewCell
        cell.tourIdArray = tourIdArray[indexPath.row]
        cell.nombreRuta.text = tourNameArray[indexPath.row]
    
        cell.nombreRuta.adjustsFontSizeToFitWidth = true
        //cell.nombreRuta.layer.backgroundColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        cell.nombreRuta.layer.masksToBounds = true;
        cell.nombreRuta.layer.cornerRadius = 35
        //cell.nombreRuta.layer.borderWidth = 5
        //cell.nombreRuta.layer.borderColor = #colorLiteral(red: 0.8271533947, green: 0.5080588404, blue: 0.0448990865, alpha: 1)
        
        let url = URL(string: tourImageArray[indexPath.row])
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.fotoImg.image = UIImage(data: data!)
        cell.tourNameArray = tourNameArray[indexPath.row]
        cell.tourImageArray = tourImageArray[indexPath.row]
        cell.tourDescriptionArray = tourDescriptionArray[indexPath.row]
        // Configure the cell...
        cell.nombreRuta.adjustsFontSizeToFitWidth = true
        
        
        /*
         @IBOutlet weak var nombreRuta: UILabel!
         var tourIdArray = -1
         var tourNameArray = ""
         var tourImageArray = ""
         var tourDescriptionArray = ""
         
         
         
         */
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RutaTableViewCell
        print("Hola")
        print(cell.tourNameArray )
        print("Hola")
        let dad = self.parent as! RutaMenuViewController
        dad.performSegue(withIdentifier: "detalleRutaSegue", sender: cell)
     }
    
    /*override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }*/

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

    
    
    

}
