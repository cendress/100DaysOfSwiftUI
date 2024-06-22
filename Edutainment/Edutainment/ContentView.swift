//
//  ContentView.swift
//  Edutainment
//
//  Created by Christopher Endress on 6/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTableNumber = 1
    @State private var questionAmount = 10
    @State private var userAnswer = ""
    @State private var questionNumber = 1
    @State private var correctAnswer = 0
    @State private var score = 0
    @State private var currentQuestion = ""
    @State private var alertTitleMessage = ""
    @State private var isShowingEndGameAlert = false
    @State private var isShowingInGameAlert = false
    
    let numberOfQuestions = [5, 10, 15]
    
    var body: some View {
        NavigationStack {
                Form {
                    Section(header: Text("What times table do you want to practice?")
                        .font(.headline)
                        .foregroundColor(.blue)) {
                            Stepper("\(multiplicationTableNumber)", value: $multiplicationTableNumber, in: 1...12, step: 1)
                                .onChange(of: multiplicationTableNumber) {
                                    resetGame()
                                }
                                .padding()
                        }
                    
                    Section(header: Text("How many questions would you like to be asked?")
                        .font(.headline)
                        .foregroundColor(.blue)) {
                            Picker("Number of questions", selection: $questionAmount) {
                                ForEach(numberOfQuestions, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding()
                        }
                    
                    Section(header: Text("Question \(questionNumber)")
                        .font(.headline)
                        .foregroundColor(.blue)) {
                            Text(currentQuestion)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                        }
                    
                    TextField("Enter an answer", text: $userAnswer)
                        .keyboardType(.numberPad)
                        .font(.title)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Submit") {
                        submitAnswer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .alert("\(alertTitleMessage)", isPresented: $isShowingInGameAlert) {
                        Button("Continue") { }
                    }
                }
            .navigationTitle("Edutainment")
            .onAppear {
                generateQuestion()
            }
            .toolbar {
                Text("Score: \(score)")
            }
            .alert("Game Ended", isPresented: $isShowingEndGameAlert) {
                Button("OK") {
                    resetGame()
                }
            } message: {
                Text("Your final score: \(score)")
            }
        }
    }
    
    func generateQuestion() {
        let number = Int.random(in: 1...12)
        correctAnswer = multiplicationTableNumber * number
        currentQuestion = "What is \(multiplicationTableNumber) x \(number)?"
    }
    
    func checkAnswer() -> Bool {
        guard let userAnswerInt = Int(userAnswer) else {
            return false
        }
        
        return userAnswerInt == correctAnswer
    }
    
    func submitAnswer() {
        if isShowingEndGameAlert == true {
            isShowingInGameAlert = false
        } else {
            isShowingInGameAlert = true
        }
        
        if checkAnswer() {
            score += 1
            alertTitleMessage = "Correct!"
        } else {
            alertTitleMessage = "Wrong!"
        }
        
        if questionNumber < questionAmount {
            questionNumber += 1
            generateQuestion()
        } else {
            isShowingEndGameAlert = true
        }
        
        userAnswer = ""
    }
    
    func resetGame() {
        questionNumber = 1
        score = 0
        generateQuestion()
    }
}

#Preview {
    ContentView()
}
