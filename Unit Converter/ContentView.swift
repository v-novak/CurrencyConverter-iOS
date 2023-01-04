//
//  ContentView.swift
//  Unit Converter
//

import SwiftUI

struct ContentView: View {
    @State private var value = 1.0
    @FocusState private var valueIsFocused: Bool
    @State private var sourceUnits = "m" // m
    @State private var targetUnits = "ft" // ft
    
    let units = [
        "mm": 0.001,
        "cm": 0.01,
        "m": 1.0,
        "km": 1000.0,
        "ft": 0.3048,
        "in": 0.0254,
        "mi": 1609.34,
        "nmi": 1852.0
    ]
    
    var convertedValue: Double {
        guard let srcCoefficient = units[sourceUnits] else { return 0.0 }
        guard let dstCoefficient = units[targetUnits] else { return 0.0 }
        return value * srcCoefficient / dstCoefficient
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Source units", selection: $sourceUnits) {
                        ForEach(Array(units.keys).sorted(), id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    
                    TextField(value: $value, format: .number) {
                        Text("Value to convert")
                    }
                    .keyboardType(.decimalPad)
                    .focused($valueIsFocused)
                } header: {
                    Text("From:")
                }
                
                Section {
                    Picker("Target units", selection: $targetUnits) {
                        ForEach(Array(units.keys).sorted(), id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    
                    Text(convertedValue, format: .number.precision(.fractionLength(2)))
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)

                } header: {
                    Text("To:")
                }
            }
            .navigationBarTitle("Unit Converter")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") { valueIsFocused = false }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
