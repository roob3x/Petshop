//
//  ProfileView.swift
//  Petshop
//
//  Created by Roberto Filho on 01/02/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    @State var email = "robe@gmail.com"
    @State var cpf = "321.075.013-00"
    @State var selectedGender: Gender? = .male
    
    var body: some View {
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
                            TextField("Digite o email", text: $email)
                                .disabled(true)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("CPF")
                            Spacer()
                            TextField("Digite o CPF", text: $cpf)
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
                        
                        NavigationLink(destination: GenderSelectorView(selectedGender: $selectedGender, genders: Gender.allCases, title: "Escolha o genero"),
                           label: {
                            Text("Genero")
                            Spacer()
                            Text(selectedGender?.rawValue ?? "")
                        })
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
