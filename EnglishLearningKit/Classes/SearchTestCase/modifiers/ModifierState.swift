//
//  ModifierState.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 6/12/24.
//

import Foundation
import SwiftUI

final class ModifierState: ObservableObject {
    @Published private(set) var newState =  SwiftUITypingState()
    @Published  var items: [Detail] = []
    @Published private(set) var itemsDisplayed: [Detail] = []
    @Published var displayedItem: Detail = Detail(color: "", description: "", fullText: "", keyword: "", parent: "", ios: "")
    @Published var searchText = ""
    @Published var currentText = ""
    @Published var currentIndex: Int = 0
    @Published var onSucess: Bool = false
    @Published var onEdittingSucess: Bool = false
    @Published var listWrongKeyWord: [String] = []
    @Published var onIndex: Int = 0
    
    init() {
        loadPropertyWrapperFromJSON()
        loadModifiersFromJSON()
        removeRandomItem()
    }
    func removeRandomItem() {
            guard !items.isEmpty else { return }
            items.shuffle()
            itemsDisplayed.append(displayedItem)
            displayedItem = items.removeFirst()
        }
    
    @Published var onCompleted: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.resetState()
            }
        }
    }
    
    func resetState(){
        currentIndex = 0
        searchText = ""
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
