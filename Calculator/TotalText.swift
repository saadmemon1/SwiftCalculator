//
//  TotalText.swift
//  Calculator
//
//  Created by Saad Inam on 17/01/2024.
//

import SwiftUI

struct TotalText: View {
    var value = "0"
    var body: some View {
        Text(value)
            .font(.system(size: 60))
            .foregroundColor(.white)
            .fontWeight(.light)
            .padding()
            .frame(width: 300, alignment: .trailing)
            .lineLimit(1)
    }
}

#Preview {
    TotalText()
}
