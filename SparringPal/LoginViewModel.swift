//
//  LoginViewModel.swift
//  SparringPal
//
//  Created by Erick Soto on 4/22/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var newaccount = Useraccount()
    @Published var isButtonPressed = false
    @Published var showingProgressView = false
    @Published var showingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showingSuccessAlert = false
    
    func login() {
        Auth.auth().signIn(withEmail: newaccount.email, password: newaccount.password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                self.isButtonPressed = true
            }
        }
    }

    
//    func saveProfile() {
//        if isFormValid() {
//            showingProgressView = true
//            uploadContact()
//            isButtonPressed = true;
//
//        }
//    }
    
    private func isFormValid() -> Bool {
        if newaccount.email.isEmpty {
            showAlert(title: "Email Error", message: "email cannot be empty")
            return false
        }
        if newaccount.password.isEmpty {
            showAlert(title: "Password Error", message: "password cannot be empty")
            return false
        }
        return true
    }
    
//    private func uploadContact() {
//        let db = Firestore.firestore()
//        db.collection("Accounts").addDocument(data: newaccount.toDict()) { error in
//            if let error {
//                self.showAlert(title: "Network Error", message: error.localizedDescription)
//                return
//            }
//            self.showingSuccessAlert = true
//            self.showingProgressView = false
//        }
//    }
    
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingProgressView = false
        showingAlert = true
    }
}
