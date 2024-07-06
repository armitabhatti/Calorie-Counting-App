//
//  LogFoodView.swift
//  MyCCApp
//
//  Created by armita on 2024-04-14.
//

import SwiftUI
import CoreData

struct LogFoodView: View{
    
    var provider = GroceriesProvider.shared
    
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(fetchRequest: GroceryItem.all()) private var groceries
    @Environment (\.dismiss) private var dismiss
    
    var body: some View{
        
        List{
            ForEach(groceries) { grocery in
                LogFoodRow(grocery: grocery)
                
                
                
            }
        }
        .navigationTitle("logging foods..")
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button ("done!"){
                    dismiss()
                    
                    
                    do {
                        if moc.hasChanges{
                            try moc.save()
                        }
                    } catch {
                        print(error)
                    }
                    
                }
            }
            ToolbarItem(placement: .navigationBarLeading){
                Button ("cancel"){
                    dismiss()
                }
            }
        }
    }
}


