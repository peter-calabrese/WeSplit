//
//  ContentView.swift
//  WeSplit
//
//  Created by Peter Calabrese on 4/23/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 0
  @State private var tipPercentage = 20
  @FocusState private var amountIsFocused: Bool
  let percentages = [15, 18, 20, 25]
  var totalPerPerson: Double{
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount
    return amountPerPerson
  }
  var body: some View {
    NavigationStack{
      Form{
        Section{
          HStack{
            Text("Bill Amount")
            Spacer()
            TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
              .keyboardType(.decimalPad)
              .fixedSize()
              .focused($amountIsFocused)
              
          }
          Picker("Number of people", selection: $numberOfPeople){
            ForEach(2..<100){
              Text("\($0) People")
            }
          }
        }
        Section("How much do you want to tip?"){
          Picker("Tip Percentage", selection: $tipPercentage){
            ForEach(percentages, id:\.self){
              Text("\($0)%")
            }
          }
          .pickerStyle(.segmented)
        }
        
        Section{
          HStack{
            Text("Total Per Person")
            Spacer()
            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
          }
          
        }
      }
      .navigationTitle("Tip Calculator")
      .toolbar{
        if amountIsFocused{
          Button("Done"){
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
