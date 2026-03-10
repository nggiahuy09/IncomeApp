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

    private init() {
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
            }

            
        }
    }
}
