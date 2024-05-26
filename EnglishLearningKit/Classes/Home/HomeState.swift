//
//  HomeState.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 5/15/24.
//

import Foundation
import SwiftUI

final class HomeState: ObservableObject {
    @Published var searchText = ""
    @Published var currentText = ""
    @Published var currentIndex: Int = 0
    @Published var onSucess: Bool = false
    @Published var onEdittingSucess: Bool = false
    @Published var listString: [String] = "Sure, here's the updated code with the comment fixed:".keywords
    @Published var listWrongKeyWord: [String] = []
    @Published var onIndex: Int = 0
    @Published var onCompleted: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.resetState()
            }
        }
    }

     func resetState(){
       currentIndex = 0
       currentText = listString[currentIndex]
       searchText = ""
    }
}
