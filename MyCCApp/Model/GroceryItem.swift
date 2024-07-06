//
//  GroceryItem.swift
//  MyCCApp
//
//  Created by armita on 2024-04-01.
//

import Foundation
import CoreData

final class GroceryItem: NSManagedObject, Identifiable {
    
    @NSManaged var isSelected: Float
    @NSManaged var carbs: Float
    @NSManaged var fat: Float
    @NSManaged var name: String
    @NSManaged var protein: Float
    @NSManaged var servingSize: String
    
}

extension GroceryItem {
    
    private static var groceriesFetchRequest: NSFetchRequest<GroceryItem> {
        NSFetchRequest(entityName: "GroceryItem")
    }
    
    static func all() -> NSFetchRequest<GroceryItem>{
        let request: NSFetchRequest<GroceryItem> = groceriesFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \GroceryItem.name, ascending: true)
        ]
        return request
    }
    
    
}

extension GroceryItem{
    static func empty (context: NSManagedObjectContext = GroceriesProvider.shared.viewContext) -> GroceryItem {
        return GroceryItem(context: context)
    }
}

extension GroceryItem{
    func calories() -> Float {
        return 4*(self.protein + self.carbs) + 9*self.fat
    }
    
    var formattedCals: String {
        return String (format: "%.1f", self.calories())
    }
    
    var isValid: Bool {
        if (name.isEmpty){
            return false
        }
        
        if (protein == 0 && carbs == 0 && fat == 0){
            return false
        }
        
        return true
    }
    
    
    
}

