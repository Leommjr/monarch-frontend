import SwiftUI

struct EncontroView: View {
    @State var location: Location

    var body: some View {
        Text("Encontro")
        VStack{
            Text("Encontro")
            Text("Criado por \(location.name ?? "")")
        }
    }
}

struct EncontroView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
