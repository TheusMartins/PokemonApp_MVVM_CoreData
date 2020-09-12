//
//  DBPokemon.swift
//  Pokemon app
//
//  Created by Scizor on 10/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import Foundation
import CoreData

@objc(DBPokemon)
public class DBPokemon: NSManagedObject {

}

extension DBPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBPokemon> {
        return NSFetchRequest<DBPokemon>(entityName: "DBPokemon")
    }

    @NSManaged public var front: Data?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var type: [String]?


}
