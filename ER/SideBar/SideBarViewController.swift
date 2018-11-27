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
    @IBOutlet weak var misBoletosOutlet: UILabel!
    @IBOutlet weak var horariosOutlet: UILabel!
    @IBOutlet weak var ayudaOutlet: UILabel!
    @IBOutlet weak var cerrarSesionOutlet: UILabel!
    
    @IBOutlet weak var constraintImportante: NSLayoutConstraint!
    
    var delegate: SideBarDelegate!
    
    @IBAction func misBoletosAction(_ sender: UIButton) {
        
        dismissView(closeSession: false)
    }
    
    @IBAction func horariosAction(_ sender: UIButton) {
        
        dismissView(closeSession: false)
    }
    
    @IBAction func ayudaAction(_ sender: UIButton) {
        let url = URL(string: "https://www.tourister.com.mx/faqs")
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
        dismissView(closeSession: false)
    }
    
    @IBAction func cerrarSesionAction(_ sender: UIButton) {
        
        dismissView(closeSession: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        misBoletosOutlet.adjustsFontSizeToFitWidth = true
        horariosOutlet.adjustsFontSizeToFitWidth = true
        ayudaOutlet.adjustsFontSizeToFitWidth = true
        cerrarSesionOutlet.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
        
        self.constraintImportante.constant = 0
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(SideBarViewController.swipeToDismiss))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left{
            dismissView(closeSession: false)
        }
    }
    
    @objc func swipeToDismiss(){
        dismissView(closeSession: false)
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
    func dismissView(closeSession: Bool){
        self.constraintImportante.constant = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }) { (result: Bool) in
            //what the hell is this syntax...
            self.dismiss(animated: true, completion: {
                if(closeSession){
                    self.delegate?.closeSession()
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
