//
//  GroceriesProvider.swift
//  MyCCApp
//
//  Created by armita on 2024-04-02.
//

import Foundation
import CoreData
import SwiftUI

final class GroceriesProvider {
    
    static let shared = GroceriesProvider()
    
    private let persistentContaier: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext{
        persistentContaier.viewContext
    }
    
    var newContext: NSManagedObjectContext {
        persistentContaier.newBackgroundContext()
    }
    
    private init(){
        
        persistentContaier = NSPersistentContainer(name: "CCDataModel")
        persistentContaier.viewContext.automaticallyMergesChangesFromParent = true
        persistentContaier.loadPersistentStores {_, error in
            if let error{
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
    
    func exists(_ grocery: GroceryItem,
                 in context: NSManagedObjectContext) -> GroceryItem? {
        try? context.existingObject(with: grocery.objectID) as? GroceryItem
    }
    
    func delete (_ grocery: GroceryItem, in context: NSManagedObjectContext) throws {
        if let existingGrocery = exists(grocery, in: context){
            context.delete(existingGrocery)
        }
        Task(priority: .background){
            try await context.perform(){
                try context.save()
            }
        }
    }
    
    func persist(in context: NSManagedObjectContext) throws {
        if context.hasChanges{
            try context.save()
        }
    }
    
}
