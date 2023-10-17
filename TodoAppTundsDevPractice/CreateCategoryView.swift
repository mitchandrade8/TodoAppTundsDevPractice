//
//  CreateCategoryView.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/17/23.
//

import SwiftUI
import SwiftData

@Model
class Category {
    
    @Attribute(.unique)
    var title: String
    
    var items: [Item]?
    
    init(title: String = " ") {
        self.title = title
    }
}

struct CreateCategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title: String = ""
    @Query private var categories: [Category]
    
    var body: some View {
        List {
            Section("Cateogry Title") {
                TextField("Enter title here",
                text: $title)
                Button("Add Category") {
                    modelContext.insert(Category(title: title))
                }
                .disabled(title.isEmpty)
            }
            
            Section("Categories") {
                ForEach(categories) { category in
                    Text(category.title)
                }
            }
        }
        .navigationTitle("Add New Category")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    CreateCategoryView()
}
