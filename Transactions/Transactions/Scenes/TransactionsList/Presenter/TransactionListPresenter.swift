//
//  TransactionsListPresenter.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

protocol TransactionListPresentationLogic {
    func presentList(_ transactions: TransactionList)
    func presentError(_ error: TransactionsAPIError)
}

class TransactionListPresenter: TransactionListPresentationLogic {
    weak var viewController: TransactionsListDisplayLogic?
    
    func presentList(_ transactions: TransactionList) {
        
        viewController?.displayTransactions(list: treatTransactionData(transactions))
    }
    
    private func treatTransactionData(_ data: TransactionList) -> TransactionsListViewModel {
        var totalBalance = 0.0
        var transactions: [TransactionViewModel] = []
        
        for transaction in data.transactions {
            let dateFormatted = transaction.date.formatDateString()
            let amoutFormatted = transaction.amount.formatCurrency()
            let latitude = Double(transaction.coordinates.extractCoordinates()[0]) ?? 0.0
            let longitude = Double(transaction.coordinates.extractCoordinates()[1]) ?? 0.0
            let effectiveDateFormatted = transaction.effectiveDate.formatDateString()
            let transactionType: TransactionType = transaction.amount.contains("-") ? .debit : .credit
            
            let viewModel = TransactionViewModel(date: dateFormatted,
                                                 amount: amoutFormatted,
                                                 description: transaction.description,
                                                 latitude: latitude,
                                                 longitude: longitude,
                                                 effectiveDate: effectiveDateFormatted, transactionType: transactionType)
            
            transactions.append(viewModel)
            
            let amount = Double(transaction.amount.replacingOccurrences(of: ",", with: ".")) ?? 0.0
            totalBalance += amount
            
        }
        
        return TransactionsListViewModel(transactions: transactions,
                                         nextPage: data.nextPage,
                                         totalBalance: totalBalance.formattedToCurrency)
    }
    
    func presentError(_ error: TransactionsAPIError) {
        viewController?.displayError(message: error.errorMessage)
    }
}
