//
//  MuestraRutaActualViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/14/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SafariServices

/*class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubtitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubtitle
        self.coordinate = location
    }
}*/

class MuestraRutaActualViewController: UIViewController {

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
    
    var imageIdArr:[Int] = []
    var imagePathArr:[String] = []
    
    var placeImageIdArr:[Int] = []
    var imageId:[Int] = []
    
    var stopId:[Int] = []
    var stopName:[String] = []
    var stopLongitud:[Double] = []
    var stopLatitud:[Double] = []
    var stopDescription:[String] = []
    
    var stopTourId:[Int] = []
    var stopStopId:[Int] = []
   
    @IBAction func backArrow(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
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
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 2500
    
    var coordinatesArr:[CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 19.0380368, longitude: -98.1919112),
        CLLocationCoordinate2D(latitude: 19.0442404, longitude: -98.191289),
        CLLocationCoordinate2D(latitude: 19.0471625, longitude: -98.1892118),
        CLLocationCoordinate2D(latitude: 19.0529056, longitude: -98.1891781),
        CLLocationCoordinate2D(latitude: 19.0531589, longitude: -98.1851249),
        CLLocationCoordinate2D(latitude: 19.0579336, longitude: -98.1870003),
        CLLocationCoordinate2D(latitude: 19.0562241, longitude: -98.1827389),
        CLLocationCoordinate2D(latitude: 19.0525066, longitude: -98.179964),
        CLLocationCoordinate2D(latitude: 19.053879, longitude: -98.18019), //centro expositorio
        CLLocationCoordinate2D(latitude: 19.0548, longitude: -98.180408), //museo de la revolucion
        CLLocationCoordinate2D(latitude: 19.055348, longitude: -98.179562), //teleferico
        CLLocationCoordinate2D(latitude: 19.057018, longitude: -98.181575), //planetario
        CLLocationCoordinate2D(latitude: 19.060459, longitude: -98.184605), //monumento zaragoza
        CLLocationCoordinate2D(latitude: 19.044109, longitude: -98.192068), //num 6
    ]
    
