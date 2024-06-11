//
//  ContentView.swift
//  BrainGame
//
//  Created by Christopher Endress on 6/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedChoice: String? = nil
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var round = 1
    @State private var gameOver = false
    @State private var usedMoves: Set<Int> = []
    
    let moves = ["👊", "✋", "✌️"]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Round: \(round)")
                        .padding()
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("Score: \(score)")
                        .padding()
                        .font(.headline)
                }
                
                Spacer()
                
                Text(moves[appChoice])
                    .font(.system(size: 140))
                
                Spacer()
                
                Text(shouldWin ? "You need to win" : "You need to lose")
                    .font(.title2)
                    .padding()
                
                Spacer()
                
                HStack {
                    AnswerButton(isTapped: .constant(selectedChoice == "👊"), emoji: "👊", text: "Rock") {
                        selectedChoice = "👊"
                    }
                    AnswerButton(isTapped: .constant(selectedChoice == "✋"), emoji: "✋", text: "Paper") {
                        selectedChoice = "✋"
                    }
                    AnswerButton(isTapped: .constant(selectedChoice == "✌️"), emoji: "✌️", text: "Scissors") {
                        selectedChoice = "✌️"
                    }
                }
                .padding()
                
                Button("Submit") {
                    submitAnswer()
                }
                .padding()
                .font(.title)
                .foregroundColor(.white)
                .background(selectedChoice != nil ? Color.indigo : Color.gray)
                .clipShape(Capsule())
                .disabled(selectedChoice == nil)
                
                Spacer()
            }
            .navigationTitle("BrainGame")
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart") { resetGame() }
        } message: {
            Text("Your final score is \(score)/10")
        }
    }
    
    func submitAnswer() {
        guard let selectedChoice = selectedChoice else { return }
        
        let correctChoice: String
        
        if shouldWin {
            correctChoice = winAgainst(appChoice)
        } else {
            correctChoice = loseAgainst(appChoice)
        }
        
        if selectedChoice == correctChoice {
            score += 1
        } else {
            score -= 1
        }
        
        nextRound()
    }
    
    func winAgainst(_ choice: Int) -> String {
        switch choice {
        case 0:
            return moves[1]
        case 1:
            return moves[2]
        case 2:
            return moves[0]
        default:
            return ""
        }
    }
    
    func loseAgainst(_ choice: Int) -> String {
        switch choice {
        case 0:
            return moves[2]
        case 1:
            return moves[0]
        case 2:
            return moves[1]
        default:
            return ""
        }
    }
    
    func nextRound() {
        if round == 10 {
            gameOver = true
        } else {
            round += 1
            selectedChoice = nil
            shouldWin = Bool.random()
            
            repeat {
                appChoice = Int.random(in: 0...2)
            } while usedMoves.contains(appChoice)
            
            usedMoves.insert(appChoice)
            
            if usedMoves.count == moves.count {
                usedMoves.removeAll()
            }
        }
    }
    
    func resetGame() {
        score = 0
        round = 1
        gameOver = false
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        selectedChoice = nil
        usedMoves = [appChoice]
    }
}

#Preview {
    ContentView()
}
