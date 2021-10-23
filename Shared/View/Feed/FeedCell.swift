//
//  FeedCell.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    var didLike: Bool { return viewModel.post.didLike ?? false}
    
    init(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                KFImage(URL(string: viewModel.post.ownerImageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                Text(viewModel.post.ownerUsername)
                    .font(.system(size: 14, weight: .semibold))
            }.padding([.leading, .bottom], 8)
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 440)
                .clipped()
            HStack(spacing: 16) {
                Button(action: {
                    didLike ? viewModel.deslike() : viewModel.like()
                }, label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(didLike ? .red : .black)
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })
                NavigationLink(destination: CommentsView(post: viewModel.post), label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .font(.system(size: 20))
                        .padding(4)
                })
            }
            .foregroundColor(.black)
            .padding(.leading, 4)
            Text(viewModel.likeString)
                .font(.system(size: 14, weight: .bold))
                .padding(.leading, 8)
                .padding(.bottom, 2)
            HStack() {
                Text(viewModel.post.ownerUsername).font(.system(size: 18, weight: .semibold)) + Text(" \(viewModel.post.caption)").font(.system(size: 15))
            }.padding(.horizontal, 8)
            Text(viewModel.timestampString)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading, 8)
        }
        
    }
}
