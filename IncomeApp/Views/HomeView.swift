//
//  HomeView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI

struct HomeView: View {

    @State private var transactions: [TransactionModel] = [
        TransactionModel(title: "Apple", transactionType: .expense, amount: 5.00, date: Date()),
        TransactionModel(title: "Banana", transactionType: .expense, amount: 10.2, date: Date())
    ]

    fileprivate func BalanceView() -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .fill(Color.primaryLightGreen)
            VStack(alignment: .leading) {
                HStack {
                    Text("BALANCE")
                        .font(.caption)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.top)
                Text("$2.00")
                    .font(.system(size: 42.0, weight: .light))
                    .foregroundStyle(.white)
                Spacer()
                HStack(spacing: 24.0) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15.0, weight: .semibold))
                            .foregroundStyle(.white)
                        Text("$42.12")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15.0, weight: .semibold))
                            .foregroundStyle(.white)
                        Text("$44.12")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                }
                Spacer()
            }
            .padding(.leading)
        }
        .shadow(color: .black.opacity(0.4), radius: 12.0, x: 2.0, y: 4.0)
        .frame(height: 150.0)
        .padding(.horizontal)
    }

    var body: some View {
        VStack {
            BalanceView()
            List {
                ForEach(transactions, content: {transaction in
                    TransactionView(transaction: transaction)
                })
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    HomeView()
}
