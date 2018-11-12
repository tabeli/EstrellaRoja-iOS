//
//  RutasTableViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/18/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class RutasTableViewController: UITableViewController {
    let nombreRuta = ["PueblaFascinante", "Cholula Milenaria", "Otra"]
    let numeroRutas = 3
    let id = [0,1,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hola")
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
        return numeroRutas
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("bye")
        print("indexPath:\(indexPath)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rutaCell", for: indexPath) as! RutaTableViewCell
        cell.id = id[indexPath.row]
        cell.nombreRuta.text = nombreRuta[indexPath.row]
        // Configure the cell...
        cell.nombreRuta.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RutaTableViewCell
        let dad = self.parent as! RutaMenuViewController
        dad.performSegue(withIdentifier: "detalleRutaSegue", sender: cell)
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
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

    
    
    

}
