//
//  CamionesMuralesViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/26/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit
import SafariServices

class CamionesMuralesViewController: UIViewController {

    var busId:[Int] = []
    var busTourId:[Int] = []
    var busMuralId:[Int] = []
    var busStatus:[String] = []
    
    var muralId:[Int] = []
    var muralTitle:[String] = []
    var muralAuthorName:[String] = []
    var muralAuthorLastName:[String] = []
    var muralDescription:[String] = []
    var muralImagePath:[String] = []
    
    @IBOutlet weak var selectionaCamion: UILabel!
    var countCamiones = 0
    
    @IBAction func showSideBar(_ sender: Any) {
        let modularStoryboard = UIStoryboard(name: "RutaDesbloqueada", bundle: nil);
        if let customAlert = modularStoryboard.instantiateViewController(withIdentifier: "SideBar") as? SideBarViewController {
            customAlert.providesPresentationContextTransitionStyle = true    //I don't know
            customAlert.definesPresentationContext = true                     //what this guys do
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            customAlert.delegate = self
            self.present(customAlert, animated: false, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectionaCamion.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }
    
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
                
                /*print("TAMBIEN REGRESO ESTOS DE TOUR_PLACES DATOS QUE JALE")
                 print(stringData)*/
                do{
                    // Casteas el dataMap de un data a un json de tipo string a cualquier cosa
                    let dataArr = try JSONSerialization.jsonObject(with: dataUnwrapped, options: .mutableContainers) as! [Any]
                    // Checas si el valor con se agrego el id
                    for element in dataArr {
                        if let mapElement = element as? [String:Any] {
                            if let busId = mapElement["id"] as? Int {
                                self.busId.append(busId)
                            }
                            if let busTourId = mapElement["tour_id"] as? Int {
                                self.busTourId.append(busTourId)
                            }
                            if let busMuralId = mapElement["mural_id"] as? Int {
                                self.busMuralId.append(busMuralId)
                            }
                            if let busStatus = mapElement["status"] as? String {
                                self.busStatus.append(busStatus)
                            }
                        }
                    }
                    
                } catch {
                    print("ERROR: \(error)") //Por si se muere si no puedes parser el data a un json
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
    
    func obtenerMuralesRequest() {
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.getAllMuralPath
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
                
                /*print("TAMBIEN REGRESO ESTOS DE TOUR_PLACES DATOS QUE JALE")
                 print(stringData)*/
                do{
                    // Casteas el dataMap de un data a un json de tipo string a cualquier cosa
                    let dataArr = try JSONSerialization.jsonObject(with: dataUnwrapped, options: .mutableContainers) as! [Any]
                    // Checas si el valor con se agrego el id
                    for element in dataArr {
                        if let mapElement = element as? [String:Any] {
                            if let muralId = mapElement["id"] as? Int {
                                self.muralId.append(muralId)
                            }
                            if let muralTitle = mapElement["title"] as? String {
                                self.muralTitle.append(muralTitle)
                            }
                            if let muralAuthor = mapElement["author_name"] as? String {
                                self.muralAuthorName.append(muralAuthor)
                            }
                            if let muralAuthorLastName = mapElement["author_last_name"] as? String {
                                self.muralAuthorLastName.append(muralAuthorLastName)
                            }
                            if let muralDescription = mapElement["description"] as? String {
                                self.muralDescription.append(muralDescription)
                            }
                            if let muralImage = mapElement["image_path"] as? String {
                                self.muralImagePath.append(muralImage)
                            }
                            
                        }
                    }
                    
                } catch {
                    print("ERROR: \(error)") //Por si se muere si no puedes parser el data a un json
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
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "seleccionaCamion"{
            let vc = segue.destination as! SeleccionaCamionTableViewController
            
            
           /* vc.purchaseId = self.purchaseId
            vc.tourDate = self.tourDate
            vc.totalPurchase = self.totalPurchase*/
        }
        
        /*if segue.identifier == "CompletaPagoSegue"{
            let vc = segue.destination as! CompletaPagoViewController
            vc.idRuta = self.idRuta
        }*/
    }
}

extension CamionesMuralesViewController: SideBarDelegate{
    func showBracelet() {
        //
    }
    
    func showLanguage() {
        //
    }
    
    func showBill() {
        let url = URL(string: "https://www.tourister.com.mx/contacto")
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
    
    func showTerms() {
        let url = URL(string: "https://www.tourister.com.mx/terminos-condiciones")
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
    
    
    func showTickets() {
        let modularStoryboard = UIStoryboard(name: "RutaDesbloqueada", bundle: nil);
        if let customAlert = modularStoryboard.instantiateViewController(withIdentifier: "MisBoletos") as? SideBarMisBoletosViewController {
            customAlert.providesPresentationContextTransitionStyle = true    //I don't know
            customAlert.definesPresentationContext = true                     //what this guys do
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(customAlert, animated: false, completion: nil)
        }
        else {
            fatalError()
        }
    }
    
    func showHelp() {
        let url = URL(string: "https://www.tourister.com.mx/faqs")
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
    
    func showSchedules() {
        
    }
    
    func closeSession() {
        /*let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "accessToken")*/
        let removeSuccessful = true
        if(removeSuccessful){
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
