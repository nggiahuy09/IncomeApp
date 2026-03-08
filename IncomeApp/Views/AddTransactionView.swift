//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI

struct AddTransactionView: View {

    var transactionToEdit: Transaction?

    @Environment(\.dismiss) private var dismiss

    @State private var amount: Double = 0.0
    @State private var transactionTitle: String = ""
    @State private var transactionDes: String = ""
    @State private var selectedTransactionType: TransactionType = .expense

    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false

    @Binding var transactions: [Transaction]

    @AppStorage("currency") private var currency = Currency.usd

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

                    let newTransaction = Transaction(
                        title: transactionTitle,
                        description: transactionDes,
                        transactionType: selectedTransactionType,
                        amount: amount,
                        date: Date.now
                    )
                    // print(newTransaction)

                    // check the transaction to edit is not null
                    if let transactionToEdit = transactionToEdit {
                        guard let index = transactions.firstIndex(of: transactionToEdit) else {
                            alertTitle = "Something went wrong"
                            alertMessage = "Cannot update this transaction right now."
                            showAlert = true
                            return
                        }

                        transactions[index] = newTransaction
                    } else {
                        transactions.append(newTransaction)
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
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.title
                transactionDes = transactionToEdit.description
                selectedTransactionType = transactionToEdit.transactionType
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
    AddTransactionView(transactions: .constant([]))
}
