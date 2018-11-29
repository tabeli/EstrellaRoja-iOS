//
//  MisBoletosTableViewCell.swift
//  ER
//
//  Created by Tabatha Acosta on 11/28/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class MisBoletosTableViewCell: UITableViewCell {

    
    @IBOutlet weak var idNumber: UILabel!
    @IBOutlet weak var ticketDate: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        idNumber.adjustsFontSizeToFitWidth = true
        ticketDate.adjustsFontSizeToFitWidth = true
        name.adjustsFontSizeToFitWidth = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
