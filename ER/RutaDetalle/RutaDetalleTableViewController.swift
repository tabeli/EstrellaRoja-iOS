//
//  RutaDetalleTableViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/19/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class RutaDetalleTableViewController: UITableViewController {
    
    var idRuta = -1
    var nameRuta = ""
    var imageRuta = ""
    var descriptionRuta = ""
    let img = "pueblaredondo.png"
    let descripcion = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution"
    var heights:[CGFloat] = [CGFloat(0.0),CGFloat(0.0),CGFloat(0.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        
        
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
        return 3
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath:\(indexPath)")

        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detalleImagenCell", for: indexPath) as! DetalleImagenRutaTableViewCell
            cell.rutaImg.image = UIImage(named: img)
            
            
            var height = CGFloat(0.0)
            for view in cell.subviews {
                height += view.frame.height
            }
            heights.append(height)

            cell.heightAnchor.constraint(equalToConstant: height).isActive = true
            return cell
        }
        else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detalleDescripcionCell", for: indexPath) as! DetalleDescripcionRutaTableViewCell
            
            cell.rutaDescripcion.text = descriptionRuta
            print("PREVIOUS \(cell.rutaDescripcion.frame.height)")
            if let textView = cell.rutaDescripcion{
                let fixedWidth = textView.frame.size.width
                let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            }
            else{
                print("alksjfdalskdfjalskfjdlaskdfjalskjdflakj")
            }
            
            var height = CGFloat(0.0)
            for view in cell.subviews {
                height += view.frame.height
            }
            heights.append(height)
            
            cell.heightAnchor.constraint(equalToConstant: height).isActive = true
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detalleComprarCell", for: indexPath) as! DetalleComprarRutaTableViewCell
            cell.rutaId = idRuta
            var height = CGFloat(0.0)
            for view in cell.subviews {
                height += view.frame.height
            }
            heights.append(height)
            
            cell.heightAnchor.constraint(equalToConstant: height).isActive = true
            return cell
        }
        

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 2) {
            let dad = self.parent as! RutaDetalleViewController
            dad.performSegue(withIdentifier: "compraSegue", sender: nil)
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
