//
//  Chats+CoreDataProperties.swift
//  CHR
//
//  Created by jagannath sahoo on 17/10/26.
//
//

public import Foundation
public import CoreData


public typealias ChatsCoreDataPropertiesSet = NSSet

extension Chats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chats> {
        return NSFetchRequest<Chats>(entityName: "Chats")
    }

    @NSManaged nonisolated public var dipatcher_status: String?
    @NSManaged nonisolated public var id_: UUID?
    @NSManaged nonisolated public var last_model_update: Date?
    @NSManaged nonisolated public var message_direction: Int16
    @NSManaged nonisolated public var text: String?
    @NSManaged nonisolated public var time_stamp: String?
    @NSManaged nonisolated public var oneperson: Person?

}

extension Chats : Identifiable {

}
