//
//  SearchViewModel.swift
//  PinkSocial
//
//  Created by Arthur Pasqualon on 03/10/21.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()

    init() {
        fecthUsers()
    }
    
    func fecthUsers() {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self )})            
        }
    }

    func filteredUsers(_ query: String) -> [User] {
        let lowerCasedQuery = query.lowercased()
        return users.filter({
            $0.fullName.lowercased().contains(lowerCasedQuery) ||
            $0.username.lowercased().contains(lowerCasedQuery)
        })
    }
}
