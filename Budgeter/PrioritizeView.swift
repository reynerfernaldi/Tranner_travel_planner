//
//  PrioritizeView.swift
//  Budgeter
//
//  Created by Reyner Fernaldi on 04/05/23.
//

import SwiftUI


struct ItemRow: View {
    
    var categories: Categories
    
    var body: some View {
        HStack{
            Image(systemName: "line.3.horizontal")
                .padding(.trailing,5)
            VStack(alignment: .leading){
                        Text(categories.name).font(.body)
                        Text(categories.desc).font(.caption).foregroundColor(.secondary)
                    }
                    .padding(1)

        }
        
    }
}

struct PrioritizeView: View {
    @EnvironmentObject var myData: MyData
    @State var isPresenting = false /// 1.
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                Text("Set up your prioritization for this")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    .padding(.leading, 22)
                    .multilineTextAlignment(.leading)
                Text("trip!")
                    .font(.title2)
                    .padding(.leading, 22)
                    .fontWeight(.bold)
                Text("You can hold and drag each of the categories to rank them.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.leading, 22)
                    .padding(.top, 5)
                List {
                    Section{
                        ForEach(myData.categories) { category in
                            ItemRow(categories: category)
                        }
                        .onMove(perform: move)
                    }
                }
                             .scrollContentBackground(.hidden)
            }
        }
        .background(Color(.systemGray6))
        .navigationTitle("Prioritization")
        .toolbar {
            
            Button("Next") {
                isPresenting = true
            }
            NavigationLink(destination: DetailsView(), isActive: $isPresenting) { EmptyView() }
            
        }
        
    }
    func move(from source: IndexSet, to destination: Int) {
        myData.categories.move(fromOffsets: source, toOffset: destination)
    }
}

struct PrioritizeView_Previews: PreviewProvider {
    static var previews: some View {
        PrioritizeView().environmentObject(MyData())
    }
}
