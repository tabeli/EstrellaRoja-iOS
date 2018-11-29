//
//  MuestraConveniosMapViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/28/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SafariServices

class MuestraConveniosMapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var idRuta = 0
    
    var placeId:[Int] = []
    var placeTypeId:[Int] = []
    var placeNarrativeId:[Int] = []
    var placeName:[String] = []
    var placeLongitud:[Double] = []
    var placeLatitud:[Double] = []
    var placeDescription:[String] = []
    
    var tourId:[Int] = []
    var tourPlaceId:[Int] = []
    
    var markersArr:[MKPointAnnotation] = []
    var coordinatesMarkersArr:[CLLocationCoordinate2D] = []
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 3000
    
     var coordinatesArr:[CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtenerTourPlaceRequest()
        obtenerPlaceRequest()
        checkLocationServices()
        //coordinatesArr.append(locationManager.location!.coordinate)
        getDirections()
        //setMarkers()
        centerAll()
        
        // Do any additional setup after loading the view.
    }
    
    func centerAll() {
        
        let center = CLLocationCoordinate2D(latitude: 19.03968, longitude: -98.211561)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if(CLLocationManager.locationServicesEnabled()){
            //settup location manager
            setupLocationManager()
            checkLocationAuthorization()
        }
        else {
            let title = "Error"
            let message = "Ubicación desactivada, puedes activarla en tus Configuraciones"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            //Map stuff
            mapView.showsUserLocation = true
            //centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            let title = "Error"
            let message = "Ubicación desactivada, los servicios de la aplicación no podrán funcionar apropiadamente, puedes activarla en tus Configuraciones"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            //mapView.showsUserLocation = true
            break
        }
    }
    
    
    func getDirections(){
        var index = -1
        for _ in self.coordinatesArr {
            index += 1
            var nextIndex = index+1
            if(nextIndex == coordinatesArr.count){
                nextIndex = 0
            }
            let start = coordinatesArr[index]
            let end = coordinatesArr[nextIndex]
            
            let request = createDirectionRequest(from: start, to: end)
            let directions = MKDirections(request: request)
            directions.calculate { [unowned self] (response,error) in
                if let _ = error{
                    return
                }
                guard let response = response else {
                    return
                }
                
                for route in response.routes {
                    self.mapView.addOverlay(route.polyline)
                    //self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                }
            }
        }
    }
    
    func createDirectionRequest(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) -> MKDirections.Request {
        let start = MKPlacemark(coordinate: origin)
        let end = MKPlacemark(coordinate: destination)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: start)
        request.destination = MKMapItem(placemark: end)
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        return request
    }
    
    func obtenerPlaceRequest() {
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.getAllPlacesPath
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
                
                /*print("DATOS QUE JALE")
                 print(stringData)*/
                do{
                    
                    // Casteas el dataMap de un data a un json de tipo string a cualquier cosa
                    let dataArr = try JSONSerialization.jsonObject(with: dataUnwrapped, options: .mutableContainers) as! [Any]
                    // Checas si el valor con se agrego el id
                    for element in dataArr {
                        if let mapElement = element as? [String:Any] {
                            if let id = mapElement["id"] as? Int {
                                self.placeId.append(id)
                            }
                            if let placeTypeId = mapElement["place_type_id"] as? Int {
                                self.placeTypeId.append(placeTypeId)
                            }
                            if let narrativeId = mapElement["narrative_id"] as? Int {
                                self.placeNarrativeId.append(narrativeId)
                            }
                            if let name = mapElement["name"] as? String {
                                self.placeName.append(name)
                            }
                            if let longitude = mapElement["longitude"] as? Double {
                                self.placeLongitud.append(longitude)
                            }
                            if let latitude = mapElement["latitude"] as? Double {
                                self.placeLatitud.append(latitude)
                            }
                            if let description = mapElement["description"] as? String {
                                self.placeDescription.append(description)
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.obtenerTourPlaceRequest()
                        print("HAGO LO DEL DISPATCH")
                    }
                    
                    self.coordinatesArr = []
                    //for tourPlaceId in self.tourPlaceId {
                        print("uno")
                        var index = -1
                        for placeId in self.placeId {
                            print("dos")
                            index += 1
                            print(self.placeTypeId[index])
                            if self.placeTypeId[index] != 1 {
                                print("REPITOO")
                                let latitud = self.placeLatitud[index]
                                let longitud = self.placeLongitud[index]
                                self.coordinatesArr.append(CLLocationCoordinate2DMake(latitud, longitud))
                                print("AGREGO");
                                
                            }
                        }
                    //}
                    print("MARKERS ARRAY")
                    print("PORQUE NO JALAAA")
                    print(self.coordinatesArr)
                    
                    var indice = -1
                    for coordinate in self.coordinatesArr {
                        print("Hago puntitos")
                        indice += 1
                        let annotation = MKPointAnnotation()
                        print("ELEMENTOS EN LA WEA")
                        print(self.coordinatesArr.count)
                        annotation.title = self.placeName[indice]
                        annotation.subtitle = self.placeDescription[indice]
                        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        self.markersArr.append(annotation)
                        self.mapView.addAnnotation(annotation)
                    }
                    
                    print(self.placeTypeId)
                    print("A VER QUE SALE")
                    print(self.placeLatitud)
                    
                    /*for i in 0..<self.placeLatitud.count{
                     if self.placeTypeId[i] == 20 {
                     self.coordinatesArr.append(CLLocationCoordinate2D(latitude: self.placeLatitud[i], longitude: self.placeLongitud[i]))
                     }
                     }*/
                    
                    //self.getDirections()
                    /*
                     coordinatesArr:[CLLocationCoordinate2D] = [
                     CLLocationCoordinate2D(latitude: 19.0380368, longitude: -98.1919112),
                     */
                    
                    print("ACABE DE JALAR LOS DATOS")
                } catch {
                    print("ERROR: \(error)") //Por si se muere si no puedes parser el data a un json
                }
                DispatchQueue.main.async {
                    //self.tableView.reloadData()
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
    
    func obtenerTourPlaceRequest() {
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.getAllTourPlacesPath
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
                        //print("EN EL FOR")
                        if let mapElement = element as? [String:Any] {
                            //print("SI EVALUO QUE ONDA")
                            if let tourId = mapElement["tour_id"] as? Int {
                                self.tourId.append(tourId)
                            }
                            if let placeId = mapElement["place_id"] as? Int {
                                self.tourPlaceId.append(placeId)
                            }
                        }
                    }
                    
                    
                    //print("ACABE DE JALAR LOS DATOS")
                } catch {
                    print("ERROR: \(error)") //Por si se muere si no puedes parser el data a un json
                }
                DispatchQueue.main.async {
                    //self.tableView.reloadData()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MuestraConveniosMapViewController: CLLocationManagerDelegate {
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     //Something
     guard let location = locations.last else { return }
     let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
     let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
     mapView.setRegion(region, animated: true)
     print(locations.last)
     
     }*/
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MuestraConveniosMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = #colorLiteral(red: 0.8829703927, green: 0.1867307127, blue: 0.4812199473, alpha: 1)
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annView = view.annotation
        let storyboard = UIStoryboard(name: "RutaDesbloqueada", bundle: nil)
        let detalleVC = storyboard.instantiateViewController(withIdentifier: "Detalle") as! DetalleViewController
        detalleVC.nombre = (annView?.title!)!
        detalleVC.descripcion = (annView?.subtitle!)!
        detalleVC.latitud = (annView?.coordinate.latitude)!
        detalleVC.longitud = (annView?.coordinate.longitude)!
        
        self.navigationController?.pushViewController(detalleVC, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKAnnotationView
        { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView!.image = UIImage(named: "pindos")
        annotationView!.canShowCallout = true
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return annotationView
    }
    
}

extension MuestraConveniosMapViewController: SideBarDelegate {
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

