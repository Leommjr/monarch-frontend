import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @StateObject var locationManager = LocationManager()
    
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
                                    ForEach(viewModel.locations) { location in
                                        Button(){
                                            region.center = CLLocationCoordinate2D(latitude: location.localization!.x!,longitude: location.localization!.y!)
                                            sheetList = false
                                            switch location.type {
                                            case TipoPonto.pontoEvento:
                                                sheetEvent = true
                                            case TipoPonto.pontoEncontro:
                                                sheetEncontro = true
                                            case TipoPonto.pontoFixo:
                                                sheetFixo = true
                                            default:
                                                sheetList = true
                                            }
                                        } label: {
                                            HStack{
                                                Image("location-dot-solid")
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                                Text(location.name!)
                                                Spacer()
                                            }
                                        }
                                        .padding()
                                    }
                                    
                                }
                            }
                    }
                }
                .ignoresSafeArea()
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: viewModel.locations){location in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.localization!.x!,longitude: location.localization!.y!)){
                        switch location.type {
                        case TipoPonto.pontoEncontro:
                            Button {
                                sheetEncontro = true
                            } label: {
                                Image(systemName: "pin.fill")
                            }
                            .sheet(isPresented: $sheetEncontro){
                                EncontroView(location: location).presentationDetents([.height(400),.medium,.large]).presentationDragIndicator(.automatic)
                            }
                        case TipoPonto.pontoEvento:
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
                        case TipoPonto.pontoFixo:
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
            }.task{
                await viewModel.getLocations()
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
