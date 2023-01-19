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
        
        WebService.login(request: SignInRequest.init(email: email, password: password)) { (sucessResponse, errorResponse) in

            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail.message)
                }
            }
            
            if let sucess = sucessResponse {
                DispatchQueue.main.async {
                    self.uiState = .goToHomeScreen
                }
            }
            
            
            
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
