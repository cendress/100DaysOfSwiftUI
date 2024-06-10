//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Christopher Endress on 6/9/24.
//

import SwiftUI

struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundStyle(.blue)
    }
}

extension View {
    func fontStyle() -> some View {
        modifier(LargeBlueFont())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct WaterMark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func waterMarked(with text: String) -> some View {
        modifier(WaterMark(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .fontStyle()
        }
    }
}

#Preview {
    ContentView()
}
