//
//  AuthViewModel.swift
//  PinkSocial
//
//  Created by Arthur Pasqualon on 01/10/21.
//

import Foundation
import Firebase
import UIKit

class AuthViewModel: ObservableObject {
    @Published var userSession: Firebase.User?
    @Published var currentUser: User?
    @Published var didResetPassword = false
    
    static let shared = AuthViewModel()
    
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){result, error in
            if let error = error{
                print("DEBUG: Login failed \(error.localizedDescription)")
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
        print("Succesfully authenticated user.")
    }
    
    func register(withEmail email: String, password: String, image: UIImage?, fullName: String, username: String) {
        
        guard let image = image else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile){ imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) {
                result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let user = result?.user else { return }
                print("Succesfully registered user.")
                
                let data = ["email": email, "username": username, "fullName": fullName,  "profileImageUrl": imageUrl, "uid": user.uid]
                
                COLLECTION_USERS.document(user.uid).setData(data) { _ in
                    print("Succesfully uploaded user data.")
                    self.userSession = user
                    self.fetchUser()
                }
        }}
        
    }
    func signout() {
        self.userSession = nil
        self.currentUser = nil
        try? Auth.auth().signOut()
        print("Signout user.")

    }
    func resetPassword(withEmail email: String){
        Auth.auth().sendPasswordReset(withEmail: email){error in
            if let error = error {
                print("Failed to send link with \(error.localizedDescription)")
            }
            self.didResetPassword = true
            
        }

    }
    func fetchUser() {
        
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS
            .document(uid)
            .getDocument{snapshot, _ in
                guard let user = try? snapshot?.data(as: User.self) else { return }
                self.currentUser = user
                print("User is: \(user)")
            }

    }
    
}
