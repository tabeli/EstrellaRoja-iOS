//
//  TutorialDetalleViewController.swift
//  ER
//
//  Created by Tabatha Acosta on 11/26/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class TutorialDetalleViewController: UIViewController {

    @IBOutlet weak var centralBackground: UIImageView!
    @IBOutlet weak var centralImage: UIImageView!
    @IBOutlet weak var centralTitle: UILabel!
    @IBOutlet weak var centralSubtitle: UILabel!
    
    var backgroundStr = ""
    var imageStr = ""
    var titleStr = ""
    var subtitleStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if centralBackground != nil {
            centralBackground.image = UIImage(named: self.backgroundStr)
        }
        if centralImage != nil {
            centralImage.image = UIImage(named: self.imageStr)
        }
        if centralTitle != nil {
            centralTitle.text = self.titleStr
        }
        if centralSubtitle != nil {
            centralSubtitle.text = self.subtitleStr
        }
        
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
