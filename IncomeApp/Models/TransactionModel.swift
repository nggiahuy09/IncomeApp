//
//  TransactionModel.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import Foundation

struct TransactionModel: Identifiable {
    let id = UUID()
    let title: String
    let transactionType: TransactionType
    let amount: Double
    let date: Date
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    var displayAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        //        numberFormatter.locale = .current
        numberFormatter.maximumFractionDigits = 2
        
        return numberFormatter.string(from: amount as NSNumber) ?? "N/A"
    }
}
