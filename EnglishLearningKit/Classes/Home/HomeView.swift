//
//  HomeView.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 5/15/24.
//

import SwiftUI
import NaturalLanguage

struct HomeView: View {
    @ObservedObject private var state = HomeState()
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack {
            titleView
            Spacer()
            contentView
            Spacer()
            if state.onCompleted {
                SuccessAnimation()
                    .frame(width: 30, height: 30)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            state.onCompleted = false
                        }
                    }
            }
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
            state.currentText = state.listString[state.currentIndex]
        }
    }
}

private extension HomeView {
   
    
    var titleView: some View {
        Text("Text editing")
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .center)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay {
                Button(action: {
                    if let clipboardContent = UIPasteboard.general.string, !clipboardContent.isEmpty {
                        state.listString = clipboardContent
                            .keywords
                        
                        state.resetState()
                    }
                    
                }, label: {
                    Text("Paste")
                        .font(.system(size: 30))
                        .bold()
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .keyboardShortcut(.escape, modifiers: /*@START_MENU_TOKEN@*/.command/*@END_MENU_TOKEN@*/)
            }
    }
    
    private func createString(text: String) -> AttributedString {
        guard state.onIndex == state.currentIndex else { return AttributedString(stringLiteral: text) }
        let helloAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 35, weight: .bold),
            .foregroundColor: UIColor.red
        ]
        let helloString = NSAttributedString(string: "Hello, ", attributes: helloAttributes)

        let worldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 35, weight: .bold),
            .foregroundColor: UIColor.blue
        ]
        let worldString = NSAttributedString(string: "World!", attributes: worldAttributes)

        // Combine the segments into a single attributed string
        let uiKitAttributedString = NSMutableAttributedString()
        uiKitAttributedString.append(helloString)
        uiKitAttributedString.append(worldString)

        // Convert the UIKit attributed string to a SwiftUI AttributedString
        let swiftUIAttributedString = AttributedString(uiKitAttributedString)
        return swiftUIAttributedString
    }
    
    var contentView: some View {
        VStack {
            MultilineHStack(state.listString) {
                Text($0)
                    .font(.system(size: 35))
                    .bold()
            }
            
            Text("Wrong keyword")
            MultilineHStack( state.listWrongKeyWord) {
                Text($0)
                    .foregroundColor(Color.primary)
                    .font(.system(size: 35))
                    .bold()
            }
            
        }
    }
    
    var searchTextField: some View {
        TextField(state.currentText, text: $state.searchText)
            .autocorrectionDisabled(true)
            .font(.system(size: 50, weight: .bold))
            .padding()
            .foregroundColor(state.onEdittingSucess ? .blue : .red)
            .font(.body)
            .frame(width: 350, height: 60)
            .textInputAutocapitalization(.never)
            .fixedSize()
            .focused($isFocused)
            .fixedSize(horizontal: false, vertical: true)
            .onChange(of: state.searchText) { newValue in
                state.onSucess = newValue.lowercased() == state.currentText.lowercased()
                if state.onSucess {
                    state.currentIndex += 1
                    guard validateLastArraySuccess() else {
                        state.onCompleted = true
                        return
                    }
                    state.currentText = state.listString[state.currentIndex]
                    state.searchText = ""
                }
                
                state.onEdittingSucess = newValue.lowercased() == state.currentText.prefix(newValue.count).lowercased()
            }
            .onSubmit {
                state.currentIndex += 1
                guard validateLastArraySuccess() else {
                    state.onCompleted = true
                    return
                }
                state.currentText = state.listString[state.currentIndex]
                state.searchText = ""
                isFocused = true
                
                if state.currentText.lowercased() != state.searchText.lowercased() {
                    state.listWrongKeyWord.append(state.listString[state.currentIndex - 1])
                    print("listWrongKeyWord \(state.listWrongKeyWord)")
                }
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
    
    
    private func validateLastArraySuccess() -> Bool {
        print("valiedate \(state.currentIndex  < state.listString.count)")
        return  state.currentIndex < state.listString.count
    }
}


extension HomeView {
    enum Action {
        case doSomeThing
    }
}

#Preview {
    HomeView()
}

