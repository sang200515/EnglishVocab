//
//  ContentView.swift
//  EnglishLearningKit
//
//  Created by Em bé cute on 5/14/24.
//

import SwiftUI
import Model

struct ContentView: View {
    var body: some View {
        VStack {
            HomeView()
                .preferredColorScheme(.dark)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
enum Config {
    static var baseUrl: String {
#if Preview
        return "Preview"
#elseif Model
        return "Model"
#elseif Core
        return "Core"
#elseif Dev
        return "dev"
#elseif Production
        return "Production"
#else
        return "none"
#endif
    }
}
