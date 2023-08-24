//
//  SearchView.swift
//  monarch
//
//  Created by Student22 on 22/08/23.
//

import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            
            configuration.isOn.toggle()
            
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }.foregroundColor(.black)
        })
    }
}

struct SearchView: View {
    var _search : [Location]
    @Binding var _text : String
    
    @Binding var _pontoEncontroFilter : Bool
    @Binding var _pontoFixoFilter : Bool
    @Binding var _pontoEventoFilter : Bool
    
    
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
