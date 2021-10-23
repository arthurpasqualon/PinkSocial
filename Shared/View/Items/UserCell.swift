//
//  UserCell.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 19/09/21.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    
    let user: User;
    
    var body: some View {
        HStack{
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading){
                Text(user.username)
                    .font(.system(size: 14, weight: .semibold))
                Text(user.fullName)
                    .font(.system(size: 14))
            }
            Spacer()
        }
        
    }
}
