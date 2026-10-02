//
//  Chats+CoreDataProperties.swift
//  CHR
//
//  Created by jagannath sahoo on 01/10/26.
//
//

public import Foundation
public import CoreData


public typealias ChatsCoreDataPropertiesSet = NSSet

extension Chats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chats> {
        return NSFetchRequest<Chats>(entityName: "Chats")
    }

    @NSManaged nonisolated public var id_: String?
    @NSManaged nonisolated public var text: String?
    @NSManaged nonisolated public var oneperson: Person?

}

extension Chats : Identifiable {

}
