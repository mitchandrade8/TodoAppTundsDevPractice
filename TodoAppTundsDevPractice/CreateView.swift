//
//  CreateView.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/16/23.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            TextField("Name", text: .constant(""))
            DatePicker("Choose a date",
                       selection: .constant(.now))
            Toggle("Important?", isOn: .constant(false))
            Button("Create") {
                dismiss()
            }
        }
        .navigationTitle("Create ToDo")
    }
}

#Preview {
    CreateView()
}
