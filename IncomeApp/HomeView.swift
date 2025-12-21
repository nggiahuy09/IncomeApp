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
                    VStack {
                        HStack(spacing: 12.0) {
                            Image(systemName: transaction.transactionType == .income ? "arrow.up.forward" : "arrow.down.forward")
                                .font(.system(size: 16.0, weight: .bold))
                                .foregroundStyle(transaction.transactionType == .income ? .green : .red)
                            VStack(alignment: .leading, spacing: 8.0) {
                                HStack {
                                    Text(transaction.title)
                                        .font(.system(size: 16.0, weight: .bold))
                                    Spacer()
                                    Text(transaction.displayAmount)
                                        .font(.system(size: 15.0, weight: .bold))
                                }
                                HStack {
                                    Text("Completed")
                                        .font(.system(size: 14.0))
                                    Spacer()
                                    Text(transaction.displayDate)
                                        .font(.system(size: 14.0))
                                        .padding(.vertical, 4.0)
                                        .padding(.horizontal, 8.0)
                                        .background(Color.lightGradeShade.opacity(0.5))
                                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                                }
                            }
                        }
                    }
                })
            }
        }
    }
}

#Preview {
    HomeView()
}
