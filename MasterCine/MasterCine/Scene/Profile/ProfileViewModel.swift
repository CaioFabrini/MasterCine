//
//  ProfileViewModel.swift
//  MasterCine
//
//  Created by Marcello Pontes Domingos on 01/03/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


final class ProfileViewModel {

    private let db = Firestore.firestore()
    private let collection = "profiles"

    func getProfile(completion: @escaping (Result<ProfileModel?, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.success(nil))
            return
        }

        db.collection(collection).document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = snapshot?.data() else {
                completion(.success(nil))
                return
            }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data)
                let profile = try JSONDecoder().decode(ProfileModel.self, from: jsonData)
                completion(.success(profile))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func saveProfile(_ profile: ProfileModel,
                     completion: @escaping (Result<Void, Error>) -> Void) {

        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "NoUserLogged", code: 401)))
            return
        }

        do {
            let data = try JSONEncoder().encode(profile)
            let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]

            db.collection(collection).document(uid).setData(dictionary) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
