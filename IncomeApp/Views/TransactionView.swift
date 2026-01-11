//
//  TransactionView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI

struct TransactionView: View {
    let transaction: Transaction

    var body: some View {
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
        .listRowSeparator(.hidden)
    }
}

#Preview {
    TransactionView(transaction: Transaction(title: "Test", transactionType: .expense, amount: 10.00, date: Date()))
}
