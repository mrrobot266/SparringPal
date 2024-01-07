//
//  LoginUIView.swift
//  SparringPal
//
//  Created by Erick Soto on 3/22/23.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct LoginUIView: View {
    //@Environment(\.dismiss) var dismiss
    
    @StateObject private var vm = LoginViewModel();
    @State private var navigateToAddProfile = false
    
    var body: some View {
        VStack{
            Spacer()
            Text("Login")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color.red)

            
            Spacer()
            TextField("Enter Email", text: $vm.newaccount.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter Password", text: $vm.newaccount.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            
            if vm.showingProgressView { // progressview will keep going after signing up.
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                NavigationLink(
                    destination: MainHomeUIView(),
                    isActive: $vm.isButtonPressed,
                    label: { EmptyView() }
                )
                
            } else {
                NavigationLink(
                    destination: MainHomeUIView(),
                    isActive: $vm.isButtonPressed,
                    label: { EmptyView() }
                )

                Button("Login", action: {
                    vm.login()
                })
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .center)

            }
            Spacer()
        }.padding()
            .alert(vm.alertTitle, isPresented: $vm.showingAlert) {
                Button("OK", role: .cancel) {
                    vm.showingAlert = false
                }
            } message: {
                Text(vm.alertMessage)
            }
            .alert("Success", isPresented: $vm.showingSuccessAlert) {
                Button("Done", role: .cancel) {
                    //dismiss()
                    
                    vm.showingSuccessAlert = false
                    //vm.isButtonPressed = true
                }
            } message: {
                Text("\(vm.newaccount.email) Thank you for signing up!")
            }

            //login()
      
            
            Spacer()
            
            
            NavigationLink("Create an account", destination: SignupUIView())
            
           
            
        }
        
    }
        


struct LoginUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoginUIView()
    }
}
