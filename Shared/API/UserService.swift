//
//  UserService.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 12/10/21.
//

import Firebase

typealias FirestoreCompletion = ((Error?) -> Void)?

struct UserService {
    
    static func follow(uid: String, completion:((Error?) -> Void)?){
        guard let currentUId = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUId)
            .collection("user-following")
            .document(uid)
            .setData([:]){ _ in
                COLLECTION_FOLLOWERS.document(uid)
                    .collection("user-followers")
                    .document(currentUId)
                    .setData(([:]), completion: completion)
            }
        
    }
    static func unfollow(uid: String, completion: FirestoreCompletion){
        guard let currentUId = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUId)
            .collection("user-following")
            .document(uid)
            .delete() { _ in
                COLLECTION_FOLLOWERS.document(uid)
                    .collection("user-followers")
                    .document(currentUId)
                    .delete(completion: completion)
            }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUId = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUId)
            .collection("user-following")
            .document(uid)
            .getDocument() { snapshot, _ in
                guard let isFollowed = snapshot?.exists else { return }
                completion(isFollowed)
            }
    }
}
