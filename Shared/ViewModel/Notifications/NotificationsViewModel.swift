//
//  NotificationsViewModel.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 19/10/21.
//

import SwiftUI
import Firebase

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchNotifications()
    }
    
    func fetchNotifications(){
        guard let uid = AuthViewModel.shared.currentUser?.id else { return }
        
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments{ snapshot, _ in
            
            guard let documents = snapshot?.documents else { return }
            self.notifications = documents.compactMap({ try? $0.data(as: Notification.self )})
        }
    }
    
    static func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil){
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard uid != user.id else { return }
        
        var data: [String: Any] = [
            "timestamp": Timestamp(date: Date()),
            "username": user.username,
            "uid": user.id ?? "",
            "profileImageURL": user.profileImageUrl,
            "type": type.rawValue
        ]
        print(post as Any)
        if let post = post, let id = post.id {
            data["postId"] = id
        }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").addDocument(data: data)
        
    }
}
