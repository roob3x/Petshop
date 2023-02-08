//
//  ChartView.swift
//  Petshop
//
//  Created by Roberto Filho on 05/02/23.
//

import SwiftUI

struct ChartView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    
    var body: some View {
        
        ZStack {
            if case ChartUiState.loading = viewModel.uiState {
                ProgressView()
            }
            else {
                VStack {
                    if case ChartUiState.emptyChart = viewModel.uiState {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        
                        Text("Nenhuma compra encontrada :(")
                    }
                    else if case ChartUiState.error(let msg) = viewModel.uiState {
                        Text("")
                            .alert(isPresented: .constant(true)) {
                                Alert(
                                title: Text("Ops! \(msg)"),
                                message: Text("Quer tentar novamente?"),
                                primaryButton: .default(Text("Sim")) {
                                    // aqui executa a retentativa
                                    viewModel.onAppear()
                                },
                                secondaryButton: .cancel()
                                )
                            }
                    }
                    else {
                        BoxChartView(entries: $viewModel.entries, dates: $viewModel.dates)
                            .frame(maxWidth: .infinity, maxHeight: 350)
                    }
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        PetshopCardViewRouter.makeChartView(id: 1)
    }
}
