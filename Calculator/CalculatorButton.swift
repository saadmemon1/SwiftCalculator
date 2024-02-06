//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Saad Inam on 17/01/2024.
//

import SwiftUI

struct CalculatorButton: View {
    var width: CGFloat = 70
    var num = "2"
    var color = Color(.darkGray)
    var action: (CalculatorButton) -> Void = {_ in }
    var mode: CalculatorMode = .notSet
    var body: some View {
        Button {
            action(self)
        }
        label: {
            Text(num).font(.largeTitle)
                .frame(width: width, height: 70, alignment: .center)
                .background(color)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

#Preview {
    CalculatorButton()
}
