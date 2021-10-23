//
//  User.swift
//  PinkSocial
//
//  Created by Arthur Pasqualon on 03/10/21.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    let username: String
    let email: String
    let fullName: String
    let profileImageUrl: String    
    
    @DocumentID var id: String?
    var isFollowed: Bool? = false
    var stats: UserStats?
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id}
    var bio: String?
}


struct UserStats: Decodable {
    var followers: Int
    var following: Int
    var posts: Int
}
