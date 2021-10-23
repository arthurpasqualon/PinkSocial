//
//  PostGridView.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    private let gridItems = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    
    let config: PostGridFilter
    @ObservedObject var viewModel: PostGridViewModel
    
    init(config: PostGridFilter) {
        self.config = config
        self.viewModel = PostGridViewModel(config: config)
    }
    
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 2, content: {
            ForEach(viewModel.posts, content: { post in
                NavigationLink(
                    destination: FeedCell(viewModel: FeedCellViewModel(post: post)),
                    label: {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: width)
                            .clipped()
                    })
            })
        })
    }
}
