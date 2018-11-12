//
//  SiguienteTableViewCell.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

class SiguienteTableViewCell: UITableViewCell {
    @IBOutlet weak var selectTerms: UIButton!
    @IBOutlet weak var linkTermsAndConditions: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBAction func acceptTerms(_ sender: UIButton) {
    }
    @IBAction func seeTerms(_ sender: UIButton) {
    }
    @IBAction func continueWithPayment(_ sender: UIButton) {
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
