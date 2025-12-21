//
//  HomeView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI

struct HomeView: View {

    @State private var transactions: [TransactionModel] = [
        TransactionModel(title: "Apple", transactionType: .expense, amount: 5.00, date: Date())
    ]

    var body: some View {
        VStack {
            List {
                ForEach(transactions, content: {transaction in
                    Text(transaction.title)
                })
            }
        }
    }
}

#Preview {
    HomeView()
}
