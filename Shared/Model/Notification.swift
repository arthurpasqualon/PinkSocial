//
//  Notification.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 19/10/21.
//

import Firebase
import FirebaseFirestoreSwift

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    
    var postId: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    
    var isFollowed: Bool? = false
    var post: Post?
    var user: User?

}

enum NotificationType: Int, Decodable {
    case like
    case comments
    case follow
    
    var notificationMessage: String {
        switch self {
            case .like: return " liked one of your posts"
            case .comments: return " commented one of your posts"
            case .follow: return " followed you"
        }
    }
}
