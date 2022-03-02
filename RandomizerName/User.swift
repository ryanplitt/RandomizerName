//
//  User.swift
//  RandomizerName
//
//  Created by Ryan Plitt on 3/2/22.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let name: String
    
    init(name: String, id: UUID = UUID()) {
        self.name = name
        self.id = id
    }
    
    static let sample = [User(name: "Ryan"), User(name: "Mandy"), User(name: "Ryan E"), User(name: "Britany")]
}
