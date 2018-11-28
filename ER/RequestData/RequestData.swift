//
//  RequestData.swift
//  ER
//
//  Created by Tabatha Acosta on 11/20/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import Foundation

class RequestData {
    
    private init() {
        
    }
    static let shared = RequestData()
    
    let scheme = "https"
    //let domain = "principal-arena-219118.appspot.com"
    let domain = "adsoft-01.appspot.com"
    let subdomain = "/api/"
    let loginPath = "auth/login"
    let registerPath = "user"
    let getTourPath = "tour"
    let performPurchasePath = "purchase"
    let addTicketPath = "ticket"
    let getPurchasePath = "purchase"
    let getAllPlacesPath = "place"
    let getAllTourPlacesPath = "tour_place"
    let getAllStopPath = "stop"
    let getAllTourStopPath = "tour_stop"
    let getAllPlaceImagePath = "place_image"
    let getAllImagesPath = "image"
    let getAllBusesPath = "bus"
    let getAllMuralPath = "mural"
}
