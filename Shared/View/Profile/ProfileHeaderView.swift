//
//  ProfileHeaderView.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(alignment: .leading){
            HStack {
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 72)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding(.leading)
                Spacer()
                
                HStack(spacing: 8) {
                    UserStatView(title: "Posts",value: viewModel.user.stats?.posts ?? 0)
                        UserStatView(title: "Followers", value: viewModel.user.stats?.followers ?? 0)
                        UserStatView(title: "Following", value: viewModel.user.stats?.following ?? 0)
                }.padding(.trailing, 24)
            }
            Text(viewModel.user.fullName)
                .font(.system(size: 15, weight: .semibold))
                .padding([.top, .leading])
            if let bio = viewModel.user.bio {
                Text(bio)
                    .font(.system(size: 15))
                    .padding(.leading)
                    .padding(.top, 1)
            }
            ProfileActionButtonView(viewModel: viewModel)
        }
    }
}
