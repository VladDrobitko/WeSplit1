//
//  ContentView.swift
//  WeSplit
//
//  Created by Владислав Дробитько on 25/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tippercentages = [10, 20, 25, 0]
    
    var totalPerPeerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = (checkAmount + tipValue) / peopleCount
        
        return grandTotal
        
    }
    var totalCheck: Double {
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
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("How much do you tip?")
                            .font(.system(.subheadline))
                            .foregroundStyle(Color.secondary)
                        Picker("Percentage", selection: $tipPercentage) {
                            ForEach(tippercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    VStack(alignment: .leading, spacing: 5) {
                        Text("The total amount for the check is:")
                            .font(.system(.subheadline))
                            .foregroundStyle(Color.secondary)
                        Section {
                            Text(totalCheck, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Amount per person is:")
                        .font(.system(.subheadline))
                        .foregroundStyle(Color.secondary)
                    Section {
                        Text(totalPerPeerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
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
