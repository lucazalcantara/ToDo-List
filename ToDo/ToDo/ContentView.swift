//
//  ContentView.swift
//  ToDo
//
//  Created by Lucas  Alcantara  on 20/02/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var todoItems: FetchedResults<TodoItem>
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
    
    private var pendingTodoItems: [TodoItem] {
        todoItems.filter { !$0.isCompleted }
    }
    
    private var completedTodoItems: [TodoItem] {
        todoItems.filter { $0.isCompleted }
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
            List {
                Section("Pending") {
                    ForEach(pendingTodoItems) { todoItem in
                        Text(todoItem.title ?? "")
                    }
                }
                
                Section("Completed") {
                    ForEach(completedTodoItems) { todoItem in
                        Text(todoItem.title ?? "")
                    }
                }
            }.listStyle(.plain)
            
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

