//
//  DataEntity+CoreDataProperties.swift
//  CHR
//
//  Created by jagannath sahoo on 01/10/26.
//
//

public import Foundation
public import CoreData


public typealias DataEntityCoreDataPropertiesSet = NSSet

extension DataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataEntity> {
        return NSFetchRequest<DataEntity>(entityName: "DataEntity")
    }

    @NSManaged nonisolated public var id_: String?
    @NSManaged nonisolated public var sectionName: String?
    @NSManaged nonisolated public var userName: String?
    @NSManaged nonisolated public var items: NSSet?

}

// MARK: Generated accessors for items
extension DataEntity {

    @objc(addItemsObject:)
    @NSManaged nonisolated public func addToItems(_ value: KeyValueEntity)

    @objc(removeItemsObject:)
    @NSManaged nonisolated public func removeFromItems(_ value: KeyValueEntity)

    @objc(addItems:)
    @NSManaged nonisolated public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged nonisolated public func removeFromItems(_ values: NSSet)

}

extension DataEntity : Identifiable {

}
