//
//  Person+CoreDataProperties.swift
//  CHR
//
//  Created by jagannath sahoo on 01/10/26.
//
//

public import Foundation
public import CoreData


public typealias PersonCoreDataPropertiesSet = NSSet

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged nonisolated public var id_: String?
    @NSManaged nonisolated public var last_model_update: Date?
    @NSManaged nonisolated public var last_sms_date: String?
    @NSManaged nonisolated public var last_update_sms: String?
    @NSManaged nonisolated public var name: String?
    @NSManaged nonisolated public var profile_img: String?
    @NSManaged nonisolated public var unseen_smses: Int64
    @NSManaged nonisolated public var user_id: String?
    @NSManaged nonisolated public var is_person_viewed: Bool
    @NSManaged nonisolated public var allchats: NSSet?

}

// MARK: Generated accessors for allchats
extension Person {

    @objc(addAllchatsObject:)
    @NSManaged nonisolated public func addToAllchats(_ value: Chats)

    @objc(removeAllchatsObject:)
    @NSManaged nonisolated public func removeFromAllchats(_ value: Chats)

    @objc(addAllchats:)
    @NSManaged nonisolated public func addToAllchats(_ values: NSSet)

    @objc(removeAllchats:)
    @NSManaged nonisolated public func removeFromAllchats(_ values: NSSet)

}

extension Person : Identifiable {

}
