//
//  SignInViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    private var cancellabe: AnyCancellable?

    private let publisher = PassthroughSubject<Bool, Never>()

    init(){
        cancellabe = publisher.sink { value in
            print("usuario criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    
    deinit {
        cancellabe?.cancel()
    }
    
    @Published var uiState: SignInUiState = .none
    
    func login(){
        self.uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.uiState = .goToHomeScreen
            //self.uiState = .error("Usuario nao cadastrado")
    }
    }
}

extension SignInViewModel {
    
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
