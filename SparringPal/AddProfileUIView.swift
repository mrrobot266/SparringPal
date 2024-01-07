//
//  AddProfileUIView.swift
//  SparringPal
//
//  Created by Erick Soto on 3/22/23.
//

import SwiftUI
import FirebaseFirestore

struct AddProfileUIView: View {
    
    @StateObject private var viewmodel = AddProfileViewModel();
    
    var body: some View {
            VStack{
                Text("Add Profile")
                Spacer()
                TextField("Name", text: $viewmodel.newuser.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Height (inches)", text: $viewmodel.newuser.height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Weight (lbs)", text: $viewmodel.newuser.weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Experience Level (Rating 1-10)", text: $viewmodel.newuser.expLvl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Age", text: $viewmodel.newuser.age)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Profile Bio (Include Training Goals) ", text: $viewmodel.newuser.profBio)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                if viewmodel.showingProgressView {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                    NavigationLink(
                        destination: MainHomeUIView(createdUser: viewmodel.createdUser),
                        isActive: $viewmodel.isButtonPressed,
                        label: { EmptyView() }
                    )
                } else {
                    NavigationLink(
                        destination: MainHomeUIView(createdUser: viewmodel.createdUser),
                        isActive: $viewmodel.isButtonPressed,
                        label: { EmptyView() }
                    )

                    Button("Next", action: {
                        viewmodel.saveProfile()
                        
                    })
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .center)

                }
                
            }.padding()
            .alert(viewmodel.alertTitle, isPresented: $viewmodel.showingAlert) {
                Button("OK", role: .cancel) {
                    viewmodel.showingAlert = false
                }
            } message: {
                Text(viewmodel.alertMessage)
            }
            .alert("Success", isPresented: $viewmodel.showingSuccessAlert) {
                Button("Done", role: .cancel) {
                    //dismiss()
                    
                    viewmodel.showingSuccessAlert = false
                    //viewmodel.isButtonPressed = true
                }
            } message: {
                Text("\(viewmodel.newuser.name) was added to the database")
            }
        
        
    }
    
    
}


struct AddProfileUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddProfileUIView()
        }
        
    }
}
