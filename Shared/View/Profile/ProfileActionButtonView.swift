//
//  ProfileActionButtonView.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import SwiftUI

struct ProfileActionButtonView: View {
    @ObservedObject var viewModel: ProfileViewModel
    var isFollowingUser: Bool { return viewModel.user.isFollowed ?? false}
    @State var showEditProfile = false
    
    var body: some View {
        HStack {
            Spacer()
            if(viewModel.user.isCurrentUser) {
                Button(action: { showEditProfile.toggle() }, label: {
                    Text("Edit Profile")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 280, height: 32)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 1))
                }).sheet(isPresented: $showEditProfile){
                    EditProfileView(user: $viewModel.user)
                }

            } else {
                Button(action: {isFollowingUser ? viewModel.unfollow() : viewModel.follow()}, label: {
                        Text(isFollowingUser ? "Following" : "Follow")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(isFollowingUser ? .black: .white)
                            .frame(width: 140, height: 32)
                            .overlay(RoundedRectangle(cornerRadius: 3)
                                        .stroke(Color.gray,
                                                lineWidth: isFollowingUser ? 1 : 0))
                    })
                .background(isFollowingUser ? Color.white : Color.blue)
                .cornerRadius(3)
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Message")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 140, height: 32)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.gray, lineWidth: 1))
                })
            }
            Spacer()
        }.padding(.top)
    }
}
