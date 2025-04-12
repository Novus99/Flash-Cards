//
//  CollectionCell.swift
//  Flash Cards
//
//  Created by Novus on 12/04/2025.
//

import UIKit

class CollectionCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
