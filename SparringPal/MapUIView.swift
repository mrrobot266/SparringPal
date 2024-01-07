//
//  MapUIView.swift
//  SparringPal
//
//  Created by Erick Soto on 4/22/23.
//

import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUI

struct MapUIView: View {
    
    @ObservedObject var viewModel = MapViewModel()
    
    
    var name: String
    var cityImage: Image
    var description: String
    var coordinate: CLLocationCoordinate2D
    
    init(name: String, cityImage: Image, description: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.cityImage = cityImage
        self.description = description
        self.coordinate = coordinate
        //viewModel.forwardGeocoding(addressStr: name)
    }
    
    var body: some View {
        Text(name)
        VStack {
            Map(coordinateRegion: $viewModel.region, interactionModes: .all, showsUserLocation: true, 
                annotationItems: viewModel.markers
            ){ location in
                MapAnnotation(coordinate: location.coordinate){
                    VStack{
                        Text(location.name)
                        Image("mapmarker")
                            .resizable()
                            .frame(width: 20, height: 24)
                    }
                }
            }
            .onAppear {
                //viewModel.forwardGeocoding(addressStr: name)
                viewModel.searchLocation()
                viewModel.checkIflocationservicesenabled()
            }
            Spacer()
            
            Spacer()
            
            Text("Longitude: \(viewModel.longitude)")
            
            Text("Latitude: \(viewModel.latitude)")
            
            
        }
    }
    
}


struct MapUIView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            MapUIView(name: "New York", cityImage: Image("Downtown-Phoenix"), description: "desc", coordinate: CLLocationCoordinate2D(latitude: 43.00, longitude: -75.00))
        }
        
    }
}
