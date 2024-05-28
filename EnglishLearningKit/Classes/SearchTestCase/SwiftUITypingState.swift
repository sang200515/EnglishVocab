//
//  SwiftUITypingState.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 5/26/24.
//

import Foundation

final class SwiftUITypingState: ObservableObject {
    @Published var items: [PropertyWrapper] = []
    
    init() {
        loadItemsFromJSON()
    }
    
    func loadItemsFromJSON() {
        if let url = Bundle.main.url(forResource: "propertywrappers", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let propertyWrappers = try JSONDecoder().decode(PropertyWrapperInfo.self, from: data)
                self.items = propertyWrappers.propertyWrappers
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("File not found")
        }
    }
}

struct PropertyWrapperInfo: Decodable {
    let propertyWrappers: [PropertyWrapper]
}

// MARK: - PropertyWrapper
struct PropertyWrapper: Decodable {
    let color: String
    let description: String
    let fullText: String
    let keyword: String
    let parent: String
}
