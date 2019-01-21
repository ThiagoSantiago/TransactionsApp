//
//  TransactionsListPresenter.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/17/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

protocol TransactionListPresentationLogic {
    func closeLoadingView()
    func presentLoadingView()
    func presentUser(_ image: UIImage)
    func presentList(_ transactions: TransactionList)
    func presentError(_ error: TransactionsAPIError)
}

class TransactionListPresenter: TransactionListPresentationLogic {

    weak var viewController: TransactionsListDisplayLogic?
    var totalBalance = 0.0
    
    func closeLoadingView() {
        viewController?.hideLoadingView()
    }
    
    func presentLoadingView() {
        viewController?.displayLoadingView()
    }
    func presentUser(_ image: UIImage) {
        viewController?.displayUser(image: image)
    }
    
    func presentList(_ transactions: TransactionList) {
        viewController?.displayTransactions(list: treatTransactionData(transactions))
    }
    
    func treatTransactionData(_ data: TransactionList) -> TransactionsListViewModel {
        var balance = 0.0
        var transactions: [TransactionViewModel] = []
        
        for transaction in data.transactions {
            var latitude = 0.0
            var longitude = 0.0
            
            let dateFormatted = transaction.date.formatDateString()
            let amoutFormatted = transaction.amount.formatCurrency()
            let effectiveDateFormatted = transaction.effectiveDate.formatDateString()
            let transactionType: TransactionType = transaction.amount.contains("-") ? .debit : .credit
            
            if transaction.coordinates.extractCoordinates().count == 2 {
                latitude = Double(transaction.coordinates.extractCoordinates()[1]) ?? 0.0
                longitude = Double(transaction.coordinates.extractCoordinates()[0]) ?? 0.0
            }
            
            let viewModel = TransactionViewModel(date: dateFormatted,
                                                 amount: amoutFormatted,
                                                 description: transaction.description,
                                                 latitude: latitude,
                                                 longitude: longitude,
                                                 effectiveDate: effectiveDateFormatted, transactionType: transactionType)
            
            transactions.append(viewModel)
            
            let amount = Double(transaction.amount.replacingOccurrences(of: ",", with: ".")) ?? 0.0
            balance += amount
        }
        
        self.totalBalance += balance
        return TransactionsListViewModel(transactions: transactions,
                                         nextPage: data.nextPage,
                                         totalBalance: self.totalBalance.formattedToCurrency)
    }
    
    func presentError(_ error: TransactionsAPIError) {
        viewController?.displayError(message: error.errorMessage)
    }
}
