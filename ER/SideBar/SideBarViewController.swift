//
//  SideBarViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/26/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit
import SafariServices

class SideBarViewController: UIViewController {
    
    @IBOutlet weak var backgroudBar: UIView!
    
    @IBOutlet weak var canjearPulseraOutlet: UILabel!
    @IBOutlet weak var misBoletosOutlet: UILabel!
    @IBOutlet weak var horariosOutlet: UILabel!
    @IBOutlet weak var seleccionaIdiomaOutlet: UILabel!
    @IBOutlet weak var terminosCondiciones: UILabel!
    @IBOutlet weak var ayudaOutlet: UILabel!
    @IBOutlet weak var cerrarSesionOutlet: UILabel!
    
    @IBOutlet weak var constraintImportante: NSLayoutConstraint!
    
    var delegate: SideBarDelegate!
    
    
    @IBAction func canjearPulseraAction(_ sender: UIButton) {
        dismissView(action: 0)
    }
    
    @IBAction func misBoletosAction(_ sender: UIButton) {
        dismissView(action: 1)
        print("show tickets on mis boletos action")
        
        
    }
    
    @IBAction func horariosAction(_ sender: UIButton) {
        dismissView(action: 2)
    }
    
    
    @IBAction func seleccionaIdiomaAction(_ sender: UIButton) {
        dismissView(action: 3)
    }
    
    @IBAction func facturacionAction(_ sender: UIButton) {
        dismissView(action: 4)
        print("show facturacion action")
    }
    
    
    @IBAction func terminosCondicionesAction(_ sender: UIButton) {
        dismissView(action: 5)
    }
    
    @IBAction func ayudaAction(_ sender: UIButton) {
        dismissView(action: 6)
    }
    
    @IBAction func cerrarSesionAction(_ sender: UIButton) {
        dismissView(action: 7)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        misBoletosOutlet.adjustsFontSizeToFitWidth = true
        horariosOutlet.adjustsFontSizeToFitWidth = true
        seleccionaIdiomaOutlet.adjustsFontSizeToFitWidth = true
        terminosCondiciones.adjustsFontSizeToFitWidth = true
        ayudaOutlet.adjustsFontSizeToFitWidth = true
        cerrarSesionOutlet.adjustsFontSizeToFitWidth = true
        canjearPulseraOutlet.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
        
        self.constraintImportante.constant = 0
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(SideBarViewController.swipeToDismiss))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            dismissView(action: 10)
        }
    }
    
    @objc func swipeToDismiss(){
        dismissView(action: 10)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.constraintImportante.constant = self.backgroudBar.frame.width-5
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //Close session tells if the session should be closed once the view is dismissed
    func dismissView(action: Int){
        /*
         0 Pulsera
         1 Boletos
         2 Horarios
         3 Idiomas
         4 Factura
         5 Terminos
         6 Ayuda
         7 Cerrar sesion
         
         */
        self.constraintImportante.constant = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { (result: Bool) in
            //what the hell is this syntax...
            self.dismiss(animated: true, completion: {
                switch action {
                    case 0:
                        self.delegate?.showBracelet()
                    break;
                    case 1:
                        self.delegate?.showTickets()
                    break;
                    case 2:
                        self.delegate?.showSchedules()
                    break;
                    case 3:
                        self.delegate.showLanguage()
                    break;
                    case 4:
                        self.delegate?.showBill()
                    break;
                    case 5:
                        self.delegate?.showTerms()
                    break;
                    case 6:
                        self.delegate?.showHelp()
                    break;
                    case 7:
                        self.delegate.closeSession()
                    break;
                    default:
                        print("ola")
                    break;
                }
            })
        }
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
