//
//  SwiftUIClassApp.swift
//  Shared
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import SwiftUI
import Firebase

@main
struct SwiftUIClassApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
