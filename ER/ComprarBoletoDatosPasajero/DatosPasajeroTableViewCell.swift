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
        for button in genderButtons {
            button.backgroundColor = .clear
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 2
            button.layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
        }
        sender.backgroundColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
        //cell.genderButtons[0].layer.borderColor = #colorLiteral(red: 0.1574883461, green: 0.6851269603, blue: 0.009970044717, alpha: 1)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        touristName.keyboardType = .alphabet
        touristName.autocapitalizationType = .words
        touristName.returnKeyType = .done
        touristName.delegate = self
        
        age.keyboardType = .numberPad
        age.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func crearToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        
        let doneButton = UIBarButtonItem(title: "Listo", style: .plain, target: self, action: #selector(RegistroViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        age.inputAccessoryView = toolBar
        
    }

}

extension DatosPasajeroTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //self.view.endEditing(true)
        
        return true
    }
    
}
