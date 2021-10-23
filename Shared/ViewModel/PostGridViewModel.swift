//
//  PostGridViewModel.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 12/10/21.
//

import Foundation


enum PostGridFilter {
    case profile(String)
    case explore
}

class PostGridViewModel: ObservableObject {
    @Published var posts = [Post]()
    let config: PostGridFilter
    
    init(config: PostGridFilter) {
        self.config = config
        fetchPosts(forConfig: config)
    }
    
    func fetchPosts(forConfig config: PostGridFilter) {
        
        switch config {
        case .explore: fetchExplorePosts()
        case .profile(let uid): fetchUserPosts(forUid: uid)
        }
        
    }
    
    func fetchExplorePosts() {
        COLLECTION_POSTS
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self )})
        }
    }
    
    func fetchUserPosts(forUid userId: String) {
        COLLECTION_POSTS
            .whereField("ownerUid", isEqualTo: userId)
            .getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.compactMap({ try? $0.data(as: Post.self )})
                self.posts = posts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue()})
        }
    }
    
    
}
