//
//  BalanceItemCell.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/16/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class BalanceItemCell: UITableViewCell {
    
    @IBOutlet weak var transactionNameLabel: UILabel!
    @IBOutlet weak var transactionValueLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var labelsContentView: UIView!
    @IBOutlet weak var tansactionIndicatorView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelsContentView.layer.cornerRadius = 4
        self.tansactionIndicatorView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.setSelected(false, animated: true)
    }
}
