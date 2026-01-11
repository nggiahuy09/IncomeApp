//
//  HomeView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI

struct HomeView: View {

    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", transactionType: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Banana", transactionType: .expense, amount: 10.2, date: Date())
    ]

    fileprivate func FloatingButton() -> some View {
        return VStack {
            Spacer()
            NavigationLink(destination: {
                AddTransactionView(transactions: $transactions)
            }, label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 64.0, height: 64.0)
                    .foregroundStyle(.white)
            })
            .background(.primaryLightGreen)
            .clipShape(.circle)
            .padding(.bottom, 8.0)
        }
    }

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
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List {
                        ForEach(transactions, content: {transaction in
                            TransactionView(transaction: transaction)
                        })
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingButton()
            }
            .navigationTitle("Income App")
            //            .toolbar {
            //                ToolbarItem(placement: .topBarTrailing, content: {
            //                    Button(action: {}, label: {
            //                        Image(systemName: "gearshape.fill")
            //                            .foregroundStyle(.gray)
            //                    })
            //                })
            //            }
        }
    }
}

#Preview {
    HomeView()
}
