//
//  BudgeterApp.swift
//  Budgeter
//
//  Created by Reyner Fernaldi on 03/05/23.
//

import SwiftUI

@main
struct BudgeterApp: App {
    let myData = MyData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(myData)
        }
    }
}
