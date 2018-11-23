//
//  DetalleComprarRutaTableViewCell.swift
//  ER
//
//  Created by Tabatha Acosta on 10/19/18.
//  Copyright © 2018 Tabatha Acosta. All rights reserved.
//

import UIKit

protocol DetalleComprarRutaTableViewCellDelegate {
    func didTapRutaCompra()
}

class DetalleComprarRutaTableViewCell: UITableViewCell {

    var rutaId = -1
    var delegate: DetalleComprarRutaTableViewCellDelegate?
    
    @IBAction func rutaCompra(_ sender: UIButton) {
        delegate?.didTapRutaCompra()
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