    var markersArr:[MKPointAnnotation] = []
    var coordinatesMarkersArr:[CLLocationCoordinate2D] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerTourPlaceRequest()
        obtenerPlaceRequest()
        checkLocationServices()
        //coordinatesArr.append(locationManager.location!.coordinate)
        getDirections()
        //setMarkers()
        centerAll()
        /*for coordinate in coordinatesArr {
            let annotation = MKPointAnnotation()
            annotation.title = "Algo"
            annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            markersArr.append(annotation)
            mapView.addAnnotation(annotation)
        }*/
        // Do any additional setup after loading the view.
        //let center = CLLocationCoordinate2D(latitude: 19.0492479, longitude: -98.185815)
        //let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        //mapView.setRegion(region, animated: true)
    }
    
    
    /*func setMarkers() {
        
        for coordinate in coordinatesArr {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }*/
    
    func centerAll() {
        var maxLongitude = -1.0
        var minLongitude = -1.0
        var maxLatitude = -1.0
        var minLatitude = -1.0
        var index = 0
        for coordinate in coordinatesArr {
            if index == 0 {
                minLongitude = coordinate.longitude
                maxLongitude = coordinate.longitude
                
                minLatitude = coordinate.latitude
                minLatitude = coordinate.latitude
            }
            else {
                if coordinate.latitude < minLatitude {
                    minLatitude = coordinate.latitude
                }
                if coordinate.latitude > maxLatitude {
                    maxLatitude = coordinate.latitude
                }
                if coordinate.longitude < minLongitude {
                    minLongitude = coordinate.longitude
                }
                if coordinate.longitude > maxLongitude {
                    maxLongitude = coordinate.longitude
                }
            }
            index += 1
        }
        let mediumLongitude = minLongitude + ((maxLongitude - minLongitude) / 2)
        let mediumLatitude = minLatitude + ((maxLatitude - minLatitude) / 2)
        
        let center = CLLocationCoordinate2D(latitude: mediumLatitude, longitude: mediumLongitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /*func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let center = CLLocationCoordinate2D(latitude: 19.0492479, longitude: -98.185815)
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }*/
    
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
                    }
                    
                    self.coordinatesMarkersArr = []
                    for tourPlaceId in self.tourPlaceId {
                        var index = -1
                        for placeId in self.placeId {
                            index += 1
                            if (placeId == tourPlaceId) && (self.placeTypeId[index] == 1) {
                                let latitud = self.placeLatitud[index]
                                let longitud = self.placeLongitud[index]
                                self.coordinatesMarkersArr.append(CLLocationCoordinate2DMake(latitud, longitud))
                                print("AGREGO");
                                
                            }
                        }
                    }
                    print("MARKERS ARRAY")
                    print(self.coordinatesMarkersArr)
                    
                    var indice = -1
                    for coordinate in self.coordinatesMarkersArr {
                        print("Hago puntitos")
                        indice += 1
                        let annotation = MKPointAnnotation()
                        annotation.title = self.placeDescription[indice]
                        annotation.subtitle = self.placeName[indice]
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
                        if let mapElement = element as? [String:Any] {
                            if let tourId = mapElement["tour_id"] as? Int {
                                self.tourId.append(tourId)
                            }
                            if let placeId = mapElement["place_id"] as? Int {
                                self.tourPlaceId.append(placeId)
                            }
                        }
                    }
                    
                    
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
    
    func obtenerImagesRequest() {
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.getAllImagesPath
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
                            if let imageId = mapElement["id"] as? Int {
                                self.imageIdArr.append(imageId)
                            }
                            if let imagePath = mapElement["image_path"] as? String {
                                self.imagePathArr.append(imagePath)
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
        
    func obtenerPlaceImageRequest() {
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.getAllPlaceImagePath
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
                            if let placeId = mapElement["place_id"] as? Int {
                                self.placeImageIdArr.append(placeId)
                            }
                            if let imageId = mapElement["image_id"] as? Int {
                                self.imageId.append(imageId)
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
    
    
    func obtenerStopRequest() {
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.getAllStopPath
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
                            if let id = mapElement["id"] as? Int {
                                self.stopId.append(id)
                            }
                            if let name = mapElement["name"] as? String {
                                self.stopName.append(name)
                            }
                            if let longitude = mapElement["longitude"] as? Double {
                                self.stopLongitud.append(longitude)
                            }
                            if let latitude = mapElement["latitude"] as? Double {
                                self.stopLatitud.append(latitude)
                            }
                            if let description = mapElement["description"] as? String {
                                self.stopDescription.append(description)
                            }
                        }
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.obtenerTourPlaceRequest()
                    }
                    
                    self.coordinatesArr = []
                    for stopStopId in self.stopStopId {
                        var index = -1
                        for stopId in self.stopId {
                            index += 1
                            if (stopStopId == stopId) && (self.stopTourId[index] == 17) {
                                let latitud = self.stopLatitud[index]
                                let longitud = self.stopLongitud[index]
                                self.coordinatesArr.append(CLLocationCoordinate2DMake(latitud, longitud))
                                
                            }
                        }
                    }
                    
                    
                    /*self.coordinatesArr = []
                    for i in 0..<self.stopLatitud.count{
                        self.coordinatesArr.append(CLLocationCoordinate2D(latitude: self.stopLatitud[i], longitude: self.stopLongitud[i]))
                    }*/
                    self.getDirections()
                    
                    
                    print("ESTO TIENE QUE JALAR")
                    print(self.stopLatitud)
                    /*
                     coordinatesArr:[CLLocationCoordinate2D] = [
                     CLLocationCoordinate2D(latitude: 19.0380368, longitude: -98.1919112),
                     */
                    
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
    
    
    func obtenerTourStopRequest() {
        var urlComponents = URLComponents() // Forma el url
        urlComponents.scheme = RequestData.shared.scheme
        urlComponents.host = RequestData.shared.domain
        urlComponents.path = RequestData.shared.subdomain + RequestData.shared.getAllTourStopPath
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
                            if let tourId = mapElement["tour_id"] as? Int {
                                self.stopTourId.append(tourId)
                            }
                            if let stopId = mapElement["stop_id"] as? Int {
                                self.stopStopId.append(stopId)
                            }
                        }
                    }
                    
                    /*
                     coordinatesArr:[CLLocationCoordinate2D] = [
                     CLLocationCoordinate2D(latitude: 19.0380368, longitude: -98.1919112),
                     */
                    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MuestraRutaActualViewController: CLLocationManagerDelegate {
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Something
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        print(locations.last)
        
    }*/
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //More else
        checkLocationAuthorization()
    }
    
    
    
    
}


extension MuestraRutaActualViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = #colorLiteral(red: 0.8829703927, green: 0.1867307127, blue: 0.4812199473, alpha: 1)
        let rand = Int.random(in: 0...10)
        
        
       /* switch rand {
        case 0:
            renderer.strokeColor = #colorLiteral(red: 0.8829703927, green: 0.1867307127, blue: 0.4812199473, alpha: 1)
        case 1:
            renderer.strokeColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case 2:
            renderer.strokeColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case 3:
            renderer.strokeColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case 4:
            renderer.strokeColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case 5:
            renderer.strokeColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case 6:
            renderer.strokeColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        case 7:
            renderer.strokeColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case 8:
            renderer.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case 9:
            renderer.strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        case 10:
            renderer.strokeColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)

        default:
            renderer.strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }*/
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

extension MuestraRutaActualViewController: SideBarDelegate{
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

