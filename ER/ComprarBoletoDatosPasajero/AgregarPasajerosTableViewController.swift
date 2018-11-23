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
        for _ in 0...sumOfTouristRows {
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
            
            print("now cell gender is \(cell.gender)")
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
    func didTapAcceptTerms() {
    
    }
    func didTapSeeTerms(url: String) {
        let webPageURL = URL(string: url)!
        let safariVC = SFSafariViewController(url: webPageURL)
        present(safariVC, animated: true, completion: nil)
    }
    func didTapContinueWithPayment() {
        let dad = self.parent as! AgregarPasajerosViewController
        dad.performSegue(withIdentifier: "CompletaPagoSegue", sender: nil)
    }
    
}
