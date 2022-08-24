//
//  ContentView.swift
//  BunqInterviewApp
//
//  Created by Charel Felten on 23/08/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        TabView {
            PaymentView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Payment")
                }
            PaymentHistoryView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("History")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
