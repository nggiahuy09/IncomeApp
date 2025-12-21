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
}
