//
//  Post.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 12/10/21.
//

import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?

    let ownerUid: String
    let ownerUsername: String
    let ownerImageUrl: String
    let caption: String
    let imageUrl: String
    let timestamp: Timestamp
    
    var likes: Int
    var didLike: Bool? = false
}
