//
//  SiguienteTableViewCell.swift
//  ER
//
//  Created by Tabatha Acosta on 10/17/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

protocol SiguienteTableViewCellDelegate {
    func didTapAcceptTerms(cell: UITableViewCell)
    func didTapSeeTerms(url: String)
    func didTapContinueWithPayment(cell: UITableViewCell)
}

class SiguienteTableViewCell: UITableViewCell {
   
    @IBOutlet weak var selectTerms: UIButton!
    @IBOutlet weak var linkTermsAndConditions: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var didAcceptTerms = false
    
    var delegate: SiguienteTableViewCellDelegate?
    var url = "https://www.tourister.com.mx/aviso-privacidad"
    
    @IBAction func acceptTerms(_ sender: UIButton) {
        delegate?.didTapAcceptTerms(cell: self)
    }
    @IBAction func seeTerms(_ sender: UIButton) {
        delegate?.didTapSeeTerms(url: url)
    }
    @IBAction func continueWithPayment(_ sender: UIButton) {
        delegate?.didTapContinueWithPayment(cell: self)
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
