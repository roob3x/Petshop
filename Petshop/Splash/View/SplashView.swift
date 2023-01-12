//
//  SplashView.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.signInView()
            case .goToSignUpScreen:
                viewModel.signUpView()
            case .goHomeScreen:
                Text("Bem vindo a home")
            case .error(let _msg):
                Text("Erro ao cadastrar")
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

// funcoes com extensao
extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(1)
                .ignoresSafeArea()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: SplashViewModel())
    }
}
