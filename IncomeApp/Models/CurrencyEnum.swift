//
//  CurrencyEnum.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 8/3/26.
//

import Foundation

enum Currency : Int, CaseIterable {
    case usd, vnd, euro

    var title: String {
        switch self {
        case .usd: return "USD"
        case .vnd: return "VND"
        case .euro: return "EUR"
        }
    }

    var locale: Locale {
        switch self {
        case .usd: return Locale(identifier: "en_US")
        case .vnd: return Locale(identifier: "vi_VN")
        case .euro: return Locale(identifier: "en_EU")        }
    }
}
