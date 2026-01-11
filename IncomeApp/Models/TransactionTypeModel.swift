//
//  TransactionType.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import Foundation

enum TransactionType: String, CaseIterable, Identifiable {
    case income, expense

    var id: Self { self }

    var title: String {
        switch self {
        case .expense:
            return "Expense"
        case .income:
            return "Income"
        }
    }
}
