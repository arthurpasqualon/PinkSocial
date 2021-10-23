//
//  ProfileView.swift
//  SwiftUIClass (iOS)
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User){
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 32){
                ProfileHeaderView(viewModel: viewModel).padding()
                PostGridView(config: .profile(user.id ?? ""))
            }.padding(.top)
        }
    }
}
