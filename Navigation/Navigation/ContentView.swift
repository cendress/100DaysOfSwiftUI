//
//  ContentView.swift
//  Navigation
//
//  Created by Christopher Endress on 6/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var name = "SwiftUI"
    var body: some View {
        NavigationStack {
            Text("Hello")
                .navigationTitle($name)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
