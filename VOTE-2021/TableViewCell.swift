//
//  TableViewCell.swift
//  VOTE-2021
//
//  Created by clau93 on 16/11/20.
//  Copyright © 2020 Marco Antonio Olalde. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitulo: UILabel!
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
