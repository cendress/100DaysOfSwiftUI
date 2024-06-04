//
//  ContentView.swift
//  WeSplit
//
//  Created by Christopher Endress on 6/2/24.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 20
  @FocusState private var amountIsFocused: Bool
  
//  let tipPercentages = [10, 15, 20, 25, 0]
  
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)
    
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount
    
    return amountPerPerson
  }
  
  var totalCheckAmount: Double {
    let tipSelection = Double(tipPercentage)
    
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    
    return grandTotal
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
          
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2..<100) {
              Text("\($0) people")
            }
          }
          .pickerStyle(.navigationLink)
        }
        
        Section {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0..<101, id: \.self) {
              Text("\($0)%")
            }
          }
          .pickerStyle(.navigationLink)
        } header: {
          Text("Tip Percentage")
        }
        
        Section {
          Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        } header: {
          Text("Total check amount")
        }
        
        Section {
          Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        } header: {
          Text("Amount per person")
        }
      }
      .navigationTitle("WeSplit")
      .toolbar {
        if amountIsFocused {
          Button("Done") {
            amountIsFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
