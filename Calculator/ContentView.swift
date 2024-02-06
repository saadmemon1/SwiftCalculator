//
//  ContentView.swift
//  Calculator
//
//  Created by Saad Inam on 17/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State var currentValue: String = "0"
    var body: some View {
        ZStack {
            Color.black
        VStack {
            TotalText(value: currentValue)
            ButtonGrid(currentValue: $currentValue)
        }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
