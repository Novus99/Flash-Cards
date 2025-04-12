//
//  WordTranslationnCell.swift
//  Flash Cards
//
//  Created by Novus on 28/03/2025.
//

import UIKit

class WordTranslationCell: UITableViewCell {
    
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
