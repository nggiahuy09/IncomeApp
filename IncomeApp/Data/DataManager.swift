//
//  DataManager.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 10/3/26.
//

import Foundation
import CoreData

// DataManager is Singleton
class DataManager {

    let container = NSPersistentContainer(name: "IncomeData")
    static let shared = DataManager()
    static var sharedPreview: DataManager = {
        let manager = DataManager(inMemory: true)
        let transaction = TransactionItem(context: manager.container.viewContext)
        transaction.title = "Test"
        transaction.amount = 10.0
        transaction.type = Int16(TransactionType.expense.rawValue)
        transaction.des = "Test"
        transaction.date = Date()
        transaction.id = UUID()
        return manager
    }()

    private init(inMemory: Bool = false) {
        // support for Previews
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
            }


        }
    }
}
