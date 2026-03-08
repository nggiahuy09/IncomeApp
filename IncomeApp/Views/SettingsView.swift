//
//  SettingsView.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 8/3/26.
//

import SwiftUI

struct SettingsView: View {

    @AppStorage("orderDescending") var orderDescending = true
    //    @State private var ordering = Ordering.newest
    @AppStorage("currency") var currency = Currency.usd;
    @AppStorage("filterMinumum") var filterMinimum: Double = 0.0

    var filterMinimumFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }

    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Toggle(isOn: $orderDescending, label: {
                        Text("Order \(orderDescending ? "(Earliest)" : "(Latest)")")
                    })
                    //                Picker("Ordering", selection: $ordering, content: {
                    //                    ForEach(Ordering.allCases, id: \.self, content: {
                    //                        ordering in Text(ordering.title)
                    //                    })
                    //                })
                }
                HStack {
                    Picker("Currency", selection: $currency, content: {
                        ForEach(Currency.allCases, id: \.self, content: {
                            currency in Text(currency.title)
                        })
                    })
                }
                HStack {
                    Text("Filter Minimum")
                    TextField("Enter the value", value: $filterMinimum, formatter: filterMinimumFormatter)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        .navigationTitle("Settings")
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
}
