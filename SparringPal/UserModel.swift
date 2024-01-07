//
//  UserModel.swift
//  SparringPal
//
//  Created by Erick Soto on 4/19/23.
//
import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var height: String
    var weight: String
    var expLvl: String
    var age: String
    var profBio: String
    var created_at: Date?
    
    // initializer used while creating a new contact
    init() {
        id = ""
        name = ""
        height = ""
        weight = ""
        expLvl = ""
        age = ""
        profBio = ""
        created_at = Date()
    }
    
    // initializer used when parsing data received from firestore
    init(id: String, data: [String: Any]) {
        self.id = id
        self.name = data["name"] as! String
        self.height = (data["height"] as? String) ?? ""
        self.weight = (data["weight"] as? String) ?? ""
        self.expLvl = (data["expLvl"] as? String) ?? ""
        self.age = (data["age"] as? String) ?? ""
        self.profBio = (data["profBio"] as? String) ?? ""
        self.created_at = (data["created_at"] as? Timestamp)?.dateValue() ?? Date()
    }
    
    // utility function used when uploading a new contact to firestore
    func toDict() -> [String: Any] {
        [
            "name": name,
            "height": height,
            "weight": weight,
            "expLvl": expLvl,
            "age": age,
            "profBio": profBio,
            "created_at": created_at
        ]
    }
}



struct Useraccount: Identifiable {
    var id: String
    var email: String
    var password: String
    
    // initializer used while creating a new contact
    init() {
        id = ""
        email = ""
        password = ""
    }
    
    // initializer used when parsing data received from firestore
    init(id: String, data: [String: Any]) {
        self.id = id
        self.email = data["email"] as! String
        self.password = data["password"] as! String
        }
    
    // utility function used when uploading a new contact to firestore
    func toDict() -> [String: Any] {
        [
            "email": email,
            "password": password
        ]
    }
}

//enum PhoneType: String, CaseIterable {
//    case home
//    case mobile
//    case work
//}
