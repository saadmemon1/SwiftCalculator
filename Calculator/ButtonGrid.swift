//
//  ButtonGrid.swift
//  Calculator
//
//  Created by Saad Inam on 17/01/2024.
//

import SwiftUI


enum CalculatorMode {
    case notSet
    case addition
    case subtraction
    case multiplication
    case division
    case percentage
}

struct ButtonGrid: View {
    @Binding var currentValue: String
    @State var currentMode: CalculatorMode = .notSet
    @State var lastButtonWasMode = false
    @State var savedInt: Double = 0
    @State var currentInt: Double = 0
    @State var dotPressed = false
    var body: some View {
        Grid {
            GridRow {
                CalculatorButton(num: "AC", color: Color(.lightGray), action: clearWasPressed)
                CalculatorButton(num: "%", color: Color(.lightGray), action: modeWasPressed, mode: .percentage)
                CalculatorButton(num: "C", color: Color(.lightGray), action: clearLastDigit)
                CalculatorButton(num: "/", color: Color.orange, action: modeWasPressed, mode: .division)
            }
            GridRow {
                CalculatorButton(num: "7", action: numWasPressed)
                CalculatorButton(num: "8", action: numWasPressed)
                CalculatorButton(num: "9", action: numWasPressed)
                CalculatorButton(num: "X", color: Color.orange, action: modeWasPressed, mode: .multiplication)
            }
            GridRow {
                CalculatorButton(num: "4", action: numWasPressed)
                CalculatorButton(num: "5", action: numWasPressed)
                CalculatorButton(num: "6", action: numWasPressed)
                CalculatorButton(num: "-", color: Color.orange, action: modeWasPressed, mode: .subtraction)
            }
            GridRow {
                CalculatorButton(num: "1", action: numWasPressed)
                CalculatorButton(num: "2", action: numWasPressed)
                CalculatorButton(num: "3", action: numWasPressed)
                CalculatorButton(num: "+", color: Color.orange, action: modeWasPressed, mode: .addition)
            }
            GridRow {
                CalculatorButton(width: 148, num: "0", action: numWasPressed)
                    .gridCellColumns(2)
                CalculatorButton(num: ".", action: dotWasPressed)
                CalculatorButton(num: "=", color: Color.orange, action: equalWasPressed)
            }
        }
    }
    
    func dotWasPressed(button: CalculatorButton) {
        print("Dot button was pressed")
        if !currentValue.contains(".") {
            currentValue += "."
            print("Current value after adding dot:", currentValue)
            updateText()
        }
    }
    
    func clearLastDigit(button: CalculatorButton) {
        if currentValue.count > 1 {
            currentValue.removeLast()
            if let newValue = Double(currentValue) {
                currentInt = newValue
                updateText()
            }
        } else {
            currentValue = "0"
            currentInt = 0
            updateText()
        }
    }
    
    
    
    func modeWasPressed(button: CalculatorButton) {
        currentMode = button.mode
        lastButtonWasMode = true
    }
    
    func clearWasPressed(button: CalculatorButton) {
        currentValue = "0"
        currentMode = .notSet
        lastButtonWasMode = false
        currentInt = 0
        savedInt = 0
    }
    
    func numWasPressed(button: CalculatorButton) {
        if lastButtonWasMode {
            lastButtonWasMode = false
            currentValue = "0"
        }
            handleRegularNumber(button.num)
    }
        private func handleRegularNumber(_ num: String) {
            if currentValue == "0" {
                currentValue = num
            } else {
                currentValue += num
            }
            
            if let newValue = Double(currentValue) {
                currentInt = newValue
            } else {
                currentValue = "Error"
                currentInt = 0
            }
            updateText()
        }
        
        
        func equalWasPressed(button: CalculatorButton) {
            if currentMode == .notSet || lastButtonWasMode {
                return
            }
            
            if currentMode == .addition {
                savedInt += currentInt
            }
            else if currentMode == .subtraction {
                savedInt -= currentInt
            }
            else if currentMode == .multiplication {
                savedInt *= currentInt
            }
            else if currentMode == .division && currentInt != 0 {
                savedInt /= currentInt
            }
            else if currentMode == .percentage {
                savedInt *= currentInt / 100
            }
            else { print("Error") }
            
            currentInt = savedInt
            updateText()
            lastButtonWasMode = true
        }
        
        func updateText() {
            if currentMode == .notSet {
                savedInt = currentInt
            }
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let formattedValue = formatter.string(from: NSNumber(value: currentInt)) {
                currentValue = formattedValue
            } else {
                currentValue = "Error"
            }
        }
        
        
        
        
        struct ButtonGrid_Previews: PreviewProvider {
            @State static var currentValue = "1"
            static var previews: some View {
                ButtonGrid(currentValue: $currentValue)
            }
        }
    }
    
