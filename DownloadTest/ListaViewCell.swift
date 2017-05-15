//
//  ListaViewCell.swift
//  DownloadTest
//
//  Created by David on 15/5/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ListaViewCell: UITableViewCell {

    @IBOutlet weak var NombreCar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

    override func prepareForReuse()
    {
        self.NombreCar.text = ""
    }
    
}
