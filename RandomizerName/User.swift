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
}
