//
//  RutaTableViewCell.swift
//  ER
//
//  Created by Tabatha Acosta on 10/18/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class RutaTableViewCell: UITableViewCell {
    @IBOutlet weak var nombreRuta: UILabel!
    var tourIdArray = -1
    var tourNameArray = ""
    var tourImageArray = ""
    var tourDescriptionArray = ""

    
    override func awakeFromNib() {
        super.awakeFromNib()
        nombreRuta.adjustsFontSizeToFitWidth = true
        nombreRuta.layer.backgroundColor = #colorLiteral(red: 0.9890534282, green: 0.7165058255, blue: 0, alpha: 1)
        nombreRuta.layer.cornerRadius = 15
        nombreRuta.layer.borderWidth = 2
        nombreRuta.layer.borderColor = #colorLiteral(red: 0.8271533947, green: 0.5080588404, blue: 0.0448990865, alpha: 1)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
