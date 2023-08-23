import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        TabView(){
            
            MapView()
                .tabItem(){
                    Label("", systemImage: "house")
                }
            
        }
        .onAppear(){
            UITabBar.appearance().backgroundColor = .blue
        }
        .tint(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
