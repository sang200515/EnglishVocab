//
//  TypingModifiers.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 6/12/24.
//


import SwiftUI
import NaturalLanguage


struct TypingModifiersView: View {
    @ObservedObject private var state = ModifierState()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            listView
            Spacer()
            contentView
            searchTextField
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(ignoresSafeAreaEdges: .top)
        .preferredColorScheme(.dark)
        .onAppear {
            state.currentText = state.displayedItem.keyword
            state.items.removeFirst()
        }
    }
}

private extension TypingModifiersView {
    var titleView: some View {
        Text("Text editing")
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .center)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var contentView: some View {
        VStack {
            Text(state.displayedItem.keyword)
                .font(.system(size: 50))
                .bold()
            Text(state.displayedItem.ios)
            Text(state.displayedItem.fullText)
            Text(state.displayedItem.description)
           
        } .font(.system(size: 30))
    }
    
    var searchTextField: some View {
        TextField(state.displayedItem.keyword, text: $state.searchText)
            .autocorrectionDisabled(true)
            .font(.system(size: 50, weight: .bold))
            .padding()
            .foregroundColor(state.onEdittingSucess ? .blue : .red)
            .font(.body)
            .frame(width: 650, height: 60)
            .textInputAutocapitalization(.never)
            .fixedSize()
            .focused($isFocused)
            .fixedSize(horizontal: false, vertical: true)
            .onChange(of: state.searchText) { newValue in
                state.onSucess = newValue.lowercased() == String(state.displayedItem.keyword.lowercased().dropFirst(1).dropLast(2))
                if state.onSucess {
                    state.removeRandomItem()
                    state.searchText = ""
                }
                
                state.onEdittingSucess = newValue.lowercased() == String(state.displayedItem.keyword.lowercased().dropFirst(1).dropLast(2)).prefix(newValue.count).lowercased()
            }
            .onSubmit {
                state.currentText = state.displayedItem.keyword
                state.searchText = ""
                isFocused = true
            }
        
    }
    
    
    var popupView: some View {
        VStack(spacing: 20) {
            Text("This is a popup")
                .font(.title)
                .bold()
            
            Text("You're success")
            
            Button("Close") {
                state.onCompleted = false
            }
        }
        .padding()
        .keyboardShortcut(.escape, modifiers: [])
    }
}

extension TypingModifiersView {
    var listView: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(Array(state.itemsDisplayed.enumerated()), id: \.offset) { index, item in
                    if index == 0 {
                        Text("got:\(state.itemsDisplayed.count - 1) - have: \(state.items.count)")
                            .font(.system(size: 30))
                    } else {
                        fullView1(item: item)
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .background(.secondary)
    }
    
    func fullView1(item: Detail) -> some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.keyword)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(hexString: item.color))
        .cornerRadius(20)
        .colorScheme(.dark)
    }
}
extension TypingModifiersView {
    enum Action {
        case doSomeThing
    }
}

#Preview {
    TypingModifiersView()
}

