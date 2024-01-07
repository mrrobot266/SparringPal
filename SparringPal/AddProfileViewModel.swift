//
//  AddProfileViewModel.swift
//  SparringPal
//
//  Created by Erick Soto on 4/21/23.
//

import Foundation
import FirebaseFirestore

class AddProfileViewModel: ObservableObject {
    @Published var newuser = User()
    @Published var createdUser: User?
    @Published var isButtonPressed = false
    @Published var showingProgressView = false
    @Published var showingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showingSuccessAlert = false
    
    func saveProfile() {
        if isFormValid() {
            showingProgressView = true
            uploadContact()
            isButtonPressed = true;
        }
    }
    
    private func isFormValid() -> Bool {
        if newuser.name.isEmpty {
            showAlert(title: "Name Error", message: "name cannot be empty")
            return false
        }
        if newuser.weight.isEmpty {
            showAlert(title: "Weight Error", message: "weight cannot be empty")
            return false
        }
        if newuser.expLvl.isEmpty {
            showAlert(title: "Experience Level Missing!", message: "Experience Level cannot be empty")
            return false
        }
        return true
    }
    
    private func uploadContact() {
        let db = Firestore.firestore()
        db.collection("Users").addDocument(data: newuser.toDict()) { error in
            
            if let error {
                self.showAlert(title: "Network Error", message: error.localizedDescription)
                return
            }
            self.showingSuccessAlert = true
            self.showingProgressView = false
            
            self.createdUser = self.newuser
           
        }
    }
    
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingProgressView = false
        showingAlert = true
    }
}
