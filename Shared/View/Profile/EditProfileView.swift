//
//  EditProfileView.swift
//  PinkSocial
//
//  Created by Arthur Pasqualon on 23/10/21.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject private var viewModel: EditProfileViewModel
    @Environment(\.presentationMode) var mode
    @Binding var user: User
    @State private var bioText: String

    
    init(user: Binding<User>) {
        self._user = user
        self._bioText = State(initialValue: _user.wrappedValue.bio ?? "")
        self.viewModel = EditProfileViewModel(user: _user.wrappedValue)
    }
    
    
    var body: some View {
        ZStack(alignment: .topLeading){
            VStack {
                HStack{
                    Button(action: { mode.wrappedValue.dismiss() }, label: {
                        Text("Cancel")
                    })
                    Spacer()
                    Button(action: { viewModel.saveUserData(bioText) }, label: {
                        Text("Done").bold()
                    })
                }.padding()
                
                TextArea(text: $bioText, placeholder: "Add your bio...")
                    .frame(width: SCREEN_WIDTH, height: 100)
                    .padding()
                Spacer()
            }
            
        }.onReceive(viewModel.$editedProfile, perform: { completed in
            if completed {
                self.mode.wrappedValue.dismiss()
                self.user.bio = viewModel.user.bio
            }
        })
    }
}
