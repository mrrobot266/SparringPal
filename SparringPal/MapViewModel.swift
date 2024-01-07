//
//  MapViewModel.swift
//  SparringPal
//
//  Created by Erick Soto on 4/22/23.
//

import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var searchText = "gym"
    @Published var longitude: Double = 0.0
    @Published var latitude: Double = 0.0
    @Published var region = MKCoordinateRegion()
    @Published var markers: [Location] = []
    @Published var coordinate = CLLocationCoordinate2D()
    
    private var locationManager: CLLocationManager?
    
    override init() {
        //locationManager = CLLocationManager()
        super.init()
       // setupLocationManager()
        setupDefaultLocation()
    }
    
//    init() {
//        setupDefaultLocation()
//    }
    
    func checkIflocationservicesenabled(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            //checkLocationAuthorization()
            locationManager!.delegate = self
            
        }else {
            print("Location Services Need to be turned on.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("location is restricted")
        case .denied:
            print("you have denied app location permissions")
        case .authorizedAlways, .authorizedWhenInUse:
            if let locationCoordinate = locationManager.location?.coordinate {
                       self.region = MKCoordinateRegion(center: locationCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                   }
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
//    private func setupLocationManager() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            locationManager.stopUpdatingLocation()
//
//            DispatchQueue.main.async {
//                self.region.center = location.coordinate
//                self.latitude = location.coordinate.latitude
//                self.longitude = location.coordinate.longitude
//                print("*****************USER LOCATION WAS FOUND**************")
//            }
//        }
//    }

    func setupDefaultLocation() {
        let defaultLocation = CLLocationCoordinate2D(latitude: 43.00, longitude: -75.00)
        region = MKCoordinateRegion(center: defaultLocation, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        markers = [Location(name: "New York", coordinate: defaultLocation)]
    }
    
    
    func forwardGeocoding(addressStr: String)
    {
        let geoCoder = CLGeocoder();
        let addressString = addressStr
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
                                            {(placemarks, error) in
            
            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                print(coords.latitude)
                print(coords.longitude)
                self.longitude = coords.longitude
                self.latitude = coords.latitude
                
                
                DispatchQueue.main.async
                    {
                        self.region.center = coords
                        self.markers[0].name = placemark.locality!
                        self.markers[0].coordinate = coords
                    }
            }
        })
        
        
    }
    
    func ReverseGeocoding(lon: String, lat: String)
    {
           var loca:String = "test"
           let geoCoder = CLGeocoder();
           let latAsString = lat
           let latVal = Double(latAsString)
        
           let lngAsString = lon
           let lngVal = Double(lngAsString)

            // Create Location
            let location = CLLocation(latitude: latVal!, longitude: lngVal!)

            // Geocode Location
              geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
                // Process Response
                //self.processResponse(withPlacemarks: placemarks, error: error)
                  
                  if let error = error {
                          print("Unable to Reverse Geocode Location (\(error))")
                          loca = "Unable to Find Address for Location"

                      } else {
                          if let placemarks = placemarks, let placemark = placemarks.first {
                              let location = placemark.name
                              print(placemark.country)
                              print(placemark.locality)
                          } else {
                              let noLocation = "No Matching Addresses Found"
                              print(noLocation)
                          }
                      }
            }
        
        
    }

    
    func searchLocation() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        searchRequest.region = region
        
        MKLocalSearch(request: searchRequest).start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            self.region = response.boundingRegion
            self.markers = response.mapItems.map { item in
                Location(
                    name: item.name ?? "",
                    coordinate: item.placemark.coordinate
                )
            }
        }
    }
}
