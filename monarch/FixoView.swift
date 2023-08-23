//
//  FixoView.swift
//  monarch
//
//  Created by Student06 on 21/08/23.
//

import SwiftUI

struct FixoView: View {
    @State var location: Location
    
    var body: some View {
        VStack{
            Image(systemName: "pencil.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            Text("\(location.name)")
                .font(.title)
            Text("Criado por \(location.user)")
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
            
        }
    }
}

struct FixoView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
