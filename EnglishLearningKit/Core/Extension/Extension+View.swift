//
//  Extension+View.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 5/17/24.
//

import Foundation
import SwiftUI

public struct MultilineHStack: View {
    struct SizePreferenceKey: PreferenceKey {
        typealias Value = [CGSize]
        static var defaultValue: Value = []
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value.append(contentsOf: nextValue())
        }
    }
    private var index: Int
    private let items: [Any] // Convert AnyView to Any
    @State private var sizes: [CGSize] = []
    
    public init<Data: RandomAccessCollection, Content: View>(
        index: Int = 0,
        _ data: Data,
        @ViewBuilder content: (Data.Element) -> Content
    ) {
        self.items = data.map { content($0) as Any }
        self.index = index
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                ForEach(0..<self.items.count, id: \.self) { index in
                    if let view = self.items[index] as? Text {
                        view.background(self.backgroundView())
                            .offset(self.getOffset(at: index, geometry: geometry))
                            .foregroundColor(index <= self.index ? .blue : .primary)
                    }
                }
            }
        }.onPreferenceChange(SizePreferenceKey.self) {
            self.sizes = $0
        }
    }
    
    private func getOffset(at index: Int, geometry: GeometryProxy) -> CGSize {
        guard index < sizes.endIndex else { return .zero }
        let frame = sizes[index]
        var (x, y, maxHeight) = sizes[..<index].reduce((CGFloat.zero, CGFloat.zero, CGFloat.zero)) {
            var (x, y, maxHeight) = $0
            x += $1.width
            if x > geometry.size.width {
                x = $1.width
                y += maxHeight
                maxHeight = 0
            }
            maxHeight = max(maxHeight, $1.height)
            return (x, y, maxHeight)
        }
        if x + frame.width > geometry.size.width {
            x = 0
            y += maxHeight
        }
        return .init(width: x, height: y)
    }
    
    private func backgroundView() -> some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(
                    key: SizePreferenceKey.self,
                    value: [geometry.frame(in: CoordinateSpace.global).size]
                )
        }
    }
}

struct SuccessAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green.opacity(0.2))
                .frame(width: 40, height: 40)
            
            Image(systemName: "checkmark")
                .font(.title)
                .foregroundColor(.green)
                .scaleEffect(isAnimating ? 1.5 : 1)
                .opacity(isAnimating ? 0 : 1)
                .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: isAnimating)
        }
        .onAppear {
            isAnimating.toggle()
        }
    }
}
struct FailureAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red.opacity(0.2))
                .frame(width: 40, height: 40)
            
            Image(systemName: "xmark")
                .font(.title)
                .foregroundColor(.red)
                .scaleEffect(isAnimating ? 1.5 : 1)
                .opacity(isAnimating ? 0 : 1)
                .animation(Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: isAnimating)
        }
        .onAppear {
            isAnimating.toggle()
        }
    }
}
struct SuccessAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SuccessAnimation()
    }
}
