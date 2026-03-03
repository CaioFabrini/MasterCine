//
//  SUProfileViewModel.swift
//  MasterCine
//
//  Created by Marcello Pontes Domingos on 03/03/26.
//


import SwiftUI
import FirebaseFirestore
import FirebaseAuth

final class SUProfileViewModel: ObservableObject {
    
    @Published var profile: ProfileModel?
    @Published var isEditing = false
    
    private let db = Firestore.firestore()
    private let collection = "profiles"
    
    func loadProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection(collection).document(uid).getDocument { snapshot, error in
            
            guard let data = snapshot?.data(),
                  let jsonData = try? JSONSerialization.data(withJSONObject: data),
                  let decoded = try? JSONDecoder().decode(ProfileModel.self, from: jsonData)
            else { return }
            
            DispatchQueue.main.async {
                self.profile = decoded
            }
        }
    }
    
    func saveProfile() {
        guard let uid = Auth.auth().currentUser?.uid,
              let profile else { return }
        
        guard let data = try? JSONEncoder().encode(profile),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else { return }
        
        db.collection(collection).document(uid).setData(dictionary)
    }
}
