//
//  Constants.swift
//  PinkSocial
//
//  Created by Arthur Pasqualon on 03/10/21.
//

import Foundation
import SwiftUI
import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
