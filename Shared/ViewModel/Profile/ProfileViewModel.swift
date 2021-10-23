//
//  ProfileViewModel.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 12/10/21.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    func follow(){
        guard let uid = user.id else { return }
        UserService.follow(uid: uid) { _ in
            print("Successfully Followed \(self.user.username)")
            NotificationsViewModel.uploadNotification(toUid: uid, type: .follow)
            self.user.isFollowed = true
        }
    }
    
    func unfollow(){
        guard let uid = user.id else { return }
        UserService.unfollow(uid: uid) { _ in
            print("Successfully Unfollowed \(self.user.username)")
            self.user.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed(){
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        
        UserService.checkIfUserIsFollowed(uid: uid) {isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    func fetchUserStats(){
        guard let uid = user.id else { return }

        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments{snapshot, _ in
            guard let following = snapshot?.documents.count else { return }
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments{snapshot, _ in
                guard let followers = snapshot?.documents.count else { return }
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments{snapshot, _ in
                        guard let posts = snapshot?.documents.count else { return }
                    
                    self.user.stats = UserStats(followers: followers, following: following, posts: posts)
                }
            }
            
        }
        

    }
}
