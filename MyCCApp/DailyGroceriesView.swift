//
//  DailyGroceriesView.swift
//  MyCCApp
//
//  Created by armita on 2024-04-14.
//

import SwiftUI
import CoreData

struct DailyGroceriesView: View {
    
    @State private var isShowingLog = false
    @State private var showingResetAlert = false
    
    @FetchRequest(fetchRequest: GroceryItem.all()) private var groceries
    @Environment(\.managedObjectContext) private var moc

    
    
    
    var body: some View {
        
        NavigationStack{
            
            VStack(spacing: 20){
                Text("Total Calories: \(totalCals, specifier: "%.1f")")
                    .font(.largeTitle)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Protein: \(totalP, specifier: "%.1f") g")
                    Text("Carbs: \(totalC, specifier: "%.1f") g")
                    Text("Fat: \(totalF, specifier: "%.1f") g")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.black.opacity(0.1)) // Light background for the section
                .cornerRadius(12)
                
                
                Button("log food"){
                    isShowingLog.toggle()
                }
                .foregroundColor(.white)
                .sheet(isPresented: $isShowingLog) {
                    NavigationStack{
                        LogFoodView()
                            .environment(\.managedObjectContext, GroceriesProvider.shared.viewContext)
                        
                    }
                }
                .padding()
                .background(Color.mint)
                .font(.title2)
                .cornerRadius(20)
                
                
                
                Spacer()
                
                List(groceries){ grocery in
                    if (grocery.isSelected > 0){
                        HStack {
                            Text(String(format: "%.1f", grocery.isSelected))
                            Text(grocery.name)
                                .font(.headline)
                            Spacer()
                            Text(String(format: "%.1f", grocery.calories() * grocery.isSelected) + " calories")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .padding(.horizontal)
            .navigationTitle("Daily Food Log")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset Log") {
                        showingResetAlert.toggle() // Show the alert when the button is tapped
                    }
                    .foregroundColor(.red)
                }
            }
            .alert("Are you sure?", isPresented: $showingResetAlert) {
                Button("Confirm", role: .destructive) {
                    resetLog()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will reset your log of the day.")
            }
        }
    }
    
}

            
        

extension DailyGroceriesView {
    private var totalCals: Float {
        groceries.reduce(0) { sum, grocery in
            sum + (grocery.isSelected * grocery.calories())
        }
    }
    
    private var totalP: Float {
        groceries.reduce(0){ sum, grocery in
            sum + (grocery.isSelected * grocery.protein)
        }
    }
    
    private var totalC: Float {
        groceries.reduce(0){ sum, grocery in
            sum + (grocery.isSelected * grocery.carbs)
        }
    }
    
    private var totalF: Float {
        groceries.reduce(0){ sum, grocery in
            sum + (grocery.isSelected * grocery.fat)
        }
    }


    
    func resetLog(){
        for grocery in groceries {
            grocery.isSelected = 0
        }
        do{
            try moc.save()
        }catch{
            print("error")
        }
    }
}

       

