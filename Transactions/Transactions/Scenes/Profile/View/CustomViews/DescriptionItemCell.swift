//
//  DescriptionItemCell.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class DescriptionItemCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.setSelected(false, animated: true)
    }
    
    func setContent(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}
