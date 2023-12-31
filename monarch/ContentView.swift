//
//  ContentView.swift
//  monarch
//
//  Created by Student06 on 21/08/23.
//

import SwiftUI
import UIKit
import CoreLocation
import MapKit

struct ContentView: View {
    
    
    var body: some View {
        TabView{
            MapView()
                .tabItem(){
                    Label("", systemImage: "map")
                }
            AddPointView()
                .tabItem(){
                    Label("", systemImage: "plus.app")
                }
            MapView()
                .tabItem(){
                    Label("", systemImage: "person")
                }
        }
        .tint(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
