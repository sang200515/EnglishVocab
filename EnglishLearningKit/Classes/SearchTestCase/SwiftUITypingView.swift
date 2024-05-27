//
//  SearchTestCaseView.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 5/26/24.
//

import Foundation
import SwiftUI

struct SwiftUITypingView: View {
    @ObservedObject private var state = SwiftUITypingState()
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(Array(state.items.enumerated()), id: \.offset) { index, item in
                    fullView(item: item)
                }
                .padding(.horizontal, 24)
                .onAppear {
                    state.loadItemsFromJSON()
                }
            }
        }
        .background(.black)
    }
    
    var typingView: some View {
        Text("typingView")
    }
    
    func fullView(item: PropertyWrapper) -> some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.keyword)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(hexString: item.color))
        .cornerRadius(20)
    }
}
#Preview {
    SwiftUITypingView()
}
