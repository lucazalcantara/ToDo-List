//
//  ToDoApp.swift
//  ToDo
//
//  Created by Lucas  Alcantara  on 20/02/25.
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
