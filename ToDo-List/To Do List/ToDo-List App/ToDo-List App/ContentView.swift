//
//  ContentView.swift
//  ToDo-List App
//
//  Created by Lucas  Alcantara  on 19/02/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var context
    @State private var title: String = ""
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace
    }
    
    private func saveTodoItem() {
        let todoItem = TodoItem(context: context)
        todoItem.title = title
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    if isFormValid {
                        saveTodoItem()
                        title = ""
                    }
                }
            Spacer()
        }
        .padding()
        .navigationTitle("To-Do List")
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}
