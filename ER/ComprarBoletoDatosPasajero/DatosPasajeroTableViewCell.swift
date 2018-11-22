//
//  DatosPasajeroTableViewCell.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class DatosPasajeroTableViewCell: UITableViewCell {
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var touristName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet var genderButtons: [UIButton]!
    
    @IBAction func chooseGender(_ sender: UIButton) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        touristName.keyboardType = .alphabet
        touristName.autocapitalizationType = .words
        touristName.returnKeyType = .done
        touristName.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DatosPasajeroTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //self.view.endEditing(true)
        
        return true
    }
    
}
