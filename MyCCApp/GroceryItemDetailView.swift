//
//  GroceryItemDetailView.swift
//  MyCCApp
//
//  Created by armita on 2024-04-02.
//

import SwiftUI

struct GroceryItemDetailView: View {
    
    let grocery: GroceryItem
    
    var body: some View {
        List{
            Section ("Macros"){
                
                LabeledContent{
                    Text(String(format: "%.1f", grocery.protein) + " g")
                }label: {
                    Text("protein")
                }
                
                LabeledContent{
                    Text(String(format: "%.1f", grocery.carbs) + " g")
                }label: {
                    Text("carbs")
                }
                
                LabeledContent{
                    Text(String(format: "%.1f", grocery.fat) + " g")
                }label: {
                    Text("fat")
                }
                
                LabeledContent{
                    Text(grocery.servingSize)
                }label: {
                    Text("serving size")
                }
            }
        }
            .navigationTitle(grocery.name)
    }
}

//#Preview {
//    NavigationStack{
//        GroceryItemDetailView()
//    }
//}
