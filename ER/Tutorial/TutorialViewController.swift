//
//  TutorialViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/26/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var EmpezarOutlet: UIButton!
    
    @IBAction func EmpezarAction(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToDescriptions", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmpezarOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        EmpezarOutlet.layer.cornerRadius = 15
        EmpezarOutlet.layer.borderWidth = 2
        EmpezarOutlet.layer.borderColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
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
