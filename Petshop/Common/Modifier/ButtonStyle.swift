//
//  ButtonStyle.swift
//  Petshop
//
//  Created by Roberto Filho on 25/01/23.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .font(Font.system(.title3).bold())
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(4.0)
    }
}
