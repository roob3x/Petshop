//
//  SplashViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUiState = .loading
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.uiState = .goToSignInScreen
        }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
    
    func signUpView() -> some View {
        return SplashViewRouter.makeSignUpView()
    }
}
