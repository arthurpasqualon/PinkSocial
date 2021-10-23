//
//  RegistrationView.swift
//  SwiftUIClass
//
//  Created by Arthur Pasqualon on 29/09/21.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State var imagePickerPresented = false
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
                
                ZStack{
                    if let profileImg = image {
                        profileImg
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                    } else {
                        Button(action:{imagePickerPresented.toggle()}, label:{
                            Image("plus")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFill()
                                .frame(width: 90, height: 90)
                                .foregroundColor(.white)
                        })
                            .sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                                ImagePicker(image: $selectedImage)
                            })
                    }
                }.padding()
                
            
                VStack(spacing: 20){
                    CustomTextField(text: $email, placeholder: Text("Email"), imgName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                    CustomTextField(text: $username, placeholder: Text("Username"), imgName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                    CustomTextField(text: $fullName, placeholder: Text("Full Name"), imgName: "envelope")
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
                
                Button (action: {
                    viewModel.register(withEmail: email, password: password, image: selectedImage, fullName: fullName, username: username) }, label: {
                    Text("Sign up")
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
        }
    }
}

extension RegistrationView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
