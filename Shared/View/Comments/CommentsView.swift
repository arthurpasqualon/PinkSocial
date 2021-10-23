//
//  CommentsView.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 14/10/21.
//

import SwiftUI

struct CommentsView: View {
    
    @State var inputText = ""
    @ObservedObject var viewModel: CommentViewModel

    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 24){
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }
            }.padding(.top)
            CustomInputView(inputText: $inputText, action: uploadComment)
        }
    }
    
    func uploadComment() {
        viewModel.uploadComment(commentText: inputText)
        inputText = ""
    }
}

