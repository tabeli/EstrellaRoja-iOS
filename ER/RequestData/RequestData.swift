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
    
    let scheme = "http"
    let domain = "principal-arena-219118.appspot.com"
    let subdomain = "/api/"
    let loginPath = "auth/login"
    let registerPath = "user"
    let getTourPath = "tour"
    let performPurchasePath = "purchase"
    let addTicketPath = "ticket"
}
