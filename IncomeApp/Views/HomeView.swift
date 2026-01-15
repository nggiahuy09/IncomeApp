//
//  HomeView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI

struct HomeView: View {

    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", description: "", transactionType: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Banana", description: "", transactionType: .expense, amount: 10.2, date: Date())
    ]

    @State private var selectedTransaction: Transaction?

    private var expenses: Double {
        transactions
            .filter { $0.transactionType == .expense }  // $0: current transaction
            .reduce(0.0) { total, transaction in
                total + transaction.amount
            }
    }


    private var incomes: Double {
        transactions
            .filter { $0.transactionType == .income }   // $0: current transaction
            .reduce(0.0) { total, transaction in
                total + transaction.amount
            }
    }

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

    fileprivate func BalanceView(expenses: Double, incomes: Double) -> some View {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency

        let _expenses = numberFormatter.string(from: expenses as NSNumber) ?? "0.00"
        let _incomes = numberFormatter.string(from: incomes as NSNumber) ?? "0.00"
        let _balances = numberFormatter.string(from: (incomes - expenses) as NSNumber) ?? "0.00"

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
                Text(_balances)
                    .font(.system(size: 42.0, weight: .light))
                    .foregroundStyle(.white)
                Spacer()
                HStack(spacing: 24.0) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15.0, weight: .semibold))
                            .foregroundStyle(.white)
                        Text(_expenses)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15.0, weight: .semibold))
                            .foregroundStyle(.white)
                        Text(_incomes)
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
                    BalanceView(expenses: expenses, incomes: incomes)
                    List {
                        ForEach(transactions, content: {transaction in
                            TransactionItemView(transaction: transaction)
                                .onTapGesture {
                                    selectedTransaction = transaction
                                }
                        })
                    }
                    .scrollContentBackground(.hidden)
                    .navigationDestination(item: $selectedTransaction, destination: {
                        transactionToEdit in AddTransactionView(transactionToEdit: transactionToEdit, transactions: $transactions)
                    })
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
