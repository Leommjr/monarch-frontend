import SwiftUI
import MapKit
import CoreLocation

let locations = [
    Location(name: "Reitoria UFU", coordinate: CLLocationCoordinate2D(latitude: -18.9190014,longitude: -48.2621052), description: "", type: "pontoEvento", image: "", time: 0, user: ""),
    Location(name: "Bloco 1B", coordinate: CLLocationCoordinate2D(latitude: -18.91848795116736,longitude: -48.259578012627536), description: "", type: "pontoEncontro", image: "", time: 0, user: "Bruno")
]

struct MapView: View {
    @StateObject var locationManager = LocationManager()
    
    @State var region = MKCoordinateRegion(
        center: locations[0].coordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    
    @State var sheetEvent = false
    @State var sheetEncontro = false
    @State var sheetFixo = false
    @State var sheetList = false
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Rectangle()
                        .ignoresSafeArea()
                        .frame(height: 50)
                        .foregroundColor(.blue)
                    
                    HStack(){
                        Image(systemName: "magnifyingglass")
                            .padding(.horizontal)
                        Spacer()
                        Image(systemName: "list.dash")
                            .padding(.horizontal)
                            .onTapGesture {
                                sheetList = true
                            }.sheet(isPresented: $sheetList){
                                
                                ScrollView(.vertical){
                                    ForEach(locations) { location in
                                        Button(){
                                            region.center = location.coordinate
                                            sheetList = false
                                            switch location.type {
                                            case "pontoEvento":
                                                sheetEvent = true
                                            case "pontoEncontro":
                                                sheetEncontro = true
                                            case "pontoFixo":
                                                sheetFixo = true
                                            default:
                                                sheetList = true
                                            }
                                        } label: {
                                            HStack{
                                                Image("location-dot-solid")
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                                Text(location.name)
                                                Spacer()
                                            }
                                        }
                                        .padding()
                                    }
                                    
                                }
                            }
                    }
                }
                
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: locations){location in
                    
                    MapAnnotation(coordinate: location.coordinate){
                        switch location.type {
                        case "pontoEncontro":
                            Button {
                                sheetEncontro = true
                            } label: {
                                Image(systemName: "pin.fill")
                            }
                            .sheet(isPresented: $sheetEncontro){
                                EncontroView(location: location).presentationDetents([.height(400),.medium,.large]).presentationDragIndicator(.automatic)
                            }
                        case "pontoEvento":
                            Button {
                                sheetEvent = true
                            } label: {
                                Image("location-dot-solid")
                                    .resizable()
                                    .frame(width: 20,height: 30)
                                    .scaledToFit()
                            }
                            .sheet(isPresented: $sheetEvent){
                                EventoView(location: location).presentationDetents([.height(400),.medium,.large]).presentationDragIndicator(.automatic)
                            }
                        case "pontoFixo":
                            Button {
                                sheetFixo = true
                            } label: {
                                Image(systemName: "pin.fill")
                            }
                            .sheet(isPresented: $sheetFixo){
                                FixoView(location: location).presentationDetents([.height(400),.medium,.large]).presentationDragIndicator(.automatic)
                            }
                            
                        default:
                            Text("")
                        }
                        
                    }
                }
                
            }
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    Button(){
                        region = locationManager.userRegion
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
