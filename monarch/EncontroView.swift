import SwiftUI
import MapKit

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
        MapView(region: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -18.9190014,longitude: -48.2621052),
            span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)))
    }
}
