//
//  PetshopCreateView.swift
//  Petshop
//
//  Created by Roberto Filho on 08/02/23.
//

import SwiftUI

struct PetshopCreateView: View {
    
    @ObservedObject var viewModel: PetshopCreateViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var shouldPresentCamera = false
    
    init(viewModel: PetshopCreateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                Button(action: {
                    self.shouldPresentCamera = true
                }, label: {
                    VStack {
                        viewModel.image!
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        Text("Clique aqui para enviar")
                            .foregroundColor(.blue)
                    }
                    .foregroundColor(.blue)
                })
                .padding(.bottom, 12)
                .sheet(isPresented: self.$shouldPresentCamera) {
                    ImagePickerView(image: self.$viewModel.image, imageData: $viewModel.imageData, isPresented: $shouldPresentCamera, sourceType: .camera)
                }
            }
            
            VStack {
                TextField("Escreva aqui o nome do produto", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            VStack {
                TextField("Escreva aqui a unidade de medida", text: $viewModel.label)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            
            LoadingButtonView(action: {
                viewModel.save()
                
            }, text: "Salvar", showProgress: self.viewModel.uiState == .loading, disabled: self.viewModel.name.isEmpty || self.viewModel.label.isEmpty)
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

struct PetshopCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            PetshopCreateView(viewModel: PetshopCreateViewModel(interactor: PetshopCreateInteractor()))
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
