//
//  SignupUIView.swift
//  SparringPal
//
//  Created by Erick Soto on 3/22/23.
//

import SwiftUI

struct SignupUIView: View {
    @StateObject private var vm = SignupViewModel();
    @State private var navigateToAddProfile = false
    
    var body: some View {
        VStack{
            Spacer()
            Text("Sign Up")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color.red)

            
            Spacer()
            TextField("Enter Username", text: $vm.newaccount.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter Password", text: $vm.newaccount.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            
            if vm.showingProgressView { // progressview will keep going after signing up.
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                NavigationLink(
                    destination: AddProfileUIView(),
                    isActive: $vm.isButtonPressed,
                    label: { EmptyView() }
                )
                
            } else {
                NavigationLink(
                    destination: AddProfileUIView(),
                    isActive: $vm.isButtonPressed,
                    label: { EmptyView() }
                )

                Button("Sign Up", action: {
                    vm.saveProfile()
                    vm.register()
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
        
        
        
    }
}
    
    struct SignupUIView_Previews: PreviewProvider {
        
        static var previews: some View {
            NavigationView {
                SignupUIView()
                    .background(Color(red: 139/255, green: 0/255, blue: 0/255))
            }
        }
    }

