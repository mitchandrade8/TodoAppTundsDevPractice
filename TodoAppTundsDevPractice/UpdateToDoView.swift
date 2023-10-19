//
//  UpdateToDoView.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/17/23.
//

import SwiftUI
import SwiftData

class OriginalToDo {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    
    init(item: Item) {
        self.title = item.title
        self.timestamp = item.timestamp
        self.isCritical = item.isCritical
    }
}

struct UpdateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Query private var categories: [Category]
    
    @State var selectedCategory: Category?

    @Bindable var item: Item

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
                Button("Update") {
                    dismiss()
                }
            }
        }
        .navigationTitle("Update ToDo")
        .onAppear(perform: {
            selectedCategory = item.category
        })
    }
}

#Preview {
    UpdateToDoView(item: Item.dummy)
        .modelContainer(for: Item.self)

}
