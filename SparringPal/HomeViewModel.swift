//
//  HomeViewModel.swift
//  SparringPal
//
//  Created by Erick Soto on 4/22/23.
//

import Foundation
import FirebaseFirestore

class UsersListViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func fetchLastTenUsers() {
        let db = Firestore.firestore()
        
        db.collection("Users")
            .order(by: "created_at", descending: true)
            .limit(to: 10)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching last 10 users: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else { return }
                
                self.users = documents.compactMap { document in
                    try? document.data(as: User.self)
                }
            }
    }
}
