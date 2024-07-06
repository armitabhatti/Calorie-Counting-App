//
//  NoGroceriesView.swift
//  MyCCApp
//
//  Created by armita on 2024-04-08.
//

import SwiftUI

struct NoGroceriesView: View {
    var body: some View {
        VStack{
            Text("👀No Groceries Here!")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
            Text("Your firdge seems a little empty, add some groceries!!")
                .multilineTextAlignment(.center)

        }
    }
}

#Preview {
    NoGroceriesView()
}
