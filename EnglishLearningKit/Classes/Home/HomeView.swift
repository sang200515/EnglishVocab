//
//  HomeView.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 5/15/24.
//

import SwiftUI
import NaturalLanguage

struct HomeView: View {
    @ObservedObject var state = HomeState()
    @State private var searchText = ""
    @State private var currentText = ""
    @State private var currentIndex: Int = 0
    @State private var onSucess: Bool = false
    @State private var onEdittingSucess: Bool = false
    @State  var onCompleted: Bool = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                resetState()
            }
        }
    }
    @State private var listString: [String] = "Sure, here's the updated code with the comment fixed:".keywords
    @State private var listWrongKeyWord: [String] = []
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack {
            titleView
            contentView
            Spacer()
            if onCompleted {
                SuccessAnimation()
                    .frame(width: 30, height: 30)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            onCompleted = false
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
            currentText = listString[currentIndex]
        }
    }
}

private extension HomeView {
    private func resetState(){
        currentIndex = 0
        currentText = listString[currentIndex]
        searchText = ""
    }
    
    var titleView: some View {
        Text("Text editing")
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .center)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .center)
            .overlay {
                Button(action: {
                    if let clipboardContent = UIPasteboard.general.string, !clipboardContent.isEmpty {
                        listString = clipboardContent
                            .keywords
                        
                        resetState()
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
    
    var contentView: some View {
        VStack {
            MultilineHStack(self.listString) {
                Text($0)
                    .foregroundColor(.primary)
                    .font(.system(size: 35))
                    .bold()
            }
            
            Text("Wrong keyword")
            MultilineHStack(self.listWrongKeyWord) {
                Text($0)
                    .foregroundColor(.primary)
                    .font(.system(size: 35))
                    .bold()
            }
            
        }
    }
    
    var searchTextField: some View {
        TextField(currentText, text: $searchText)
            .autocorrectionDisabled(true)
            .font(.system(size: 50, weight: .bold))
            .padding()
            .foregroundColor(onEdittingSucess ? .blue : .red)
            .font(.body)
            .frame(width: 350, height: 60)
            .textInputAutocapitalization(.never)
            .focused($isFocused)
            .onChange(of: searchText) { newValue in
                print("New value: \(newValue)")
                onSucess = newValue.lowercased() == currentText.lowercased()
                if onSucess {
                    currentIndex += 1
                    guard validateLastArraySuccess() else {
                        onCompleted = true
                        return
                    }
                    currentText = listString[currentIndex]
                    searchText = ""
                }
                
                onEdittingSucess = newValue.lowercased() == currentText.prefix(newValue.count).lowercased()
            }
            .onSubmit {
                currentIndex += 1
                guard validateLastArraySuccess() else {
                    onCompleted = true
                    return
                }
                currentText = listString[currentIndex]
                searchText = ""
                isFocused = true
                
                if currentText.lowercased() != searchText.lowercased() {
                    listWrongKeyWord.append(listString[currentIndex - 1])
                    print("listWrongKeyWord \(listWrongKeyWord)")
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
                onCompleted = false
            }
        }
        .padding()
        .keyboardShortcut(.escape, modifiers: [])
    }
    
    
    private func validateLastArraySuccess() -> Bool {
        print("valiedate \(currentIndex  < listString.count)")
        return  currentIndex < listString.count
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

