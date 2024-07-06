//
//  ContentView.swift
//  MyCCApp
//
//  Created by armita on 2024-04-01.
//

import SwiftUI

struct FridgeView: View {
    
    @FetchRequest(fetchRequest: GroceryItem.all()) private var groceries
    
    @State private var groceryToEdit: GroceryItem?
    
    var provider = GroceriesProvider.shared
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                if groceries.isEmpty{
                    NoGroceriesView()
                }else {
                    List {
                        ForEach(groceries) {grocery in
                            
                            ZStack (alignment: .leading){
                                NavigationLink(destination: GroceryItemDetailView(grocery: grocery)){
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                GroceryItemRowView(grocery: grocery)
                                    .swipeActions(allowsFullSwipe: true){
                                        Button (role: .destructive){
                                            do{
                                                try provider.delete(grocery, in: provider.newContext)
                                            } catch {
                                                print (error)
                                            }
                                        }label: {
                                            Label("delete", systemImage: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button {
                                            groceryToEdit = grocery
                                        }label:{
                                            Label("edit", systemImage: "pencil")
                                        }
                                        .tint(.purple)
                                    }
                            }
                        }
                    }
                }
            }
            
            
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Button {
                        groceryToEdit = .empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .sheet(item: $groceryToEdit, onDismiss: {
                groceryToEdit = nil
            }, content: {grocery in
                NavigationStack{
                    CreateGroceryView(vm: .init(provider: provider,
                                                grocery: grocery))
                }
            })
            .navigationTitle("My Foods!")
            
        }
    }
    
}
    
    private extension FridgeView {
        
    }

