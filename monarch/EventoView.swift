//
//  EventoView.swift
//  monarch
//
//  Created by Student06 on 21/08/23.
//

import SwiftUI

struct EventoView: View {
    @State var location: Location
    @State var name: String = ""
    @StateObject var viewModel: ViewModel = ViewModel()
    
    func dateTime(timestamp: Int64) -> String {
        var strDate = "undefined"
        
    
        let unixTime = Double(timestamp)
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        _ = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
        dateFormatter.timeZone = TimeZone(abbreviation: "BRT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm" //Specify your format that you want
        strDate = dateFormatter.string(from: date)
        
            
        return strDate
    }
    
    @State var strDate: String = ""
    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
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
                    Text("O evento termina em:")
                    Text(strDate)
                        .font(.title2)
                        .onAppear(){
                            strDate = dateTime(timestamp: 1678716422)
                        }
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

struct EventoView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
