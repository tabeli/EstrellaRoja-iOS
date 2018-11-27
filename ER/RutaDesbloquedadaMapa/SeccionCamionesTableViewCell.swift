//
//  SeccionCamionesTableViewCell.swift
//  ER
//
//  Created by Tabatha Acosta on 11/26/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class SeccionCamionesTableViewCell: UITableViewCell {

    @IBOutlet weak var numeroCamionOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numeroCamionOutlet.titleLabel?.adjustsFontSizeToFitWidth = true
        numeroCamionOutlet.layer.cornerRadius = 15
        numeroCamionOutlet.layer.borderWidth = 2
        numeroCamionOutlet.layer.borderColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
