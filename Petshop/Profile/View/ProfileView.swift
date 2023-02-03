//
//  ProfileView.swift
//  Petshop
//
//  Created by Roberto Filho on 01/02/23.
//

import SwiftUI

struct ProfileView: View {
    
    var disableDone: Bool {
        viewModel.fullNameValidation.failure || viewModel.phoneValidation.failure || viewModel.birthdayValidation.failure
    }
    
    @ObservedObject var viewModel: ProfileViewModel
    
    
    var body: some View {
        ZStack {
            if case ProfileUiState.loading = viewModel.uiState {
                ProgressView()
            }
            else {
                NavigationView {
                    VStack {
                        Form {
                            Section(header: Text("Dados cadastrais")) {
                                HStack {
                                    Text("Nome")
                                    Spacer()
                                    TextField("Digite o nome", text: $viewModel.fullNameValidation.value)
                                        .keyboardType(.alphabet)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.fullNameValidation.failure {
                                    Text("Nome deve ter mais de 5 caracteres")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("Email")
                                    Spacer()
                                    TextField("Digite o email", text: $viewModel.email)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("CPF")
                                    Spacer()
                                    TextField("Digite o CPF", text: $viewModel.document)
                                        .disabled(true)
                                        .foregroundColor(Color.gray)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                HStack {
                                    Text("Telefone")
                                    Spacer()
                                    TextField("Digite o seu celular", text: $viewModel.phoneValidation.value)
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.phoneValidation.failure {
                                    Text("Entre com o DDD +8 ou 9 digitos")
                                        .foregroundColor(.red)
                                }
                                
                                HStack {
                                    Text("Data Nascimento")
                                    Spacer()
                                    TextField("Digite a sua data de nascimento", text: $viewModel.birthdayValidation.value)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                if viewModel.birthdayValidation.failure {
                                    Text("Data deve ser dd/MM/yyyy")
                                    
                                }
                                
                                NavigationLink(destination: GenderSelectorView(selectedGender: $viewModel.gender, genders: Gender.allCases, title: "Escolha o genero"),
                                   label: {
                                    Text("Genero")
                                    Spacer()
                                    Text(viewModel.gender?.rawValue ?? "")
                                })
                            }
                        }
                    }
                    .navigationBarTitle(Text("Editar Perfil"), displayMode: .automatic)
                    .navigationBarItems(trailing: Button(action: {}, label: {
                        Image(systemName: "checkmart")
                            .foregroundColor(.blue)
                    })
                        .opacity(disableDone ? 0 : 1)
                    )
                }
            }
            if case ProfileUiState.fetchError(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                        })
                    }
            }
        }
        .onAppear(perform: viewModel.fetchUser)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(interector: ProfileInterector()))
    }
}
