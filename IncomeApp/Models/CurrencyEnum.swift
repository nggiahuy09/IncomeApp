//
//  CurrencyEnum.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 8/3/26.
//

import Foundation

enum Currency : CaseIterable {
    case usd, vnd, euro

    var title: String {
        switch self {
            case .usd: return "USD"
            case .vnd: return "VND"
            case .euro: return "EUR"
        }
    }
}
