//
//  CoreDataManager.swift
//  Pokemon app
//
//  Created by Matheus Martins on 10/09/20.
//  Copyright © 2020 Matheus Martins. All rights reserved.
//

import CoreData

final class CoreDataManager {
    //MARK: - Static properties
    static let shared = CoreDataManager()
    
    //MARK: - Private Init
    private init() { }
    
    //MARK: - Public properties
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pokemon_app")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Public methods

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
