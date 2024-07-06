//
//  LogFoodRow.swift
//  MyCCApp
//
//  Created by armita on 2024-04-14.
//

import SwiftUI

struct LogFoodRow: View {
    
    let quantities: [Float ] = Array(stride(from: 0.0, through: 10, by: 0.25))
    
    
    @ObservedObject var grocery: GroceryItem
    
    
    var body: some View {
        
        
        HStack{
            
            VStack(alignment: .leading, spacing: 3) {
                Text(grocery.name)
                Text(grocery.formattedCals + " cals")
            }
            
            Spacer()
            
            Text(grocery.servingSize)
            
            Picker("Quantity", selection: $grocery.isSelected) {
                ForEach(quantities, id: \.self) { quantity in
                    Text("\(quantity, specifier: "%g")")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50, alignment: .trailing)
        }
    }
}
        

       
    

    




