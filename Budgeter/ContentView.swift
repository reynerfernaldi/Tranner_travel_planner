//
//  ContentView.swift
//  Budgeter
//
//  Created by Reyner Fernaldi on 03/05/23.
//

import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = false
    var body: some View {
        
        ZStack {
            if self.isActive {
                SetUp()
            } else {
                Rectangle()
                    .background(Color.white)
                Image("Tranner")
                    .resizable()
                    .frame(width: .infinity, height: .infinity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
