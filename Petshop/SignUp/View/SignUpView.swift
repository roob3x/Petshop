//
//  SignUpView.swift
//  Petshop
//
//  Created by Roberto Filho on 03/01/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .center){
             
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cadastro")
                        .foregroundColor(Color("textColor"))
                        .font(Font.system(.title).bold())
                        .padding(.bottom, 8)
                    fullNameField
                    emailField
                    passwordField
                    phoneField
                    birthdayField
                    
                    documentField
                    genderField
                    saveButton
                }
                
                Spacer()
            }.padding(.horizontal, 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.padding()
        
        if case SignUpUiState.error(let msg) = viewModel.uiState {
            Text("")
                .alert(isPresented: .constant(true)) {
                    Alert(title: Text("Petshop"), message: Text(msg), dismissButton: .default(Text("Ok")) {
                    })
                }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName, placeholder: "Nome Completo *", keyboard: .alphabet, error: "Preencha seu nome corretamente", failure: viewModel.fullName.count < 5)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email, placeholder: "Email *", keyboard: .emailAddress, error: "Email invalido", failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password, placeholder: "Senha *", keyboard: .asciiCapableNumberPad, error: "Senha invalida, deve possuir no minimo 8 caracteres", failure: viewModel.password.count < 8, isSecure: true)
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone, placeholder: "Telefone *", keyboard: .numberPad, error: "Preencha  DD + Telefone", failure: viewModel.phone.count < 10 || viewModel.phone.count >= 12)
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday, placeholder: "Data de nascimento *", keyboard: .numberPad, error: "Preencha data nasc dd-MM-YYYY", failure: viewModel.birthday.count < 10)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document, placeholder: "CPF *", keyboard: .numberPad, error: "Preencha corretamente seu CPF", failure: viewModel.document.count != 11)
        //TODO MASK
        //TODO isDisabled
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(action: {
            viewModel.signUp()
            
        },
          text: "Cadastrar",
          showProgress: self.viewModel.uiState == SignUpUiState.loading,
                          disabled: !viewModel.email.isEmail() || viewModel.password.count < 8
                          || viewModel.fullName.count < 3
                          || viewModel.document.count != 11
                          || viewModel.phone.count < 10 || viewModel.phone.count >= 12
                          || viewModel.birthday.count < 10
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
