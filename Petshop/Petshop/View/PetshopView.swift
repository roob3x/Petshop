//
//  PetshopView.swift
//  Petshop
//
//  Created by Roberto Filho on 24/01/23.
//

import SwiftUI

struct PetshopView: View {
    
    @ObservedObject var viewModel: PetshopViewModel
    
    var body: some View {
        ZStack {
            if case PetshopUiState.loading = viewModel.uiState {
                progress
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12){
                            topContainer
                            
                            addButton
                            if case PetshopUiState.emptyList = viewModel.uiState {
                                VStack {
                                    Spacer(minLength: 60)
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    
                                    Text("Nenhum produto comprado ainda :(")
                                }
                            }
                            else if case PetshopUiState.fullList(let rows) = viewModel.uiState {
                                LazyVStack {
                                    ForEach(rows, content: PetshopCardView.init(viewModel:))
                                }
                                
                            }
                            else if case PetshopUiState.error = viewModel.uiState {
                                
                            }
                        }
                    }.navigationTitle("Compras")
                }
            }
        }.onAppear {
            viewModel.onAppear()
        }
    }
}

extension PetshopView {
    var progress: some View {
        ProgressView()
    }
}

extension PetshopView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
            
            Text(viewModel.title)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color.blue)
            
            Text(viewModel.headline)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.desc)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("textColor"))

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

extension PetshopView {
    var addButton: some View {
        NavigationLink(destination: Text("Tela de Adicionar").frame(maxWidth: .infinity, maxHeight: .infinity)){
            Label("Comprar", systemImage: "plus.app")
                .modifier(ButtonStyle())
        }
        .padding(.horizontal, 16)
    }
}

struct PetshopView_Previews: PreviewProvider {
    static var previews: some View {
        PetshopView(viewModel: PetshopViewModel())
    }
}
