//
//  ToDo_List_AppApp.swift
//  ToDo-List App
//
//  Created by Lucas  Alcantara  on 19/02/25.
//

import SwiftUI

@main
struct ToDo_List_AppApp: App {
    
    let provider = CoreDataProvider()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environment(\.managedObjectContext, provider.viewContext)
            }
        }
    }
}
