//
//  GroceryItemRowView.swift
//  MyCCApp
//
//  Created by armita on 2024-04-02.
//

import SwiftUI

struct GroceryItemRowView: View {
    
    @ObservedObject var grocery: GroceryItem
    
    
    var body: some View {
        
        
        VStack (alignment: .leading, spacing: 6) {
            
            
            Text(grocery.name)
                .font(.system(size: 24, design: .rounded).bold())
            
            
            HStack{
                Text(String(format: "%.1f", grocery.protein))
                Text("g of protein     ").foregroundColor(.gray)
                
                Spacer()
                
                Text(grocery.formattedCals)
                Text("calories").foregroundColor(.gray)
            }
            
            
        }
    }
}




