import SwiftUI
import MapKit
import CoreLocation

let locations = [
    Location(name: "Reitoria UFU", coordinate: CLLocationCoordinate2D(latitude: -18.9190014,longitude: -48.2621052), description: "", type: "pontoEvento", image: "", time: 0, user: ""),
    Location(name: "Bloco 1B", coordinate: CLLocationCoordinate2D(latitude: -18.91848795116736,longitude: -48.259578012627536), description: "", type: "pontoEncontro", image: "", time: 0, user: "")
]

struct MapView: View {
    @State var region = MKCoordinateRegion(
        center: locations[0].coordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    
    @State var sheetEvent = false
    @State var sheetEncontro = false
    @State var sheetFixo = false
    @State var sheetList = false
    
    @State var pontoEncontroFilter = false;
    @State var pontoFixoFilter = false;
    @State var pontoEventoFilter = false;
    
    @State var searchText = ""
    
    var searchResults : [Location]{
        if searchText.isEmpty{
            return locations
        }
        else{
            return
                locations.filter{($0.name.lowercased().contains(searchText.lowercased())
                              || $0.type.lowercased().contains(searchText.lowercased()))
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.15))
                        .cornerRadius(10)
                        .frame(width: 370, height: 60)
                    HStack(){
                        NavigationLink(destination: SearchView(_search: searchResults, _text: $searchText, _pontoEncontroFilter: $pontoEncontroFilter, _pontoFixoFilter: $pontoFixoFilter, _pontoEventoFilter: $pontoEventoFilter)){
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding(.leading)
                        }
                        .accentColor(.black)
                        
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
                Map(coordinateRegion: $region, annotationItems: locations){location in
                    
                    MapAnnotation(coordinate: location.coordinate){
                        switch location.type {
                        case "pontoEncontro":
                            Button {
                                sheetEncontro = true
                            } label: {
                                Image(systemName: "pin.fill")
                            }
                            .sheet(isPresented: $sheetEncontro){
                                EncontroView().presentationDetents([.height(200),.medium,.large]).presentationDragIndicator(.automatic)
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
                                EventoView().presentationDetents([.height(200),.medium,.large]).presentationDragIndicator(.automatic)
                            }
                        case "pontoFixo":
                            Button {
                                sheetFixo = true
                            } label: {
                                Image(systemName: "pin.fill")
                            }
                            .sheet(isPresented: $sheetFixo){
                                FixoView().presentationDetents([.height(200),.medium,.large]).presentationDragIndicator(.automatic)
                            }
                            
                        default:
                            Text("")
                        }
                        
                    }
                }.ignoresSafeArea()
            }
            
        }.accentColor(.black)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
