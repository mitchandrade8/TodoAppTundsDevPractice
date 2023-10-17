//
//  ToDoItem.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/16/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompleted: Bool

    init(title: String = "",
         timestamp: Date = .now,
         isCritical: Bool = false,
         isCompleted: Bool = false) {
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isCompleted = isCompleted
    }
}

extension Item {
    
    static var dummy: Item {
        .init(title: "Item 1",
              timestamp: .now,
              isCritical: true)
    }
}
