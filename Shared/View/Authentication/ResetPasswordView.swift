//
//  ResetPasswordView.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 29/09/21.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var email: String
    @Environment(\.presentationMode) var mode

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
                Image("instagram-logo")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 200, height: 100)
                    .foregroundColor(.white)
            
                VStack(spacing: 20){
                    CustomTextField(text: $email, placeholder: Text("Email"), imgName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                }.padding()
                
                Button (action: {viewModel.resetPassword(withEmail: email)}, label: {
                    Text("Reset Password")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 240, height: 50)
                        .background(Color("primary"))
                        .clipShape(Capsule())
                        .padding()

                })
                
                Spacer()
                
                Button (action:{mode.wrappedValue.dismiss()}, label: {
                    HStack{
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 16)
                })

            }
        }.onReceive(viewModel.$didResetPassword, perform: {_ in
            self.mode.wrappedValue.dismiss()
        })
    }
}
