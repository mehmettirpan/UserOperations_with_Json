//
//  NetworkManager.swift
//  UserOperations_with_Json
//
//  Created by Mehmet Tırpan on 12.07.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func fetchUsers(completion: @escaping ([User]?) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(users)
            } catch {
                print("Error decoding users: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
