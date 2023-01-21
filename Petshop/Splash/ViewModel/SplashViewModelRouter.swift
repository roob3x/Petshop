//
//  SplashViewModelRouter.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI

enum SplashViewRouter {
    
    static func makeSignInView() -> some View {
        return SignInView(viewModel: SignInViewModel(interactor: SignInInteractor()))
    }
    static func makeSignUpView() -> some View {
        return SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
    }
    
}
