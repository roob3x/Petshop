//
//  LoadingButtonView.swift
//  Petshop
//
//  Created by Roberto Filho on 03/01/23.
//

import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var text: String
    var showProgress: Bool = false
    var disabled: Bool = false
    
    var body: some View {
        Button(action: {
            action()
        },
               label: {
            Text(showProgress ? "" : text)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .font(Font.system(.title3).bold())
                .background(disabled ? Color("lightBlue") : Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(4.0)
                .cornerRadius(4.0)
        }).disabled(disabled || showProgress)
        
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .opacity(showProgress ? 1 : 0)
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonView(action: {
            print("Ola mundo")
        },text: "Entrar"
        ,showProgress: false
        ,disabled: true)
    }
}
