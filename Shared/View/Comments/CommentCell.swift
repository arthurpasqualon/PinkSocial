//
//  CommentsCell.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 14/10/21.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    let comment: Comment
    
    init(comment: Comment){
        self.comment = comment
    }
    
    var body: some View {
        HStack {
            KFImage(URL(string: comment.profileImageUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            Text(comment.username)
                .font(.system(size: 14, weight: .semibold)) +
            Text(" \(comment.commentText)")
                .font(.system(size: 14))
            
            Spacer()
            
            Text(" \(comment.timestampString ?? "")")
                .foregroundColor(.gray)
                .font(.system(size: 12))

        }.padding(.horizontal)
    }
}
