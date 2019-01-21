//
//  String+Extensions.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import Foundation

extension String {
    
    func formatDateString() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy HH:mm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatter.string(from: date)
        } else {
            return self
        }
    }
    
    func formatCurrency() -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        if let number = Double(self.replacingOccurrences(of: ",", with: ".")), let formattedAmount = formatter.string(from: NSNumber(value: number)) {
            return formattedAmount
        } else {
            return self
        }
    }
    
    func extractCoordinates() -> [String]{
        let coordinatesArray = self.split(separator: ",")
        
        if coordinatesArray.count == 2 {
            let stringLatitude = "\(coordinatesArray[0])"
            let stringLongitude = "\(coordinatesArray[1])"
        }
        
        
        return ["",""]
    }
}
