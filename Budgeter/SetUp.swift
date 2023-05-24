//
//  SetUp.swift
//  Budgeter
//
//  Created by Reyner Fernaldi on 03/05/23.
//

import SwiftUI

struct SetUp: View {
    @EnvironmentObject var myData: MyData
    
    @State var destination: String = ""
    @State var days: Int = 1
    @State var currency: String = ""
    @State var nights: Int = 3
    
    var currencies = ["IDR", "JPY", "KRW", "MYR"]
    
    
    var body: some View {
        NavigationStack{
            
            VStack{
                Text("Where and how long your trip will be?").font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom,40)
                
                Group{
                    Text("Destination")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                    
                    TextField(
                        "Destination",
                        text: $myData.destination
                    )
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 1)
                            
                    )
                    .padding(.bottom, 25)
                }
                
                Group{
                    Text("How many days?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                    TextField(
                        "Destination",
                        value: $myData.days, format:.number
                    )
                    .keyboardType(.numberPad)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 1)
                            
                    )
                    .padding(.bottom, 25)

                }
                
                Group{
                    Text("How many nights?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                    TextField(
                        "Destination",
                        value: $myData.nights, format:.number
                    )
                    .keyboardType(.numberPad)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 1)
                            
                    )
                    .padding(.bottom, 50)

                }

                
                NavigationLink(destination: PrioritizeView()) {
                    Text("Let's manage your budget!")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                

            }
            .padding(40)
        }

    }
}

struct SetUp_Previews: PreviewProvider {
    static var previews: some View {
        SetUp().environmentObject(MyData())
    }
}
