//
//  RutaTableViewCell.swift
//  ER
//
//  Created by Tabatha Acosta on 10/18/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class RutaTableViewCell: UITableViewCell {
    @IBOutlet weak var nombreRuta: UIButton!
    var id = -1
    
    @IBAction func verRutaAction(_ sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
