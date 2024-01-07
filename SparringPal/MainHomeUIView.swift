//
//  MainHomeUIView.swift
//  SparringPal
//
//  Created by Erick Soto on 4/11/23.
//

import SwiftUI
import Foundation
import CoreLocation
import Combine
import MapKit

struct HomeView: View {
    @StateObject private var usersListViewModel = UsersListViewModel()
    let previewCoordinate = CLLocationCoordinate2D(latitude: 43.00, longitude: -75.00) //shows preview of map of new york
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    Text("Find gyms near you")
                    Spacer()
                    
                    NavigationLink(destination: MapUIView(name: "Dallas", cityImage: Image("Downtown-Phoenix"), description: "desc", coordinate: previewCoordinate)) {
                        VStack {
                            Map(coordinateRegion: .constant(MKCoordinateRegion(center: previewCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))), interactionModes: [])
                                .frame(width: 350, height: 150)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }
                    
                    Text("New Users")
                    Spacer()
                    
                    List(usersListViewModel.users) { user in
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text("Height: \(user.height) inches")
                            Text("Weight: \(user.weight) lbs")
                            Text("Experience Level: \(user.expLvl)")
                            Text("Age: \(user.age)")
                        }
                    }
                    .onAppear(perform: usersListViewModel.fetchLastTenUsers)
                    //.navigationTitle("Last 10 Users")
                    //Spacer()
                    NavigationLink(destination: SafteyTipsUIView()) {
                        Text("Boxing News")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
    
                    
                }
                
            }
            .navigationTitle("Home")
        }
    }
}


struct MessagesView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color.red
                
            }
            .navigationTitle("Messages")
        }
    }
}

struct ProfileView: View {
    let user: User
    var body: some View {
        NavigationView {
            ZStack{
                Color.red
                VStack(alignment: .leading) {
                    Text("Name: \(user.name) ")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color.black)
                    Spacer()
                                Text("Fighter Info:")
                                Text("Height: \(user.height) inches")
                                Text("Weight: \(user.weight) lbs")
                                Text("Experience Level: \(user.expLvl)")
                                Text("Age: \(user.age)")
                                Text("Profile Bio: \(user.profBio)")
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle("My Profile", displayMode: .inline)

        }
    }
}

struct MainHomeUIView: View {
    var createdUser: User?
        
        init(createdUser: User? = nil) {
            self.createdUser = createdUser
        }
    
    var body: some View {
       
            TabView{
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                MessagesView()
                    .tabItem {
                        Image(systemName: "message.circle")
                        Text("Messages")
                    }
                
                ProfileView(user: createdUser ?? User())
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("Profile")
                    }
            }
        
       
            .navigationViewStyle(StackNavigationViewStyle())
                    .navigationBarBackButtonHidden(true)
    }
    
}

struct MainHomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeUIView()
    }
}
