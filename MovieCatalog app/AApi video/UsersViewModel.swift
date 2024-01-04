//
//  UsersViewModel.swift
//  MovieCatalog app
//
//  Created by Diego Santamaria on 29/12/23.
//

import Foundation

final class UsersViewModel: ObservableObject {
    
    
    @Published var users: [User] = []
    
    func fetchUsers() {
        let userUrlString = "https://jsonplaceholder.typicode.com/users"

        NetworkingManager.shared.request(userUrlString, type: [User].self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users = users  // This line updates the users array
                case .failure(let error):
                    // Handle the error appropriately
                    print(error)
                }
            }
        }
    }

}


