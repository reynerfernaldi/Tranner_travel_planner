//
//  DetailsView.swift
//  Budgeter
//
//  Created by Reyner Fernaldi on 04/05/23.
//

import SwiftUI


struct DetailsView: View {
    
    @State var budget: Int = 0
    @State var souvenirs: Int = 0
    @State var remaining: Int = 0
    @State var total_Transportation: Int = 0
    @State var total_Accomodation: Int = 0
    @State var total_Food: Int = 0
    @State var total_Attraction: Int = 0
    @State var total_Additional: Int = 0
    
    @State var isPresenting = false /// 1.
    
    @EnvironmentObject var myData: MyData
    
    @State var selectedCategory = "Transportation"
    
    let categories: [String]=["Transportation", "Accomodation", "Food", "Attraction Place", "Souvenirs", "Additional"]
    
    let categoriesIcon: [String]=["airplane", "building.fill", "fork.knife", "figure.2.and.child.holdinghands", "gift.fill", "plus"]
    
    var transportation_type = ["Flight", "Train", "MRT", "LRT", "Taxi", "Rent", "Others"]
    
    var food_type = ["Main", "Snacks", "Others"]
    
    struct Attractions: Identifiable {
        var id = UUID()
        var name: String
        var price: Int
    }
    
    struct Accomodation: Identifiable {
        var id = UUID()
        var name: String
        var night: Int
        var price: Int
        var total_price: Int
    }
    
    struct Transportation: Identifiable {
        var id = UUID()
        var type: String
        var price: Int
    }
    
    struct Food: Identifiable {
        var id = UUID()
        var type: String
        var times: Int
        var price: Int
        var total_price: Int
    }
    
    struct Additional: Identifiable {
        var id = UUID()
        var name: String
        var price: Int
    }
    
    @State var attractions:[Attractions]=[]
    @State var accomodations:[Accomodation]=[]
    @State var transportations:[Transportation]=[]
    @State var foods:[Food]=[]
    @State var additionals:[Additional]=[]
    
    
    
