//
//  PostViewModel.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 12/10/21.
//

import Foundation
import Firebase
import UIKit

class UploadPostViewModel: ObservableObject {
    func uploadPost(caption: String, image: UIImage, completion: FirestoreCompletion) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        ImageUploader.uploadImage(image: image, type: .post){ imageUrl in
            let data = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "ownerUid": user.id ?? "",
                "imageUrl": imageUrl,
                "ownerImageUrl": user.profileImageUrl,
                "ownerUsername": user.username,
            ] as [String : Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
}
