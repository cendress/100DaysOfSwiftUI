//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Christopher Endress on 6/6/24.
//

import SwiftUI

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var userScore = 0
  @State private var selectedCountry = 0
  @State private var questionCount = 0
  @State private var showingEndGameAlert = false
  
  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
      ], center: .top, startRadius: 200, endRadius: 700)
      .ignoresSafeArea()
      
      VStack {
        Spacer()
        
        Text("Guess the Flag")
          .font(.largeTitle.weight(.bold))
          .foregroundStyle(.white)
        
        VStack(spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .foregroundStyle(.secondary)
              .font(.subheadline.weight(.heavy))
            
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
          }
          
          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            } label: {
              Image(countries[number])
                .clipShape(Capsule())
                .shadow(radius: 5)
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
        
        Spacer()
        Spacer()
        
        Text("Score: \(userScore)")
          .foregroundStyle(.white)
          .font(.title.bold())
        
        Spacer()
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("That's the flag of \(countries[selectedCountry])")
    }
    .alert("Game Ended", isPresented: $showingEndGameAlert) {
      Button("Restart", action: resetGame)
    } message: {
      Text("Your score is \(userScore)")
    }
  }
  
  func flagTapped(_ number: Int) {
    questionCount += 1
    selectedCountry = number
    
    if number == correctAnswer {
      scoreTitle = "Correct"
      userScore += 1
    } else {
      scoreTitle = "Wrong"
      if userScore >= 1 {
        userScore -= 1
      }
    }
    
    if questionCount >= 8 {
      showingEndGameAlert = true
    } else {
      showingScore = true
    }
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
  
  func resetGame() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    userScore = 0
    questionCount = 0
  }
}

#Preview {
  ContentView()
}
