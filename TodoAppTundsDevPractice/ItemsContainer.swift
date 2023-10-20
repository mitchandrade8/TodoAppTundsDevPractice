//
//  ItemsContainer.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/19/23.
//

import Foundation
import SwiftData

actor ItemsContainer {
    
    @MainActor
    static func create(shouldCreateDefaults: inout Bool) -> ModelContainer {
        let schema = Schema([Item.self])
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        if shouldCreateDefaults {
            shouldCreateDefaults = false
            let categories = CategoriesJSONDecoder.decode(from: "DefaultCategories")
            if !categories.isEmpty {
                categories.forEach { item in
                    let category = Category(title: item.title)
                    container.mainContext.insert(category)
                }
            }
        }

        return container
    }
    
}
