//
//  IncomeAppApp.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 21/12/25.
//

import SwiftUI

@main
struct IncomeAppApp: App {

    let dataManager = DataManager.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}
