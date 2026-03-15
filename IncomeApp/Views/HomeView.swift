//
//  HomeView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

// SwiftData flow
/*
 1. Model
 2. Model Container (Model Context)
 3. Create - Read - Update - Delete

 */

// CoreData flow
/*
 1. Object Graph Management
 2. Persistence Store Coordinator
 3. Persistence -> SQLite
 */
/*
 1. Persistence Container -> Entity
 2. DataManager -> Managed Object Context
 3. Create
 4. Read -> FetchRequest
 5. Update
 6. Delete
 7. Im Memory Persistence Store (Previews)
 */

import SwiftUI
import SwiftData

struct HomeView: View {
    @AppStorage("orderDescending") var orderDescending = false
    @AppStorage("currency") var currency = Currency.usd
    @AppStorage("filterMinumum") var filterMinimum: Double = 0.0

    //    @FetchRequest(sortDescriptors: []) var transactions: FetchedResults<TransactionItem>
    //    @Environment(\.managedObjectContext) private var viewContext

    @Query var transactions: [TransactionModel]
    @Environment(\.modelContext) private var modelContext

    private var displayTransactions: [TransactionModel] {
        //        // sorting by date
        //        let sortedTransactions = orderDescending ? transactions.sorted(by: { $0.wrappedDate > $1.wrappedDate}) : transactions.sorted(
        //            by: {$0.wrappedDate < $1.wrappedDate
        //            })
        //        // filtering by minimum
        //        let filteredTransactions = sortedTransactions.filter({$0.wrappedAmount > filterMinimum})

        let sortedTransactions = orderDescending ? transactions.sorted(by: {$0.date > $1.date}) : transactions.sorted(by: {$0.date < $1.date})
        let filteredTransactions = sortedTransactions.filter({$0.amount > filterMinimum})
        return filteredTransactions
    }

    @State private var showSettingsView: Bool = false
    //    @State private var selectedTransaction: TransactionItem?
    @State private var selectedTransaction: TransactionModel?

    private var expenses: Double {
        transactions
            .filter { $0.type == .expense }  // $0: current transaction
            .reduce(0.0) { total, transaction in
                total + transaction.amount
            }
    }

    private var incomes: Double {
        transactions
            .filter { $0.type == .income }   // $0: current transaction
            .reduce(0.0) { total, transaction in
                total + transaction.amount
            }
    }

    fileprivate func FloatingButton() -> some View {
        return VStack {
            Spacer()
            NavigationLink(destination: {
                AddTransactionView()
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
        numberFormatter.locale = currency.locale

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

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let transactionToDelete = transactions[index]
            //            viewContext.delete(transactionToDelete)
            modelContext.delete(transactionToDelete)
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to delete transaction.")
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView(expenses: expenses, incomes: incomes)
                    List {
                        ForEach(displayTransactions, content: {transaction in
                            Button(action: {
                                selectedTransaction = transaction
                            }, label: {
                                TransactionItemView(transaction: transaction)
                                    .foregroundStyle(.black)
                            })
                        })
                        .onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingButton()
            }
            .navigationTitle("Income App")
            .navigationDestination(item: $selectedTransaction, destination: { transactionToEdit in
                AddTransactionView(transactionToEdit: transactionToEdit)
            })
            .navigationDestination(isPresented: $showSettingsView, destination: {
                SettingsView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: { showSettingsView = true },
                           label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.gray)
                    })
                })
            }
        }
    }
}

#Preview {
    //    let dataManager = DataManager.sharedPreview
    //    return HomeView().environment(\.managedObjectContext, dataManager.container.viewContext)

    let previewContainer = PreviewHelper.previewContainer
    return HomeView().modelContainer(previewContainer)
}
