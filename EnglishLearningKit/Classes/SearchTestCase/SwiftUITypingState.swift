//
//  SwiftUITypingState.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 5/26/24.
//

import Foundation

final class SwiftUITypingState: ObservableObject {
    @Published private(set) var items: [Detail] = []
    
    init() {
        loadPropertyWrapperFromJSON()
        loadModifiersFromJSON()
    }
    
    private func loadModifiersFromJSON() {
        if let url = Bundle.main.url(forResource: "modifiers", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let modifiers = try JSONDecoder().decode(ModifierInfo.self, from: data)
                self.items = modifiers.modifiers
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("File not found")
        }
    }
    
    private func loadPropertyWrapperFromJSON() {
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
    let propertyWrappers: [Detail]
}

struct ModifierInfo: Decodable {
    let modifiers: [Detail]
}

// MARK: - PropertyWrapper
struct Detail: Decodable {
    let color: String
    let description: String
    let fullText: String
    let keyword: String
    let parent: String
    let ios: String
}

