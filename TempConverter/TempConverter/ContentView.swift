//
//  ContentView.swift
//  TempConverter
//
//  Created by Christopher Endress on 6/5/24.
//

import SwiftUI

struct ContentView: View {
  @State private var inputAmount: Double = 60
  @State private var inputTemperatureUnit = "Fahrenheit"
  @State private var outputTemperatureUnit = "Fahrenheit"
  @FocusState private var inputValueIsFocused: Bool
  
  private let tempUnits = ["Fahrenheit", "Celsius", "Kelvin"]
  
  private var outputAmount: Double {
    let inputTemp = inputAmount
    var tempInCelsius: Double
    
    switch inputTemperatureUnit {
    case "Fahrenheit":
      tempInCelsius = (inputTemp - 32) * 5 / 9
    case "Kelvin":
      tempInCelsius = inputTemp - 273.15
    default:
      tempInCelsius = inputTemp
    }
    
    switch outputTemperatureUnit {
    case "Fahrenheit":
      return tempInCelsius * 9 / 5 + 32
    case "Kelvin":
      return tempInCelsius + 273.15
    default:
      return tempInCelsius
    }
  }
  
  var body: some View {
    NavigationStack {
      Form {
        
        Section {
          TextField("Enter an inital value to convert", value: $inputAmount, format: .number)
            .keyboardType(.decimalPad)
            .focused($inputValueIsFocused)
        } header: {
          Text("Input value")
        }
        
        Section {
          Picker("Select an input unit", selection: $inputTemperatureUnit) {
            ForEach(tempUnits, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
        } header: {
          Text("Convert from:")
        }
        
        Section {
          Picker("Select an output unit", selection: $outputTemperatureUnit) {
            ForEach(tempUnits, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
        } header: {
          Text("To:")
        }
        
        Section {
          Text(String(outputAmount))
        } header: {
          Text("Output value")
        }
      }
      .navigationTitle("TempConverter")
      .toolbar {
        if inputValueIsFocused {
          Button("Done") {
            inputValueIsFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
