//
//  UserRegister.swift
//  ER
//
//  Created by Tabatha Acosta on 11/21/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import Foundation

struct UserRegister: Codable {
    //var user_type: Int
    var name: String
    var last_name: String
    var email: String
    var birthdate: String
    var password: String
    var postal_code: String
    var phone_number: String
    var user_type: String
}

