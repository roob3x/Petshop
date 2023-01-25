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
    private var cancellabeRequest: AnyCancellable?

    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor

    init(interactor: SignInInteractor){
        self.interactor = interactor
        
        cancellabe = publisher.sink { value in
            print("usuario criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    
    deinit {
        cancellabe?.cancel()
        cancellabeRequest?.cancel()
    }
    
    @Published var uiState: SignInUiState = .none
    
    func login(){
        self.uiState = .loading
        
        cancellabeRequest =  interactor.login(loginRequest: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // aqui acontece o ERROR ou o finished
                switch(completion) {
                case .failure(let appError):
                    self.uiState = SignInUiState.error(appError.message)
                    break
                case . finished:
                    break
                }
            //
        } receiveValue: { success in
            // aqui acontence o SUCESSO
            print(success)
            let auth = UserAuth(idToken: success.accessToken, refreshToken: success.refreshToken, expires: Date().timeIntervalSince1970 + Double(success.expires), tokenType: success.tokenType)
            self.interactor.insertAuth(userAuth: auth)
            self.uiState = .goToHomeScreen
                
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
