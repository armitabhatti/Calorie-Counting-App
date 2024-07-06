//
//  CreateGroceryView.swift
//  MyCCApp
//
//  Created by armita on 2024-04-02.
//

import SwiftUI
import CoreData

struct CreateGroceryView: View {
    
    @Environment (\.dismiss) private var dismiss
    @ObservedObject var vm: EditGroceryViewModel
    
    @State private var error: Bool = false
    
    var body: some View {
        
        
        List{
            
            Section("info"){
                HStack{
                    Text("Name: ")
                        .bold()
                    TextField("enter name", text: $vm.grocery.name)
                        .keyboardType(.namePhonePad)
                }
                HStack{
                    Text("Serving Size: ")
                        .bold()
                    TextField("enter serving size", text: $vm.grocery.servingSize)
                        .keyboardType(.namePhonePad)
                }
            }
            
            Section ("macros!"){
                
                HStack{
                    Text("Protein: ")
                        .bold()
                    TextField("protein", value: $vm.grocery.protein, format: .number)
                        .keyboardType(.decimalPad)
                    Text("g")
                }
                
                HStack{
                    Text("Carbs: ")
                        .bold()
                    TextField("carbs", value: $vm.grocery.carbs, format: .number)
                        .keyboardType(.decimalPad)
                    Text("g")
                }
                
                HStack{
                    Text("Fat: ")
                        .bold()
                    TextField("fat", value: $vm.grocery.fat, format: .number)
                        .keyboardType(.decimalPad)
                    Text("g")
                }
                
                
            }
        }
        .navigationTitle(vm.isNew ? "New Grocery" : "Update Grocery")
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button ("Done!"){
                    validate()
                    
                }
            }
            ToolbarItem(placement: .navigationBarLeading){
                Button ("Cancel"){
                    dismiss()
                }
            }
        }
        .alert("Girl, be for real...", isPresented: $error, actions: {}) {
            Text("Your food is not valid!!")
        }
    }
}

extension CreateGroceryView{
    
    private func validate(){
        if (vm.grocery.isValid){
            do {
                try vm.save()
                dismiss()
            }catch{
                print(error)
            }
        }
        else {
            error = true
        }
    }
    
}

