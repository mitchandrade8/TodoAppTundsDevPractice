//
//  CategoriesJSONDecoder.swift
//  TodoAppTundsDevPractice
//
//  Created by Mitch Andrade on 10/19/23.
//

import Foundation

struct CategoryResponse: Codable {
    let title: String
}

struct CategoriesJSONDecoder {
    
    static func decode(from fileName: String) -> [CategoryResponse] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let categories = try? JSONDecoder().decode([CategoryResponse].self, from: data)  else {
            return []
        }

        return categories
    }
}

// MARK: - Notes

/// To handle JSON from an API or local file
