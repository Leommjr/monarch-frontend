//
//  SearchView.swift
//  monarch
//
//  Created by Student22 on 22/08/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct SearchView: View {
    var _search : [Location]
    @Binding var _region : MKCoordinateRegion
    
    @Binding var _text : String
    
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("Entre com o nome do evento", text: $_text){
                    
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.center)
                    .background(Color.white)
                    .padding()
                
            }.padding()
        }
        
        ScrollView{
            ForEach(_search) { location in
                VStack(spacing: 10){
                    Button(){
                        _region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.localization!.x!,longitude: location.localization!.y!), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
                        
                    }label: {
                        
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                            Spacer()
                            Text(location.name!)
                                .padding(10)
                            Spacer()
                        }.background(Color.gray.opacity(0.15))
                            .frame(width: 340.0, height: 30.0)
                            .cornerRadius(10)
                    }
                    
                }
            }
        }
    }
    
    
    
    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            MapView()
        }
    }
}
