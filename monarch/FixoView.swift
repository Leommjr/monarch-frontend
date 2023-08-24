//
//  FixoView.swift
//  monarch
//
//  Created by Student06 on 21/08/23.
//

import SwiftUI

struct FixoView: View {
    @State var location: Location
    @State var name: String = ""
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.white]), startPoint: .top, endPoint: .center).ignoresSafeArea()
            VStack{
                VStack{
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .padding()
                    Text("\(location.name ?? "")")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Criado por \(name)")
                        .font(.caption)
                    Spacer()
                }
                Spacer()
                VStack{
                    //Parte do EVENTO
                    
                    //FIM EVENTO
                    Text("Categoria")
                        .padding(10)
                        .background(.purple)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                    VStack(alignment: .leading){
                        HStack{
                            Text("Descrição")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        Text("\(location.description!)")
                        
                    }
                    .padding(10)
                    .frame(width: 300.0)
                    .background(.gray)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    Spacer()
                }
            }.task{
            await viewModel.getUserById(userId: location.creatorId!)
            name = viewModel.user!.name!
           }
        }
        
    }
}

struct FixoView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
