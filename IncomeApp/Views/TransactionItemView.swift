//
//  TransactionItemView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI
import SwiftData

struct TransactionItemView: View {
    //    let transaction: TransactionItem
    let transaction: TransactionModel
    @AppStorage("currency") var currency = Currency.usd
    
    var body: some View {
        VStack {
            HStack(spacing: 12.0) {
                Image(systemName: transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward")
                    .font(.system(size: 16.0, weight: .bold))
                    .foregroundStyle(transaction.type == .income ? .green : .red)
                VStack(alignment: .leading, spacing: 8.0) {
                    HStack {
                        Text(transaction.title)
                            .font(.system(size: 16.0, weight: .bold))
                        Spacer()
                        Text(transaction.amount.formatted())
                            .font(.system(size: 15.0, weight: .bold))
                    }
                    HStack {
                        Text(transaction.des.isEmpty == true ? "(No description)" : transaction.des)
                            .font(.system(size: 14.0))
                        Spacer()
                        Text(transaction.date.formatted())
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
