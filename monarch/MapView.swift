import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @StateObject var locationManager = LocationManager()
    @State var tracking:MapUserTrackingMode = .follow
    
    @StateObject var viewModel: ViewModel = ViewModel()
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -18.9190014,longitude: -48.2621052),
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
            return viewModel.locations
        }
        else{
            return
                viewModel.locations.filter{($0.name!.lowercased().contains(searchText.lowercased())
                                        || $0.type.rawValue.lowercased().contains(searchText.lowercased()))
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                ZStack{
                    
                    Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $tracking, annotationItems: viewModel.locations){location in
                        
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.localization!.x!,longitude: location.localization!.y!)){
                            switch location.type {
                            case TipoPonto.pontoEncontro:
                                Button {
                                    sheetEncontro = true
                                } label: {
                                    Image("butterfly")
                                        .resizable()
                                        .frame(width: 20,height: 20)
                                        .scaledToFit()
                                }
                                .sheet(isPresented: $sheetEncontro){
                                    EncontroView(location: location).presentationDetents([.height(400),.medium,.large]).presentationDragIndicator(.automatic)
                                }
                            case TipoPonto.pontoEvento:
                                Button {
                                    sheetEvent = true
                                } label: {
                                    Image("hibiscus")
                                        .resizable()
                                        .frame(width: 20,height: 20)
                                        .scaledToFit()
                                }
                                .sheet(isPresented: $sheetEvent){
                                    EventoView(location: location).presentationDetents([.height(400),.medium,.large]).presentationDragIndicator(.automatic)
                                }
                            case TipoPonto.pontoFixo:
                                Button {
                                    sheetFixo = true
                                } label: {
                                    Image("tree")
                                        .resizable()
                                        .frame(width: 30,height: 30)
                                        .scaledToFit()
                                }
                                .sheet(isPresented: $sheetFixo){
                                    FixoView(location: location).presentationDetents([.height(400),.medium,.large]).presentationDragIndicator(.automatic)
                                }
                                
                            default:
                                Text("")
                            }
                            
                        }
                    }
                    VStack{
                        ZStack{
                            Rectangle()
                                .frame(width: 400, height: 50)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            HStack{
                                NavigationLink(destination: SearchView(_search: searchResults, _text: $searchText, _pontoEncontroFilter: $pontoEncontroFilter, _pontoFixoFilter: $pontoFixoFilter, _pontoEventoFilter: $pontoEventoFilter)){
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.black)
                                }
                                
                            }
                        }
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            Button(){
                                region = locationManager.userRegion
                            } label: {
                                Image("location-crosshairs")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding()
                            }
                        }
                    }
                    
                }.task{
                    await viewModel.getLocations()
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
