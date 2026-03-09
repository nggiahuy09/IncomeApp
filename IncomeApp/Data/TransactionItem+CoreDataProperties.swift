//
//  TransactionItem+CoreDataProperties.swift
//  IncomeApp
//
//  Created by Nguyễn Gia Huy on 9/3/26.
//
//

public import Foundation
public import CoreData


public typealias TransactionItemCoreDataPropertiesSet = NSSet

extension TransactionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionItem> {
        return NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var des: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var type: Int16

}

extension TransactionItem : Identifiable {

}

extension TransactionItem {
    var wrappedId: UUID { return id ?? UUID() }

    var wrappedTitle: String { return title ?? "" }

    var wrappedDes: String { return des ?? "" }

    var wrappedDate: Date? { return date ?? Date() }

    var wrappedTransactionType: TransactionType {
        return TransactionType(rawValue: Int(type)) ?? .income
    }

    var wrappedAmount: Double { return amount }
}
