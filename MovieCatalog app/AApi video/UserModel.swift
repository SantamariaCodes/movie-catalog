//
//  UserModel.swift
//  MovieCatalog app
//
//  Created by Diego Santamaria on 29/12/23.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let company: Company
    
}

struct Company : Codable {
    let name: String
}
