import SwiftUI
import MapKit
import CoreLocation

 
struct MapView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -18.9190014,longitude: -48.2621052),
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
                Map(coordinateRegion: $region, annotationItems: viewModel.locations){location in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.localization!.x!,longitude: location.localization!.y!)){
                        switch location.type {
                        case TipoPonto.pontoEncontro:
                            Button {
                                sheetEncontro = true
                            } label: {
                                Image(systemName: "pin.fill")
                            }
                            .sheet(isPresented: $sheetEncontro){
                                EncontroView().presentationDetents([.height(200),.medium,.large]).presentationDragIndicator(.automatic)
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
                                EventoView().presentationDetents([.height(200),.medium,.large]).presentationDragIndicator(.automatic)
                            }
                        case TipoPonto.pontoFixo:
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
                }
            }.task{
                await viewModel.getLocations()
            }
            
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
