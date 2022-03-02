//
//  NamesVM.swift
//  RandomizerName
//
//  Created by Ryan Plitt on 3/2/22.
//

import Foundation

class NamesViewModel: ObservableObject {
    @Published var names = User.sample
    @Published var randomUser: User?
    
    func selectRandomUser() {
        randomUser = names.randomElement()
    }
    
    func add(userWithName name: String) {
        guard !name.isEmpty else { return }
        names.append(User(name: name))
    }
}
