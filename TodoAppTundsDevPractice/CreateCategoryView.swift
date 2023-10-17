//
//  CreateCategoryView.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/17/23.
//

import SwiftUI

struct Category {
    
    var title: String
    
    init(title: String = " ") {
        self.title = title
    }
}

struct CreateCategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    
    var body: some View {
        List {
            Section("Cateogry Title") {
                TextField("Enter title here",
                text: $title)
                Button("Add Category") {
                    
                }
                .disabled(title.isEmpty)
            }
        }
        .navigationTitle("Add New Category")
    }
}

#Preview {
    CreateCategoryView()
}
