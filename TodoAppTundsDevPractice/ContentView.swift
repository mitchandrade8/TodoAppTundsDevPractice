//
//  ContentView.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/16/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var searchQuery = ""
    @State private var showCreateCategory = false
    @State private var showCreateToDo = false
    @State private var toDoToEdit: Item?
    
    
    // Computed Property
    var filteredItems: [Item] {
        
        if searchQuery.isEmpty {
            return items
        }
        
        // Filter items on name/title
        let filteredItems = items.compactMap { item in
            
            let titleContainsQuery = item.title.range(of: searchQuery,
                                                       options: .caseInsensitive) != nil
            
            // Now filtering for the category name/title
            let categoryTitleContainsQuery = item.category?.title.range(of: searchQuery,
                                                                        options: .caseInsensitive) != nil
            
            return (titleContainsQuery || categoryTitleContainsQuery) ? item : nil
        }
        
        return filteredItems
        
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredItems) { item in
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            if item.isCritical {
                                Image(systemName: "exclamationmark.3")
                                    .symbolVariant(.fill)
                                    .foregroundColor(.red)
                                    .font(.largeTitle)
                                    .bold()
                            }
                            
                            Text(item.title)
                                .font(.largeTitle)
                                .bold()
                            
                            Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                .font(.callout)
                            
                            if let category = item.category {
                                Text(category.title)
                                    .foregroundStyle(Color.blue)
                                    .bold()
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                            }
                            
                        }
                        
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                item.isCompleted.toggle()
                            }
                        } label: {
                            
                            Image(systemName: "checkmark")
                                .symbolVariant(.circle.fill)
                                .foregroundStyle(item.isCompleted ? .green : .gray)
                                .font(.largeTitle)
                        }
                        .buttonStyle(.plain)
                    }
                    .swipeActions {
                        
                        Button(role: .destructive) {
                            
                            withAnimation {
                                modelContext.delete(item)
                            }
                            
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                        
                        Button {
                            toDoToEdit = item
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.orange)
                        
                    }
                }
            }
            .navigationTitle("My To Do List")
            .searchable(text: $searchQuery, 
                        prompt: "Search for a to do or a category")
            .overlay {
                if filteredItems.isEmpty {
                    ContentUnavailableView.search
                }
                
            }
            .sheet(item: $toDoToEdit,
                   onDismiss: {
                toDoToEdit = nil
            },
                   content: { editItem in
                NavigationStack {
                    UpdateToDoView(item: editItem)
                        .interactiveDismissDisabled()
                }
            })
            .sheet(isPresented: $showCreateCategory,
                   content: {
                NavigationStack {
                    CreateCategoryView()
                }
            })
            .sheet(isPresented: $showCreateToDo,
                   content: {
                NavigationStack {
                    CreateTodoView()
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("New Category") {
                        showCreateCategory.toggle()
                    }
                }
            }
            .safeAreaInset(edge: .bottom,
                           alignment: .leading) {
                Button(action: {
                    showCreateToDo.toggle()
                }, label: {
                    Label("New ToDo", systemImage: "plus")
                        .bold()
                        .font(.title2)
                        .padding(8)
                        .background(.gray.opacity(0.1),
                                    in: Capsule())
                        .padding(.leading)
                        .symbolVariant(.circle.fill)
                    
                })
                
            }
        }
    }
    
    private func delete(item: Item) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
