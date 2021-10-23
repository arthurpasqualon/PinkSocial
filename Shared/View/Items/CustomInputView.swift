//
//  CustomInputView.swift
//  PinkSocial (iOS)
//
//  Created by Arthur Pasqualon on 14/10/21.
//

import SwiftUI

struct CustomInputView: View {
    @Binding var inputText: String
    var action: () -> Void
    
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding(.bottom, 8)
            HStack{
                TextField("Comment...", text: $inputText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                Button(action: action, label: {
                    Text("Send")
                        .bold()
                        .foregroundColor(.blue)
                })
            }.padding(.bottom, 8).padding(.horizontal)
        }
        
    }
}
