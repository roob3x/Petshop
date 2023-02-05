//
//  PetshopCardView.swift
//  Petshop
//
//  Created by Roberto Filho on 25/01/23.
//

import SwiftUI
import Combine

struct PetshopCardView: View {
    
    @State private var action = false
    let isChart: Bool
    let viewModel: PetshopCardViewModel
    
    var body: some View {
        ZStack(alignment: .trailing){
            
            if isChart {
                NavigationLink(destination: viewModel.chartView(), isActive: self.$action, label: { EmptyView()
                    
                })
            }
            
            else {
                NavigationLink(destination: viewModel.petshopDetailView(), isActive: self.$action, label: {EmptyView()
                    
                }
                )
            }
            
            
            Button(action: {
                self.action = true
            }, label: {
                HStack {
                    ImageView(url: viewModel.icon)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .clipped()
                    //Image(systemName: "pencil")
                        .padding(.horizontal, 8)
                    Spacer()
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.name)
                                .foregroundColor(Color.blue)
                            
                            Text(viewModel.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundColor(Color("textColor"))
                                .bold()
                        }.frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text("Registrado")
                                .foregroundColor(Color.blue)
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.value)
                                .foregroundColor(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                        }

                    }
                }
                .padding()
                .cornerRadius(4.0)
            })
            if !isChart {
                Rectangle()
                    .frame(width: 8)
                    .foregroundColor(viewModel.state)
            }
            
        }.background(RoundedRectangle(cornerRadius: 4.0)
            .stroke(Color.blue, lineWidth: 1.4)
            .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
       
    }
}

struct PetshopCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            NavigationView{
                List {
                    PetshopCardView(isChart: false, viewModel: PetshopCardViewModel(id: 1, icon: "https://via.placeholder.com/150", date: "01/01/2023 00:00:00", name: "Estudar swift", label: "horas", value: "2", state: .green, petshopPublisher: PassthroughSubject<Bool, Never>()))
                    PetshopCardView(isChart: false, viewModel: PetshopCardViewModel(id: 1, icon: "https://via.placeholder.com/150", date: "01/01/2023 00:00:00", name: "Crossfit", label: "horas", value: "3", state: .green, petshopPublisher: PassthroughSubject<Bool, Never>()))
                    PetshopCardView(isChart: false, viewModel: PetshopCardViewModel(id: 1, icon: "https://via.placeholder.com/150", date: "01/01/2023 00:00:00", name: "Ingles", label: "horas", value: "3", state: .green, petshopPublisher: PassthroughSubject<Bool, Never>()))
                    PetshopCardView(isChart: false, viewModel: PetshopCardViewModel(id: 1, icon: "https://via.placeholder.com/150", date: "01/01/2023 00:00:00", name: "Namorar", label: "horas", value: "3", state: .green, petshopPublisher: PassthroughSubject<Bool, Never>()))
                    
                }.frame(maxWidth: .infinity)
                    .navigationTitle("Compras")
            }
                .previewDevice("Iphone 11")
                .preferredColorScheme($0)
        }
    }
}
