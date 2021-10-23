//
//  EditProfileViewModel.swift
//  PinkSocial
//
//  Created by Arthur Pasqualon on 23/10/21.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    var user: User
    @Published var editedProfile = false
    init(user: User){
        self.user = user
    }
    
    func saveUserData(_ bioText: String) {
        guard let uid = user.id else { return }
        COLLECTION_USERS.document(uid).updateData(["bio": bioText]){_ in
            self.user.bio = bioText
            self.editedProfile = true
        }
    }
}
