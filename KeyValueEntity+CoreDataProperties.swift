//
//  KeyValueEntity+CoreDataProperties.swift
//  CHR
//
//  Created by jagannath sahoo on 01/10/26.
//
//

public import Foundation
public import CoreData


public typealias KeyValueEntityCoreDataPropertiesSet = NSSet

extension KeyValueEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KeyValueEntity> {
        return NSFetchRequest<KeyValueEntity>(entityName: "KeyValueEntity")
    }

    @NSManaged nonisolated public var key: String?
    @NSManaged nonisolated public var value: String?
    @NSManaged nonisolated public var address: DataEntity?

}

extension KeyValueEntity : Identifiable {

}
