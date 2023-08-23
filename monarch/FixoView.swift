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
        VStack{
            Image(systemName: "pencil.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            Text("\(location.name ?? "")")
                .font(.title)
            Text("Criado por \(name)")
                .font(.caption)
            Spacer()
            VStack{
                Text("Tempo")
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                Text("Categoria")
                    .background(.white)
                    .cornerRadius(20)
                Text("Descricao")
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
            }
            .padding()
            .background(.gray)
            .cornerRadius(20)
            Spacer()
            
        }.task{
            await viewModel.getUserById(userId: location.creatorId!)
            name = viewModel.user!.name!
        }
    }
    
}

struct FixoView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
