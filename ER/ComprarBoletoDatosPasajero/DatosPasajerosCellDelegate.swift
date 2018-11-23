//
//  DatosPasajerosCellDelegate.swift
//  ER
//
//  Created by Tabatha Acosta on 11/21/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import Foundation

protocol DatosPasajerosCellDelegate {
    func didSelectGender(cellId:Int, gender: String)
    func didUpdateTextFields(cellId:Int, name: String, age: String)
}
