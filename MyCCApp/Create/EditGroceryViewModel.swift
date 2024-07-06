//
//  EditGroceryViewModel.swift
//  MyCCApp
//
//  Created by armita on 2024-04-03.
//
import Foundation
import CoreData

final class EditGroceryViewModel: ObservableObject {
    
    @Published var grocery: GroceryItem
    let isNew: Bool
    private let provider: GroceriesProvider
    private let context: NSManagedObjectContext
    
    init(provider: GroceriesProvider, grocery: GroceryItem? = nil) {
        
        self.provider = provider
        self.context = provider.newContext
        
        if let grocery,
           let existingGroceryCopy = provider.exists(grocery, in: context){
            self.grocery = existingGroceryCopy
            self.isNew = false
        }else{
            self.grocery = GroceryItem(context: self.context)
            self.isNew = true
        }
    
    }
    
    func save() throws {
        try provider.persist(in: context)
    }
    
}
