import SwiftUI

struct EncontroView: View {
    @State var location: Location

    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack{
                Text("Ponto de Encontro")
                Text("Criado por \(location.name ?? "")")
                    .font(.title3)
            }
        }
    }
}

struct EncontroView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
