//
//  MyData.swift
//  Budgeter
//
//  Created by Reyner Fernaldi on 03/05/23.
//

import Foundation
import Combine

struct Categories: Identifiable {
    var id = UUID()
    var name: String
    var desc: String
    var image: String
}

struct Attractions {
    var name: String
    var price: Int
}

struct Accomodation {
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

struct Food {
    var type: String
    var times: Int
    var price: Int
    var total_price: Int
}

struct Additional {
    var name: String
    var price: Int
}

class MyData: ObservableObject {
    @Published var categories :[Categories]=[
        Categories(name: "Transportation", desc: "Flight, MRT, Taxi", image: "airplane"),
        Categories(name: "Accomodation", desc: "Hotels", image: "bulding.fill"),
        Categories(name: "Food", desc: "Main food, snacks", image: "fork.knife"),
        Categories(name: "Attraction Place", desc: "Disneyland, Universal Studios", image: "figure.2.and.child.holdinghands"),
        Categories(name: "Souvenirs", desc: "Keychain, postcards", image: "gift.fill"),
        Categories(name: "Additional", desc: "Visa, medicine", image: "plus"),
    ]
//    @Published var cons_weight: [String]=[]
    @Published var attractions:[Attractions]=[]
    @Published var accomodations:[Accomodation]=[]
    @Published var transportations:[Transportation]=[]
    @Published var foods:[Food]=[]
    @Published var additionals:[Additional]=[]
    @Published var destination:String = ""
    @Published var days:Int = 0
    @Published var nights:Int = 0
    
    
}
