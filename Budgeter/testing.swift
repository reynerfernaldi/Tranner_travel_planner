//
//  testing.swift
//  Budgeter
//
//  Created by Reyner Fernaldi on 11/05/23.
//

import SwiftUI

struct testing: View {
    //    @State private var isPresentingShareSheet = false
    
    @EnvironmentObject var myData: MyData
    
    @Binding var budget: Int
    @Binding var souvenirs: Int
    @Binding var remaining: Int
    @Binding var attractions:[DetailsView.Attractions]
    @Binding var accomodations:[DetailsView.Accomodation]
    @Binding var transportations:[DetailsView.Transportation]
    @Binding var foods:[DetailsView.Food]
    @Binding var additionals:[DetailsView.Additional]
    
    @Binding var total_Transportation: Int
    @Binding var total_Accomodation: Int
    @Binding var total_Food: Int
    @Binding var total_Attraction: Int
    @Binding var total_Additional: Int
    
    @State var counter:Int = 1
    var body: some View {
        ZStack{
            Image("Tranner")
                .resizable()
                .frame(width: .infinity, height: .infinity)
                .opacity(0.2)
            ScrollView{
                VStack (alignment: .leading) {
                    
                    Text("Budget Summary")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,1)
                    
                    HStack{
                        Text("Trip to")
                        Text(myData.destination)
                        Text("for \(myData.days)")
                        Text(" days and ")
                        Text("\(myData.nights)")
                        Text(" nights")
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.secondary)
                    .italic()
                    
                    Divider()
                    
                    Text("Initial Budget: Rp \(budget)")
                        .font(.title2)
                        .padding(.top)
                        .fontWeight(.bold)
                    
                    ForEach(myData.categories, id:\.name) { index in
                        if index.name == "Transportation"{
                            Text("Transportation")
                                .font(.title2)
                                .padding(.top)
                                .padding(.bottom,2)
                                .fontWeight(.semibold)
                            ForEach(Array(transportations.enumerated()), id: \.offset) { index, transport in
                                HStack {
                                    Text("\(index+1).")
                                    Text(transport.type)
                                    Spacer()
                                    Text("Rp \(transport.price)")
                                        .fontWeight(.semibold)
                                    
                                }
                            }
                            HStack{
                                Text("Total")
                                Text("Rp \(total_Transportation)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top,3)
                            
                        }
                        else if index.name == "Accomodation"{
                            Text("Accomodation")
                                .font(.title2)
                                .padding(.top)
                                .padding(.bottom,5)
                            ForEach(Array(accomodations.enumerated()), id: \.offset) { index, accom in
                                HStack {
                                    Text("\(index+1).")
                                    Text(accom.name)
                                    Text("\(accom.night)")
                                    Text("\(accom.price)")
                                    Spacer()
                                    Text("Rp \(accom.total_price)")
                                    
                                }
                            }
                            HStack{
                                Text("Total")
                                Text("Rp \(total_Accomodation)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top,3)
                        }
                        else if index.name == "Food"{
                            Text("Food")
                                .font(.title2)
                                .padding(.top)
                                .padding(.bottom,5)
                            ForEach(Array(foods.enumerated()), id: \.offset) { index, food in
                                HStack {
                                    Text("\(index+1).")
                                    Text(food.type)
                                    Text("\(food.times)")
                                    Text("\(food.price)")
                                    Spacer()
                                    Text("Rp  \(food.total_price)")
                                    
                                }
                            }
                            HStack{
                                Text("Total")
                                Text("Rp \(total_Food)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top,3)
                        }
                        else if index.name == "Attraction Place"{
                            Text("Attraction")
                                .font(.title2)
                                .padding(.top)
                                .padding(.bottom,5)
                            ForEach(Array(attractions.enumerated()), id: \.offset) { index, attr in
                                HStack {
                                    Text("\(index+1).")
                                    Text(attr.name)
                                    Spacer()
                                    Text("Rp \(attr.price)")
                                    
                                }
                            }
                            HStack{
                                Text("Total")
                                Text("Rp \(total_Attraction)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top,3)
                        }
                        else if index.name == "Souvenirs"{
                            Text("Souvenir")
                                .font(.title2)
                                .padding(.top)
                                .padding(.bottom,5)
                            
                            HStack{
                                Text("Total")
                                Text("Rp \(souvenirs)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top,3)
                            
                        }
                        else if index.name == "Additional"{
                            Text("Additional")
                                .font(.title2)
                                .padding(.top)
                                .padding(.bottom,5)
                            ForEach(Array(additionals.enumerated()), id: \.offset) { index, add in
                                HStack {
                                    Text("\(index+1).")
                                    Text(add.name)
                                    Spacer()
                                    Text("Rp \(add.price)")
                                    
                                }
                            }
                            HStack{
                                Text("Total")
                                Text("Rp \(total_Additional)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top,3)
                        }
                    }
                    
                    HStack{
                        Text("Remaining Budget").font(.title2)
                        Spacer()
                        Text("Rp \(remaining)")
                    }
                    .padding(.top,20)
                    .font(.title2)
                    .fontWeight(.bold)
                    
                    NavigationLink(destination: SetUp()) {
                        Text("Plan another trip!")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    
                }
                
            }
            .padding()
            .toolbar {
                ShareLink("", item: render())
            }
        }
        
        
        
    }
    
    func render() -> URL {
        // 1: Render Hello World with some modifiers
        let renderer = ImageRenderer(content:
                                        ZStack{
            Image("Tranner")
                .resizable()
                .frame(width: 500, height: 900)
                .opacity(0.2)
            VStack (alignment: .leading) {
                
                Text("Budget Summary")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.bottom,1)
                
                HStack{
                    Text("Trip to")
                    Text(myData.destination)
                    Text("for \(myData.days)")
                    Text(" days and ")
                    Text("\(myData.nights)")
                    Text(" nights")
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.secondary)
                .italic()
                
                Divider()
                
                Text("Initial Budget: Rp \(budget)")
                    .font(.title2)
                    .padding(.top)
                    .fontWeight(.bold)
                
                ForEach(myData.categories, id:\.name) { index in
                    if index.name == "Transportation"{
                        Text("Transportation")
                            .font(.title2)
                            .padding(.top)
                            .padding(.bottom,2)
                            .fontWeight(.semibold)
                        ForEach(Array(transportations.enumerated()), id: \.offset) { index, transport in
                            HStack {
                                Text("\(index+1).")
                                Text(transport.type)
                                Spacer()
                                Text("Rp \(transport.price)")
                                    .fontWeight(.semibold)
                                
                            }
                        }
                        HStack{
                            Text("Total")
                            Text("Rp \(total_Transportation)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top,3)
                        
                    }
                    else if index.name == "Accomodation"{
                        Text("Accomodation")
                            .font(.title2)
                            .padding(.top)
                            .padding(.bottom,5)
                        ForEach(Array(accomodations.enumerated()), id: \.offset) { index, accom in
                            HStack {
                                Text("\(index+1).")
                                Text(accom.name)
                                Text("\(accom.night)")
                                Text("\(accom.price)")
                                Spacer()
                                Text("Rp \(accom.total_price)")
                                
                            }
                        }
                        HStack{
                            Text("Total")
                            Text("Rp \(total_Accomodation)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top,3)
                    }
                    else if index.name == "Food"{
                        Text("Food")
                            .font(.title2)
                            .padding(.top)
                            .padding(.bottom,5)
                        ForEach(Array(foods.enumerated()), id: \.offset) { index, food in
                            HStack {
                                Text("\(index+1).")
                                Text(food.type)
                                Text("\(food.times)")
                                Text("\(food.price)")
                                Spacer()
                                Text("Rp \(food.total_price)")
                                
                            }
                        }
                        HStack{
                            Text("Total")
                            Text("Rp \(total_Food)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top,3)
                    }
                    else if index.name == "Attraction Place"{
                        Text("Attraction")
                            .font(.title2)
                            .padding(.top)
                            .padding(.bottom,5)
                        ForEach(Array(attractions.enumerated()), id: \.offset) { index, attr in
                            HStack {
                                Text("\(index+1).")
                                Text(attr.name)
                                Spacer()
                                Text("Rp \(attr.price)")
                                
                            }
                        }
                        HStack{
                            Text("Total")
                            Text("Rp \(total_Attraction)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top,3)
                    }
                    else if index.name == "Souvenirs"{
                        Text("Souvenir")
                            .font(.title2)
                            .padding(.top)
                            .padding(.bottom,5)
                        
                        HStack{
                            Text("Total")
                            Text("Rp \(souvenirs)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top,3)
                        
                    }
                    else if index.name == "Additional"{
                        Text("Additional")
                            .font(.title2)
                            .padding(.top)
                            .padding(.bottom,5)
                        ForEach(Array(additionals.enumerated()), id: \.offset) { index, add in
                            HStack {
                                Text("\(index+1).")
                                Text(add.name)
                                Spacer()
                                Text("Rp \(add.price)")
                                
                            }
                        }
                        HStack{
                            Text("Total")
                            Text("Rp \(total_Additional)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.top,3)
                    }
                }
                
                HStack{
                    Text("Remaining Budget").font(.title2)
                    Spacer()
                    Text("Rp \(remaining)")
                }
                .padding(.top,20)
                .font(.title2)
                .fontWeight(.bold)
                
            }
            .padding()
        }
                                     
        )
        
        // 2: Save it to our documents directory
        let url = URL.documentsDirectory.appending(path: "Tranner.pdf")
        
        // 3: Start the rendering process
        renderer.render { size, context in
            // 4: Tell SwiftUI our PDF should be the same size as the views we're rendering
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            // 5: Create the CGContext for our PDF pages
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }
            
            // 6: Start a new PDF page
            pdf.beginPDFPage(nil)
            
            // 7: Render the SwiftUI view data onto the page
            context(pdf)
            
            // 8: End the page and close the file
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
    
}



struct testing_Previews: PreviewProvider {
    static var previews: some View {
        testing(budget: .constant(0), souvenirs: .constant(0), remaining: .constant(0), attractions: .constant([
            DetailsView.Attractions(name: "DisneyLand", price: 1000000)
        ]), accomodations: .constant([
            DetailsView.Accomodation(name: "Osaka", night: 3, price: 100000, total_price: 300000)
        ]), transportations: .constant([
            DetailsView.Transportation(type: "Flight", price: 100),
            DetailsView.Transportation(type: "MRT", price: 200)
        ]), foods: .constant([
            DetailsView.Food(type: "Snacks", times: 3, price: 10000, total_price: 30000)
        ]), additionals: .constant([
            DetailsView.Additional(name: "visa", price: 1000000)
        ]), total_Transportation: .constant(10), total_Accomodation: .constant(11), total_Food: .constant(12), total_Attraction: .constant(10), total_Additional: .constant(10)
                
                
        ).environmentObject(MyData())
    }
}
