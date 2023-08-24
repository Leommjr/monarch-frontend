//
//  EventoView.swift
//  monarch
//
//  Created by Student06 on 21/08/23.
//

import SwiftUI
import MapKit

struct EventoView: View {
    @State var location: Location
    
    var body: some View {
        VStack{
            Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            Text("\(location.name ?? "")")
                .font(.title)
            Text("Criado por \(location.name ?? "")")
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

struct EventoView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(region: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -18.9190014,longitude: -48.2621052),
            span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    }
}
