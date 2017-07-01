//
//  NameCell.swift
//  RedditTableView
//
//  Created by Kyle Nakamura on 6/30/17.
//  Copyright © 2017 Kyle Nakamura. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ name: String) {
        nameLbl.text = name
    }
}
