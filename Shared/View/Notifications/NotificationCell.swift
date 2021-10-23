//
//  NotificationCell.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    
    @ObservedObject var viewModel: NotificationCellViewModel
    var isFollowed: Bool { return viewModel.notification.isFollowed ?? false}

    init(notification: Notification) {
        self.viewModel = NotificationCellViewModel(notification: notification)
    }
    

    
    @State private var showPostImage = true
    
    var body: some View {
        HStack{
            if let user = viewModel.notification.user {
                NavigationLink(destination: ProfileView(user: user), label: {
                KFImage(URL(string: viewModel.notification.profileImageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Text(viewModel.notification.username).font(.system(size: 14, weight: .semibold)) + Text(viewModel.notification.type.notificationMessage).font(.system(size: 15)) +
                    Text(" \(viewModel.timestampString)").foregroundColor(.gray).font(.system(size: 12))
                })
                
            }
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    NavigationLink(destination: FeedCell(viewModel: FeedCellViewModel(post: post)), label: {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .clipped()
                    })
                }
            } else {
                Button(action: {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                }, label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 100, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white : Color(.systemBlue))
                        .cornerRadius(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        )
                    
                })
            }
        }.padding(.horizontal)
    }
}
