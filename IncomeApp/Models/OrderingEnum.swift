//
//  OrderEnum.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 8/3/26.
//

import Foundation

enum Ordering : CaseIterable {
    case newest, oldest

    var title: String {
        switch self {
            case .newest: return "Newest"
            case .oldest: return "Oldest"
        }
    }
}
