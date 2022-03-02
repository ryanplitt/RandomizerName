//
//  NamesVM.swift
//  RandomizerName
//
//  Created by Ryan Plitt on 3/2/22.
//

import Foundation

class NamesViewModel: ObservableObject {
    @Published var names: [User] = [] {
        didSet {
            save(users: names)
        }
    }
    private(set) var randomUsers: [User] = []
    
    init() {
        load { [weak self] result in
            if case .success(let users) = result {
                self?.names = users
            }
        }
    }
    
    func selectRandomUsers(numberOfUsers n: Int) {
        randomUsers = Array<User>(names.shuffled().prefix(n))
    }
    
    func add(userWithName name: String) {
        guard !name.isEmpty else { return }
        names.append(User(name: name))
    }
}

extension NamesViewModel {
    private func fileURL() throws -> URL {
            try FileManager.default.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: false)
                .appendingPathComponent("User.data")
        }
        
        private func load(completion: @escaping (Result<[User], Error>)->Void) {
            DispatchQueue.global(qos: .background).async {
                do {
                    let fileURL = try self.fileURL()
                    guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                        DispatchQueue.main.async {
                            completion(.success([]))
                        }
                        return
                    }
                    let dailyScrums = try JSONDecoder().decode([User].self, from: file.availableData)
                    DispatchQueue.main.async {
                        completion(.success(dailyScrums))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        private func save(users: [User]) {
            DispatchQueue.global(qos: .background).async {
                do {
                    let data = try JSONEncoder().encode(users)
                    let outfile = try self.fileURL()
                    try data.write(to: outfile)
                } catch {
                    print("Something broke")
                }
            }
        }
}
