//
//  CommentViewModel.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 14/10/21.
//

import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {
    
    private let post: Post
    @Published var comments = [Comment]()
    
    init(post: Post) {
        self.post = post
        fetchComments()
    }
    
    
    func uploadComment(commentText: String){
        guard let user = AuthViewModel.shared.currentUser else {return}
        guard let postId = post.id else {return}
        
        let data: [String: Any] = [
            "username": user.username,
            "profileImageUrl": user.profileImageUrl,
            "postOwnerUid": post.ownerUid,
            "commentText": commentText,
            "uid": user.id ?? "",
            "postId": postId,
            "timestamp": Timestamp(date: Date())
        ]
        
        COLLECTION_POSTS.document(postId).collection("comments").addDocument(data: data){error in
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }
            NotificationsViewModel.uploadNotification(toUid: self.post.ownerUid, type: .comments, post: self.post)
            
        }
    }
    
    func fetchComments(){
        guard let postId = post.id else {return}
        let query = COLLECTION_POSTS
            .document(postId)
            .collection("comments")
            .order(by: "timestamp", descending: true)
            

        query.addSnapshotListener {snapshot, _ in
            guard let addedDocuments = snapshot?.documentChanges.filter({ $0.type == .added}) else { return }
            self.comments.append(contentsOf: addedDocuments.compactMap({ try? $0.document.data(as: Comment.self)}))
        }
    }
    
    
}
