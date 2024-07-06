//
//  ContentView.swift
//  MyCCApp
//
//  Created by armita on 2024-04-01.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View{
        TabView{
            FridgeView()
                .environment(\.managedObjectContext, GroceriesProvider.shared.viewContext)
                .tabItem { Label("fridge", systemImage: "carrot")
                }
            DailyGroceriesView()
                .environment(\.managedObjectContext, GroceriesProvider.shared.viewContext)
                .tabItem { Label("daily log", systemImage: "sun.and.horizon")
                }
        }
        
    }
}
