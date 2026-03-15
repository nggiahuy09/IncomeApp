//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI
import SwiftData

struct AddTransactionView: View {

    //    var transactionToEdit: TransactionItem?
    var transactionToEdit: TransactionModel?

    @Environment(\.dismiss) private var dismiss
    //    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.modelContext) private var modelContext

    @State private var amount: Double = 0.0
    @State private var transactionTitle: String = ""
    @State private var transactionDes: String = ""
    @State private var selectedTransactionType: TransactionType = .expense

    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false

    @AppStorage("currency") var currency = Currency.usd

    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }

    var body: some View {
        VStack(spacing: 24.0) {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 32.0, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Divider()
            HStack {
                Text("Choose Type")
                Spacer()
                Picker("Choose Type", selection: $selectedTransactionType, content: {
                    ForEach(TransactionType.allCases, content: { type in
                        Text(type.title)
                            .tag(type)
                    })
                })
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 16.0))
                .textFieldStyle(.roundedBorder)
            TextField("Description", text: $transactionDes)
                .font(.system(size: 16.0))
                .textFieldStyle(.roundedBorder)
            Button(
                action: {
                    // ensure the transaction title after trimming not empty
                    guard transactionTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count >= 1 else {
                        alertTitle = "Invalid title"
                        alertMessage = "The transaction title must be not empty!"
                        showAlert = true
                        return
                    }

                    // ensure the transaction amount must be larger than 0.0
                    guard amount > 0.0 else {
                        alertTitle = "Invalid amount"
                        alertMessage = "The transaction amount must be no equals 0.0!"
                        showAlert = true
                        return

                    }

                    // check the transaction to edit is not null
                    if let transactionToEdit = transactionToEdit {
                        //                        transactionToEdit.title = transactionTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                        //                        transactionToEdit.des = transactionDes.trimmingCharacters(in: .whitespacesAndNewlines)
                        //                        transactionToEdit.type = Int16(selectedTransactionType.rawValue)
                        //                        transactionToEdit.amount = amount

                        //                        do {
                        //                            try viewContext.save()
                        //                        } catch {
                        //                            alertTitle = "Something went wrong"
                        //                            alertMessage = "Cannot update this transaction right now."
                        //                            showAlert = true
                        //                            return
                        //                        }

                        transactionToEdit.title = transactionTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                        transactionToEdit.des = transactionDes.trimmingCharacters(in: .whitespacesAndNewlines)
                        transactionToEdit.type = selectedTransactionType
                        transactionToEdit.amount = amount
                    } else {
                        // coreData code

                        /*
                         let transaction = TransactionItem(context: viewContext)
                         transaction.id = UUID()
                         transaction.title = transactionTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                         transaction.des = transactionDes.trimmingCharacters(in: .whitespacesAndNewlines)
                         transaction.type = Int16(selectedTransactionType.rawValue)
                         transaction.amount = amount
                         transaction.date = Date()

                         do {
                         try viewContext.save()
                         } catch {
                         alertTitle = "Something went wrong"
                         alertMessage = "Cannot create this transaction right now."
                         showAlert = true
                         return
                         }

                         transactions.append(newTransaction)
                         */

                        // swiftData code
                        let transaction = TransactionModel(
                            id: UUID(),
                            title: transactionTitle.trimmingCharacters(in: .whitespacesAndNewlines),
                            description: transactionDes.trimmingCharacters(in: .whitespacesAndNewlines),
                            type: selectedTransactionType,
                            amount: amount,
                            date: Date()
                        )
                        modelContext.insert(transaction)

                        do {
                            try modelContext.save()
                        } catch {
                            print("Failed to add new transaction.")
                        }
                    }

                    dismiss()
                },
                label: {
                    Text(transactionToEdit == nil ? "Create" : "Update")
                        .font(.system(size: 16.0, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(height: 40.0)
                        .frame(maxWidth: .infinity)
                        .background(.primaryLightGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))

                })
            .padding(.top, 48.0)
            Spacer()
        }
        .onAppear(perform: {
            // check if the transaction to edit is not null
            if let transactionToEdit = transactionToEdit {
                //                transactionTitle = transactionToEdit.wrappedTitle
                //                transactionDes = transactionToEdit.wrappedDes
                //                selectedTransactionType = transactionToEdit.wrappedTransactionType
                //                amount = transactionToEdit.wrappedAmount

                //                do {
                //                    try viewContext.save()
                //                } catch {
                //                    alertTitle = "Something went wrong"
                //                    alertMessage = "Cannot update this transaction right now."
                //                    showAlert = true
                //                    return
                //                }

                transactionTitle = transactionToEdit.title
                transactionDes = transactionToEdit.des
                selectedTransactionType = transactionToEdit.type
                amount = transactionToEdit.amount
            }
        })
        .padding(.horizontal)
        .padding(.top, 32.0)
        .alert(alertTitle, isPresented: $showAlert, actions: {
            Button(action: {

            }, label: {
                Text("OK")
            })
        }, message: {
            Text(alertMessage)
        })
    }
}

#Preview {
    AddTransactionView()
}
