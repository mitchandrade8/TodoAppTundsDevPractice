//
//  ModifyToDoView.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/17/23.
//

import SwiftUI

struct CreateTodoView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
        
    @State var item = Item()
    @State var selectedCategory: Category?
    
    var body: some View {
        List {
            
            Section("To do title") {
                TextField("Name", text: $item.title)
            }
            
            Section {
                DatePicker("Choose a date",
                           selection: $item.timestamp)
                Toggle("Important?", isOn: $item.isCritical)
            }

            
            Section {
                Button("Create") {
                    dismiss()
                }
            }

        }
        .navigationTitle("Create ToDo")
        .toolbar {
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    dismiss()
                }
                .disabled(item.title.isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateTodoView()
            .modelContainer(for: Item.self)
    }
}
