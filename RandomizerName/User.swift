//
//  User.swift
//  RandomizerName
//
//  Created by Ryan Plitt on 3/2/22.
//

import Foundation

struct User: Identifiable {
    let id: UUID = UUID()
    let name: String
    
    static let sample = [User(name: "Ryan"), User(name: "Mandy"), User(name: "Ryan E"), User(name: "Britany")]
}
