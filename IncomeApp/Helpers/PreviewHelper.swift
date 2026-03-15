//
//  PreviewHelper.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 15/3/26.
//

import Foundation
import SwiftData

@MainActor
class PreviewHelper {

    static let previewContainer: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)

        do {
            let container = try ModelContainer(for: TransactionModel.self, configurations: config)
            let transaction = TransactionModel(id: UUID(), title: "Test", description: "Test", type: .expense, amount: 10.00, date: Date())
            container.mainContext.insert(transaction)

            return container
        } catch {
            fatalError("Can not create configured model container")
        }
    }()
}
