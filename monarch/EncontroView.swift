//
//  EncontroView.swift
//  monarch
//
//  Created by Student06 on 21/08/23.
//

import SwiftUI

struct EncontroView: View {
    @State var location: Location
    
    var body: some View {
        VStack{
            Text("Encontro")
            Text("Criado por \(location.user)")
        }
    }
}

struct EncontroView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
