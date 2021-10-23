//
//  LoggingView.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 29/09/21.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView{
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
                            .padding(.horizontal, 32)

                        CustomSecureField(text: $password, placeholder: Text("Password"))
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                    }
                    HStack{
                        Spacer()
                        NavigationLink(destination: ResetPasswordView(email: $email), label: {
                            Text("Forgot password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                                .padding(.trailing, 20)
                        })
                    
                }
                    
                    Button (action: { viewModel.login(withEmail: email, password: password) }, label: {
                        Text("Sign in")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 240, height: 50)
                            .background(Color("primary"))
                            .clipShape(Capsule())
                            .padding()

                    })
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView().navigationBarHidden(true)
                    } label: {
                        HStack{
                            Text("Dont have an account?")
                                .font(.system(size: 14))
                            Text("Sign Up")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.bottom, 16)
                    }

                }.padding(.top, -44)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
