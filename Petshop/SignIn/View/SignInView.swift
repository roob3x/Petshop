//
//  SignInView.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var action: Int? = 0
    
    @State var navigationHidden = true
    
    var body: some View {
        ZStack {
            if case SignInUiState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            }
            else {
                NavigationView {
                    ScrollView(showsIndicators: false){
                        VStack(alignment: .center, spacing: 40) {
                            
                            Spacer(minLength: -150)
                            
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 1)
                                Spacer()
                                
                                Text("Para acessar a sua conta, faça o seu login")
                                    .foregroundColor(.black)
                                    //.font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                emailField
                                passwordField
                                VStack(alignment: .trailing, spacing: 0){
                                Text("Esqueci a senha")
                                    
                                }
                                enterButton
                                Spacer()
                                registerLink
                                
                                Text("Copyright all reserved Rbf solucoes 2022")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 13).bold())
                                    .padding(.top, 16)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension SignInView {
    var emailField: some View {
        EditTextView(text: $viewModel.email, placeholder: "Email", keyboard: .emailAddress, error: "Email invalido", failure: !viewModel.email.isEmail())
    }
}

extension SignInView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password, placeholder: "Senha", keyboard: .asciiCapableNumberPad, error: "Senha invalida, deve possuir no minimo 8 caracteres", failure: viewModel.password.count < 8, isSecure: true)
    }
}

extension SignInView {
    var enterButton: some View {
        LoadingButtonView(action: {
            viewModel.login()
            
        },
          text: "Entrar",
          showProgress: self.viewModel.uiState == SignInUiState.loading,
                          disabled: !viewModel.email.isEmail() || viewModel.password.count < 8)
    }
}

extension SignInView {
    var registerLink: some View {
        VStack{
            Text("Ainda nao possui o login ativo?")
                .foregroundColor(.gray)
                .padding(.top, 48)
            
            ZStack {
                NavigationLink(
                    destination: viewModel.signUpView(),
                               tag: 1,
                               selection: $action,
                                label: {EmptyView() })
                
                Button("Cadastre-se") {
                    self.action = 1
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel())
    }
}
