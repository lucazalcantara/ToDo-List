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
    
    private func updateTodoItem(_ todoItem: TodoItem) {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    private func deleteTodoItem(_ todoItem: TodoItem) {
        context.delete(todoItem)
        
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
            List {
                Section("Pending") {
                    if pendingTodoItems.isEmpty {
                        ContentUnavailableView("No items found.", systemImage: "doc")
                    } else {
                        ForEach(pendingTodoItems) { todoItem in
                            TodoCellView(todoItem: todoItem, onChanged: updateTodoItem)
                        }.onDelete(perform: { indexSet in
                            indexSet.forEach { indexSet in
                                let todoItem = pendingTodoItems[indexSet]
                                deleteTodoItem(todoItem)
                            }
                        })
                    }
                }
                
                Section("Completed") {
                    if completedTodoItems.isEmpty {
                        ContentUnavailableView("No items found.", systemImage: "doc")
                    } else {
                        ForEach(completedTodoItems) { todoItem in
                            TodoCellView(todoItem: todoItem, onChanged: updateTodoItem)
                        }.onDelete(perform: { indexSet in
                            indexSet.forEach { indexSet in
                                let todoItem = completedTodoItems[indexSet]
                                deleteTodoItem(todoItem)
                            }
                        })
                    }
                }
            }.listStyle(.plain)
            
            Spacer()
        }
        .padding()
        .navigationTitle("To-Do List")
    }
}

struct TodoCellView: View {
    
    let todoItem: TodoItem
    let onChanged: (TodoItem) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: todoItem.isCompleted ? "checkmark.square" : "square")
                .onTapGesture {
                    todoItem.isCompleted = !todoItem.isCompleted
                    onChanged(todoItem)
                }
            if todoItem.isCompleted {
                Text(todoItem.title ?? "")
            } else {
                TextField("", text: Binding(get: {
                    todoItem.title ?? ""
                }, set: { newValue in
                    todoItem.title = newValue
                })).onSubmit {
                    onChanged(todoItem)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .environment(\.managedObjectContext, CoreDataProvider.preview.viewContext)
    }
}

