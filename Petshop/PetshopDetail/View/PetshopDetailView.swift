//
//  PetshopDetailView.swift
//  Petshop
//
//  Created by Roberto Filho on 30/01/23.
//

import SwiftUI

struct PetshopDetailView: View {
    
    @ObservedObject var viewModel: PetshopDetailViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: PetshopDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(Color.blue)
                    .font(.title.bold())
                Text("Unidade: \(viewModel.label)")
            }
            
            VStack {
                TextField("Escreva aqui o valor", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            Text("Compre todos os dias :)")
            
            LoadingButtonView(action: {
                viewModel.save()
                
            }, text: "Salvar", showProgress: self.viewModel.uiState == .loading, disabled: self.viewModel.value.isEmpty)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Button("Cancelar") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation(.easeOut(duration: 0.15)) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32)
    }
}

struct PetshopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            PetshopDetailView(viewModel: PetshopDetailViewModel(id: 1, name: "Aipods 2 pro", label: "Quantidade", interactor: PetshopDetailInteractor()))
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
