//
//  TransactionItemView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI

struct TransactionItemView: View {
    let transaction: TransactionItem
    @AppStorage("currency") var currency = Currency.usd

    var body: some View {
        VStack {
            HStack(spacing: 12.0) {
                Image(systemName: transaction.wrappedTransactionType == .income ? "arrow.up.forward" : "arrow.down.forward")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(transaction.wrappedTransactionType == .income ? .green : .red)
                VStack(alignment: .leading, spacing: 8.0) {
                    HStack {
                        Text(transaction.wrappedTitle)
                            .font(.system(size: 16.0, weight: .bold))
                            .foregroundStyle(.black)
                        Spacer()
                        Text(transaction.wrappedAmount.formatted())
                            .font(.system(size: 15.0, weight: .bold))
                            .foregroundStyle(.black)
                    }
                    HStack {
                        Text(transaction.wrappedDes.isEmpty == true ? "(No description)" : transaction.description)
                            .font(.system(size: 14.0))
                            .foregroundStyle(.black)
                        Spacer()
                        Text(transaction.wrappedDate?.formatted() ?? "")
                            .font(.system(size: 14.0))
                            .padding(.vertical, 4.0)
                            .padding(.horizontal, 8.0)
                            .background(Color.lightGradeShade.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 8.0))
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}
