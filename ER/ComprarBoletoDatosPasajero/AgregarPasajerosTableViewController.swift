//
//  AgregarPasajerosTableViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class AgregarPasajerosTableViewController: UITableViewController {
    let userType = ["Adulto", "Niño", "INAPAM"]
    //2,4,3
    var countAdulto = 0
    var countNino = 0
    var countInapam = 0
    
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
            return cell
        }
        else if(indexPath.row == (countAdulto + countNino + countInapam + 1)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "siguienteCell", for: indexPath) as! SiguienteTableViewCell
        cell.linkTermsAndConditions.titleLabel?.adjustsFontSizeToFitWidth = true
            cell.nextButton.backgroundColor = .clear
            cell.nextButton.layer.cornerRadius = 15
            cell.nextButton.layer.borderWidth = 2
            cell.nextButton.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            
            return cell
        }
        else{
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
            //cell.userType.text = userType[indexPath.row-1]
            cell.genderButtons[0].backgroundColor = .clear
            cell.genderButtons[0].layer.cornerRadius = 5
            cell.genderButtons[0].layer.borderWidth = 2
            cell.genderButtons[0].layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            cell.genderButtons[1].backgroundColor = .clear
            cell.genderButtons[1].layer.cornerRadius = 5
            cell.genderButtons[1].layer.borderWidth = 2
            cell.genderButtons[1].layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            
            // #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
            return cell
        }

        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == countAdulto + countNino + countInapam + 1) {
            let dad = self.parent as! AgregarPasajerosViewController
            dad.performSegue(withIdentifier: "CompletaPagoSegue", sender: nil)
        }
        
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
