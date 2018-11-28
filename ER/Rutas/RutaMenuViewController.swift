//
//  RutaMenuViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 10/18/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit
import SafariServices

class RutaMenuViewController: UIViewController {
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleRutaSegue"{
            let vc = segue.destination as! RutaDetalleViewController
            let cell = sender as! RutaTableViewCell
            vc.idRuta = cell.tourIdArray
            vc.nameRuta = cell.tourNameArray
            vc.imageRuta = cell.tourImageArray
            vc.descriptionRuta = cell.tourDescriptionArray
            print("uno - qwertqwertqwert")
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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

extension RutaMenuViewController: SideBarDelegate{
    func showTickets() {
        print("SWJHOTTICKETS")
        let modularStoryboard = UIStoryboard(name: "RutaDesbloqueada", bundle: nil);
        if let customAlert = modularStoryboard.instantiateViewController(withIdentifier: "MisBoletos") as? SideBarMisBoletosViewController {
            customAlert.providesPresentationContextTransitionStyle = true    //I don't know
            customAlert.definesPresentationContext = true                     //what this guys do
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(customAlert, animated: false, completion: nil)
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
