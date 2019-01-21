//
//  BalanceItemCell.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/16/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

class BalanceItemCell: UITableViewCell {
    
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var valueLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var labelsContentView: UIView!
    @IBOutlet weak private var transactionIndicatorView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelsContentView.layer.cornerRadius = 4
        self.transactionIndicatorView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.setSelected(false, animated: true)
    }
    
    func setContent(transaction: TransactionViewModel) {
        self.descriptionLabel.text = transaction.description
        self.valueLabel.text = transaction.amount
        self.dateLabel.text = transaction.date
        
        if transaction.transactionType == .debit {
            self.transactionIndicatorView.backgroundColor = Colors.debitColor
        } else {
            self.transactionIndicatorView.backgroundColor = Colors.creditColor
        }
    }
}
