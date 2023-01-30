//
//  SplashViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUiState = .loading
    
    private var cancellabeAuth: AnyCancellable?
    private var cancellabeRefresh: AnyCancellable?

    private let interactor: SplashInteractor

    init(interactor: SplashInteractor){
        self.interactor = interactor
    }
    
    
    deinit {
        cancellabeAuth?.cancel()
        cancellabeRefresh?.cancel()
    }
    
    func onAppear() {
        cancellabeAuth = interactor.fetchAuth()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                    print("token expirou")
                    let request =  RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellabeRefresh = self.interactor.refreshToken(refreshRequest: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion) {
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                            
                        }, receiveValue: { success in
                            print(success)
                            let auth = UserAuth(idToken: success.accessToken, refreshToken: success.refreshToken, expires: Date().timeIntervalSince1970 + Double(success.expires), tokenType: success.tokenType)
                            self.interactor.insertAuth(userAuth: auth)
                            
                            self.uiState = .goToHomeScreen
                            
                        })
                    
                } else {
                    self.uiState = .goToHomeScreen
                }
                
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
    
    func homeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
}