    func calculatePrice(smth: Int, price: Int) -> Int {
        let total_price: Int = smth * price
        return total_price
    }
    
    
    var body: some View {
        
        VStack{
            ScrollView{
                VStack (alignment: .leading){
                    Text("Plan your budget!")
                        .font(.title)
                    //                                .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                    Text("Initial Budget")
                        .font(.title3)
                    //                                .frame(maxWidth: .infinity)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    TextField("\(budget)", value: $budget, format: .number)
                        .onChange(of: budget) { newValue in
                            remaining = budget - total_Transportation - total_Accomodation - total_Food - total_Attraction - souvenirs - total_Additional
                        }
                        .keyboardType(.numberPad)
                        .padding(10)
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .fontWeight(.bold)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.blue, lineWidth: 1)
                        )
                    
                    
                    Picker("What is your favorite color?", selection: $selectedCategory) {
                        ForEach(myData.categories, id:\.name) { index in
                            if index.name == "Transportation"{
                                Image(systemName: "airplane")
                            }
                            else if index.name == "Accomodation"{
                                Image(systemName: "building.fill")
                            }
                            else if index.name == "Food"{
                                Image(systemName: "fork.knife")
                            }
                            else if index.name == "Attraction Place"{
                                Image(systemName: "figure.2.and.child.holdinghands")
                            }
                            else if index.name == "Souvenirs"{
                                Image(systemName: "gift.fill")
                            }
                            else if index.name == "Additional"{
                                Image(systemName: "plus")
                            }
                            
                        }
                    }
                    
                    .pickerStyle(.segmented)
                    .padding(.top, 30)
                    
                    
                    if selectedCategory == "Transportation" {
                        Text("Transportation")
                            .font(.title2)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        Group {
                            
                            ForEach(transportations.indices, id: \.self) { index in
                                HStack {
                                    Picker("Please choose a a currency", selection: $transportations[index].type) {
                                        ForEach(transportation_type, id: \.self) {
                                            Text($0)
                                        }
                                    }
                                    
                                    Image(systemName: "poweron").foregroundColor(.secondary)
                                    
                                    
                                    TextField("\(transportations[index].price)", value: $transportations[index].price, formatter: NumberFormatter())
                                        .onChange(of: transportations[index].price) { V in
                                            total_Transportation = 0
                                            for trans in transportations {
                                                total_Transportation += trans.price
                                                
                                            }
                                            remaining = budget - total_Transportation - total_Accomodation - total_Food - total_Attraction - souvenirs - total_Additional
                                        }
                                        .keyboardType(.numberPad)
                                    
                                    Button(action: {
                                        total_Transportation -= transportations[index].price
                                        remaining += transportations[index].price
                                        transportations.remove(at: index)
                                    }) {
                                        Image(systemName: "x.circle")
                                            .foregroundColor(.red)
                                            .padding()
                                    }
                                }
                                .frame(maxWidth:.infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.blue, lineWidth: 1)
                                )
                                .padding(.bottom, 5)
                            }
                            
                            
                            Button {
                                transportations.append(Transportation(type: "Flight", price: 0))
                            } label: {
                                HStack{
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                    Text("Add transportation")
                                }
                                .padding(.top)
                                .frame(maxWidth: .infinity)
                            }
                            
                        }
                    }
                    else if selectedCategory == "Accomodation"{
                        Text("Accomodation")
                            .font(.title2)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        Group {
                            
                            ForEach(accomodations.indices, id: \.self) { index in
                                HStack{
                                    VStack(alignment:.leading){
                                        HStack{
                                            TextField("Hotel Location", text: $accomodations[index].name)
                                            
                                                .frame(maxWidth: .infinity, alignment:.leading )
                                        }
                                        
                                        
                                        HStack {
                                            
                                            
                                            TextField("\(accomodations[index].night)", value: $accomodations[index].night, formatter: NumberFormatter())
                                                .onChange(of: accomodations[index].night) { V in
                                                    accomodations[index].total_price = calculatePrice(smth: accomodations[index].night, price: accomodations[index].price)
                                                    total_Accomodation = 0
                                                    for acc in accomodations {
                                                        total_Accomodation += acc.total_price
                                                        
                                                    }
                                                    remaining = budget - total_Transportation - total_Accomodation - total_Food - total_Attraction - souvenirs - total_Additional
                                                }
                                                .keyboardType(.numberPad)
                                                .frame(width: 20)
                                            
                                            Image(systemName: "multiply")
                                            Text("Rp")
                                            
                                            TextField("\(accomodations[index].price)", value: $accomodations[index].price, formatter: NumberFormatter())
                                                .onChange(of: accomodations[index].price) { V in
                                                    accomodations[index].total_price = calculatePrice(smth: accomodations[index].night, price: accomodations[index].price)
                                                    
                                                    total_Accomodation = 0
                                                    for acc in accomodations {
                                                        total_Accomodation += acc.total_price
                                                        
                                                    }
                                                    remaining = budget - total_Transportation - total_Accomodation - total_Food - total_Attraction - souvenirs - total_Additional
                                                    
                                                }
                                                .keyboardType(.numberPad)
                                                .frame(maxWidth:90)
                                            
                                            Text("Rp \(accomodations[index].total_price)")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            
                                            
                                            
                                            
                                        }
                                        
                                    }
                                    Button(action: {
                                        total_Accomodation -= accomodations[index].total_price
                                        remaining += accomodations[index].total_price
                                        accomodations.remove(at: index)
                                    }) {
                                        Image(systemName: "x.circle")
                                            .resizable()
                                            .frame(width:25, height:25)
                                            .foregroundColor(.red)
                                            
                                        
                                    }
                                }
                                .padding()
                                .frame(maxWidth:.infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.blue, lineWidth: 1)
                                )
                            }
                            
                            Button {
                                accomodations.append(Accomodation(name: "", night: 1, price: 0, total_price: 0))
                            } label: {
                                HStack{
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                    Text("Add accomodation")
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.top)
                            }
                            
                        }
                    }
                    else if selectedCategory == "Food"{
                        Text("Food")
                            .font(.title2)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        Group {
                            
                            ForEach(foods.indices, id: \.self) { index in
                                HStack{
                                    VStack{
                                        Picker("Please choose a food", selection: $foods[index].type) {
                                            ForEach(food_type, id: \.self) {
                                                Text($0)
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment:.leading)
                                        
                                        HStack {
                                            
                                            TextField("\(foods[index].times)", value: $foods[index].times, formatter: NumberFormatter())
                                                .onChange(of: foods[index].times) { V in
                                                    foods[index].total_price = calculatePrice(smth: foods[index].times, price: foods[index].price)
                                                }
                                                .keyboardType(.numberPad)
                                                .frame(width: 20)
                                            
                                            Image(systemName: "multiply")
                                            Text("Rp")
                                            
                                            TextField("\(foods[index].price)", value: $foods[index].price, formatter: NumberFormatter())
                                                .onChange(of: foods[index].price) { V in
                                                    foods[index].total_price = calculatePrice(smth: foods[index].times, price: foods[index].price)
                                                    total_Food = 0
                                                    for food in foods {
                                                        total_Food += food.total_price
                                                        
                                                    }
                                                    remaining = budget - total_Transportation - total_Accomodation - total_Food - total_Attraction - souvenirs - total_Additional
                                                }
                                                .keyboardType(.numberPad)
                                                .frame(maxWidth:100)
                                            
                                        
                                            
                                            Text("Rp \(foods[index].total_price)")
                                                .fontWeight(.bold)
                                                .foregroundColor(.secondary)
                                            
                                        
                                        }
                                    }
                                    Button(action: {
                                        total_Food -= foods[index].price
                                        remaining += foods[index].price
                                        foods.remove(at: index)
                                    }) {
                                        Image(systemName: "x.circle")
                                            .resizable()
                                            .frame(width:25, height:25)
                                            .foregroundColor(.red)
                                            
                                    }
                                }
                                .padding()
                                .frame(maxWidth:.infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.blue, lineWidth: 1)
                                )
                            }
                            
                            Button {
                                foods.append(Food(type: "Main", times: 1, price: 0, total_price: 0))
                            } label: {
                                HStack{
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                    Text("Add food")
                                }
                                .padding(.top)
                                .frame(maxWidth: .infinity)
                            }
                            
                        }
                    }
                    else if selectedCategory == "Attraction Place"{
                        Text("Attraction Place")
                            .font(.title2)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        
                        Group {
                            
                            ForEach(attractions.indices, id: \.self) { index in
                                HStack {
                                    TextField(attractions[index].name, text: $attractions[index].name)
                                        .frame(width:180)
                                        .padding(.leading)
                                    
                                    Image(systemName: "poweron").foregroundColor(.secondary)
                                    
                                    TextField("\(attractions[index].price)", value: $attractions[index].price, formatter: NumberFormatter())
                                        .onChange(of: attractions[index].price) { V in
                                            total_Attraction = 0
                                            for attr in attractions {
                                                total_Attraction += attr.price
                                                
                                            }
                                            remaining = budget - total_Transportation - total_Accomodation - total_Food - total_Attraction - souvenirs - total_Additional
                                        }
                                        .keyboardType(.numberPad)
                                    
                                    Button(action: {
                                        total_Attraction -= attractions[index].price
                                        remaining += attractions[index].price
                                        attractions.remove(at: index)
                                    }) {
                                        Image(systemName: "x.circle")
                                            .foregroundColor(.red)
                                            .padding()
                                    }
                                }
                                .frame(maxWidth:.infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.blue, lineWidth: 1)
                                )
                            }
                            .onDelete(perform: { indexSet in
                                attractions.remove(atOffsets: indexSet)
                            })
                            
                            Button {
                                attractions.append(Attractions(name: "", price: 0))
                            } label: {
                                HStack{
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                    Text("Add attraction")
                                }
                                .padding(.top)
                                .frame(maxWidth: .infinity)
                            }
                            
                        }
                        
                    }
                    else if selectedCategory == "Souvenirs"{
                        Text("Souvenir")
                            .font(.title2)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        TextField("", value: $souvenirs, formatter: NumberFormatter() )
                            .onChange(of: souvenirs) { V in
                                remaining = budget - total_Transportation - total_Accomodation - total_Food - total_Attraction - souvenirs - total_Additional
                            }
                            .padding()
                            .keyboardType(.numberPad)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.blue, lineWidth: 1)
                            )
                        
                        
                    }
                    else if selectedCategory == "Additional"{
                        HStack{
                            Text("Additional budget")
                                .font(.title2)
                            
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                        
                        
                        
                        Text("Additional budgets are including visa, travel insurance, medicine, etc ")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 20)
                        Group {
                            
                            ForEach(additionals.indices, id: \.self) { index in
                                HStack {
                                    TextField(additionals[index].name, text: $additionals[index].name)
                                        .frame(width:180)
                                        .padding(.leading)
                                    
                                    Image(systemName: "poweron").foregroundColor(.secondary)
                                    
                                    TextField("\(additionals[index].price)", value: $additionals[index].price, formatter: NumberFormatter())
                                        .onChange(of: additionals[index].price) { V in
                                            total_Additional = 0
                                            for addt in additionals {
                                                total_Additional += addt.price
                                                
                                            }
                                            remaining = budget - total_Transportation - total_Accomodation - total_Food - total_Attraction - souvenirs - total_Additional
                                        }
                                        .keyboardType(.numberPad)
                                    
                                    Button(action: {
                                        total_Additional -= additionals[index].price
                                        remaining += additionals[index].price
                                        additionals.remove(at: index)
                                    }) {
                                        Image(systemName: "x.circle")
                                            .foregroundColor(.red)
                                            .padding()
                                    }
                                }
                                .frame(maxWidth:.infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.blue, lineWidth: 1)
                                )
                            }
                            
                            Button {
                                additionals.append(Additional(name: "", price: 0))
                            }
                        label: {
                            HStack{
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.green)
                                Text("Add additionals")
                            }
                            .padding(.top)
                            .frame(maxWidth: .infinity)
                            
                        }
                            
                            
                        }
                    }
                    
                    
                    
                }
            }
            Text("Remaining Budget:  \(remaining) ")
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(.gray)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(alignment: .bottom)
                .background(Color(.systemGray6))

            
            
        }
        .onAppear{
            selectedCategory = myData.categories[0].name
        }
        
        .padding()
        .navigationTitle("Details")
        .toolbar {
            
            Button("Next") {
                isPresenting = true
            }
            NavigationLink(destination: testing(
                budget: $budget,
                souvenirs: $souvenirs, remaining: $remaining, attractions: $attractions, accomodations: $accomodations,
                transportations: $transportations
                , foods: $foods, additionals: $additionals, total_Transportation: $total_Transportation, total_Accomodation: $total_Accomodation, total_Food: $total_Food, total_Attraction: $total_Attraction, total_Additional:$total_Additional
            ), isActive: $isPresenting) { EmptyView() }
            
        }
        
    }
}


struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView( ).environmentObject(MyData())
    }
}
