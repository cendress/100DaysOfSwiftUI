//
//  AnswerButton.swift
//  BrainGame
//
//  Created by Christopher Endress on 6/11/24.
//

import SwiftUI

struct AnswerButton: View {
    @Binding var isTapped: Bool
    
    var emoji: String
    var text: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            Text(emoji)
                .font(.system(size: 60))
            
            Text(text)
                .font(.headline)
                .foregroundColor(isTapped ? .white : .black)
        }
        .padding()
        .frame(width: 120, height: 120)
        .background(isTapped ? Color.black : Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .onTapGesture {
            action()
        }
    }
}
